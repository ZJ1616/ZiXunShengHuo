//
//  NewsViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsArticleModel.h"
#import "MJExtension.h"
#import "ZJHttpTool.h"
#import "NewsBottomView.h"
#import "HomeHeadModel.h"
#import "DatabaseTool.h"
#import "CommentView.h"
#import <Social/Social.h>
#import "UIImageView+WebCache.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface NewsViewController () <NewsBottomViewDelegate,CommentViewDelegate>
/** 浏览器控件 */
@property (nonatomic ,strong) UIWebView * webView;
/** 详情页面的一个数据模型 */
@property (nonatomic ,strong) NewsArticleModel * articleModel;
@property (nonatomic, strong) CommentView * commentView;
@property (nonatomic, strong) NewsBottomView * newsBottomView;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建界面
    [self createUI];
    //下载数据
    [self downloadData];

    
}

- (void)createUI
{
    self.title = @"详情";
    //底部标签栏
    [self createBottomView];
    //浏览器控件
    [self createWebView];
}

/** 创建底部标签栏 */
- (void)createBottomView
{
    NewsBottomView * bottomView = [[NewsBottomView alloc] initWithFrame:CGRectMake(0, Screen_Height-48, Screen_Width, 48)];
    bottomView.delegate = self;
    //bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.isSelect = [DatabaseTool selectFavoriteDataIsExist:self.simpleModel];
    //ZJLog(@"%d",[DatabaseTool selectFavoriteDataIsExist:self.simpleModel]);
    [self.view addSubview:bottomView];
    self.newsBottomView = bottomView;
}
/** 创建浏览器 */
- (void)createWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-48)];
    [self.view addSubview:self.webView];
    
}

/** 下载数据 */
- (void)downloadData
{
    NSString * urlStr = self.simpleModel.articleUrl;
    if ([self isKindOfJsonString:urlStr]) {
        ZJLog(@"是html数据，直接加载");
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
        return;
    }
    ZJLog(@"%@",urlStr);
    
    [ZJHttpTool getWithURL:urlStr success:^(id responseObject) {
        ZJLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.articleModel = [NewsArticleModel mj_objectWithKeyValues:responseObject];
            [self performSelectorOnMainThread:@selector(loadWebView) withObject:nil waitUntilDone:NO];
        }
    } failure:^(NSError *error) {
        ZJLog(@"%@",error);
    }];
}
/** 加载页面 */
- (void)loadWebView
{
    NSMutableString * htmlStr = [NSMutableString stringWithString:self.articleModel.content];
    //处理字符串
    NSString * html = [self disposeHTMLStr:htmlStr];
    //将处理好的html展示到WebView上
    [self.webView loadHTMLString:html baseURL:nil];
    //添加到最近收藏
    [DatabaseTool addRecent:self.simpleModel];
 //<a href="http://www.baidu.com">查看原文</a>
}

/** 把图片资源拼接到HTML字符串里面 */
- (NSString *)disposeHTMLStr:(NSString *)htmlStr
{
    //取图片资源
    NSDictionary * imageDict = self.articleModel.articleMediaMap;
    
    
    //遍历图片字典
    for (NSString * key in imageDict) {
        NSDictionary * dict = [imageDict objectForKey:key];
        NSNumber * picW = dict[@"width"];
        NSNumber * picH = dict[@"hight"];
        CGFloat width = [UIScreen mainScreen].bounds.size.width-20;
        CGFloat proportion = [picW floatValue]/[picH floatValue];
        NSString *str = [NSString stringWithFormat:@"<img id=\"%@\" class=\"reader_img\" src=\"reader_img_src\" />",key];
        NSString * str2 = [NSString stringWithFormat:@"<img id=\"%@\" class=\"%@\" src=\"%@\" width=%lf height=%lf/>",key,dict[@"mediaType"],dict[@"url"],width,width*proportion];
        //替换html中的标签
        NSString * tempStr = [htmlStr stringByReplacingOccurrencesOfString:str withString:str2];
        NSMutableString * tempStrM = [NSMutableString stringWithString:tempStr];
        htmlStr = tempStrM;
    }
    //计算时间
    NSTimeInterval index = [self.articleModel.date integerValue]/1000;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:index+3600*8];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd HH:mm:ss";
    NSString * dataStr = [formatter stringFromDate:date];;
    
    NSString * html = [NSString stringWithFormat:@"<head><font style=\"font-size:20px;\">%@</font></head><p><img src=\"%@\"width=18 height=inf/><font style=\"font-size:13px;\">&nbsp%@&nbsp&nbsp&nbsp%@</font></p></p>%@<p align=right><a href=\"%@\">查看原文</a></p>",self.articleModel.title,self.articleModel.contentSourceLogo,self.articleModel.contentSourceName,dataStr,htmlStr,self.articleModel.sourceUrl];
    return html;
}

//判断网址字符串是不是.html结尾
- (BOOL)isKindOfJsonString:(NSString *)str
{
    if ([str rangeOfString:@".html"].length) {
        return YES;
    }
    return NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NewsBottomViewDelegate

- (void)clickCommentButton:(UIButton *)button
{
    ZJLog(@"点击了查看评论");
    if (button.isSelected == NO) {
        [self showCommentView];
        button.selected = YES;
        
    }else if (button.isSelected == YES){
        [self hideCommentView];
        button.selected = NO;
        
    }
}

- (void)showCommentView
{
    if (self.commentView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.commentView.frame = CGRectMake(0, 64, Screen_Width, self.webView.bounds.size.height);
        }];
    }else{
    CommentView * comView = [[CommentView alloc] initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, self.webView.bounds.size.height)];
    comView.articleId = self.articleModel.articleId;
        comView.delegate = self;
    self.commentView = comView;
    [self.view addSubview:comView];
    [self.view bringSubviewToFront:self.newsBottomView];
    [UIView animateWithDuration:0.3 animations:^{
        comView.frame = CGRectMake(0, 64, Screen_Width, self.webView.bounds.size.height);
    }];
    }
}

- (void)hideCommentView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.commentView.frame = CGRectMake(0, Screen_Height, Screen_Width, self.webView.bounds.size.height);
    }];
}

- (void)showNoCommentAlert
{
    [ZJAlertTool showMessage:@"此资讯暂时没有评论" target:self];
}

- (void)clickFavoriteButton:(UIButton *)button
{
    //收藏这条新闻
    if (button.isSelected) {
        button.selected = NO;
        [DatabaseTool deletFavoriteData:self.simpleModel];
    }else{
        button.selected = YES;
        ZJLog(@"点击了收藏");
        [DatabaseTool addFavorite:self.simpleModel];
    }
}

- (void)clickShareButton
{
    ZJLog(@"点击了分享");
    //1、创建分享参数
    NSArray* imageArray = self.simpleModel.imgUrlList;
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"【%@】%@",self.simpleModel.title,self.articleModel.sourceUrl]
                                         images:imageArray
                                            url:nil//[NSURL URLWithString:@"http://mob.com"]
                                          title:self.simpleModel.title//@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

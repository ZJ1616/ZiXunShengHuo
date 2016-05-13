//
//  SecondViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "SecondViewController.h"
#import "ChanneListModel.h"
#import "ChanneListView.h"
#import "MJExtension.h"
#import "ZJHttpTool.h"
#import "RssListViewController.h"
#import "SlideView.h"
#import "DatabaseTool.h"

@interface SecondViewController () <ChanneListViewDelegate,UIScrollViewDelegate>
/** 保存所有频道接口的模型数组 */
@property (nonatomic ,strong) NSArray * modelArray;
/** 自定制导航视图的背景View */
@property (nonatomic ,strong) UIView * headView;
/** 第二页的横向滚动视图 */
@property (nonatomic ,strong) UIScrollView * scrollView;
/** 颜色数组 */
@property (nonatomic ,strong) NSArray * colorArray;


@property (nonatomic ,strong) SlideView * slideView;



@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZJLog(@"%@",self.colorArray);
    //创建横向的滚动视图
    [self createScrollView];
    //下载数据
    [self downloadData];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  初始化数据
 */
- (NSArray *)modelArray
{
    if (_modelArray == nil) {
        _modelArray = [NSArray array];
    }
    return _modelArray;
}




/**
 *  下载数据
 */
- (void)downloadData
{
    
    NSString * url = AllChannelistUrl;
    [ZJHttpTool getWithURL:url success:^(id responseObject) {
        //下载成功
        self.modelArray = [ChanneListModel mj_objectArrayWithKeyValuesArray:responseObject];
        ZJLog(@"%ld",self.modelArray.count);
        //主线程任务
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadScrollViewUIData];
        });
    } failure:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return ;
        }
    }];
}

/**
 *  创建横向滚动视图
 */
- (void)createScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height-104-48)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
}

/**
 *  下载数据完成后 刷新横向滚动视图数据
 */
- (void)reloadScrollViewUIData
{
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*self.modelArray.count, self.scrollView.bounds.size.height);
    
    for (int i = 0; i < self.modelArray.count; i++) {
        ChanneListView * view = [[ChanneListView alloc] initWithFrame:CGRectMake(self.scrollView.bounds.size.width*i, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
        [self.scrollView addSubview:view];
        view.delegate = self;
        ChanneListModel * model = self.modelArray[i];
        view.listModel = model;
    }
    //标题滑动视图
    [self createSlideView];
    
}
//自定滑动导航
- (void)createSlideView
{
    self.slideView = [[SlideView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 104)];
    self.slideView.bgColor = self.colorArray[0];
    [self.view addSubview:self.slideView];
    
}

- (NSArray *)colorArray
{
    if (_colorArray == nil) {
        NSMutableArray * arrayM = [NSMutableArray array];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"color.plist" ofType:nil];
        NSArray * array = [NSArray arrayWithContentsOfFile:path];
        for (int i = 0; i < array.count; i++) {
            NSDictionary * dict = array[i];
            NSNumber * R = dict[@"R"];
            NSNumber * G = dict[@"G"];
            NSNumber * B = dict[@"B"];
            UIColor * color = [UIColor colorWithRed:R.floatValue/255.0 green:G.floatValue/255.0 blue:B.floatValue/255.0 alpha:1.0];
            ZJLog(@"%@",color);
            [arrayM addObject:color];
        }
        _colorArray = [NSArray arrayWithArray:arrayM];
    }
    return _colorArray;
}



#pragma mark ChanneListViewDelegate代理
- (void)clickChanneListButton:(RssListModel*)listModel
{
    RssListViewController * ctrl = [[RssListViewController alloc] init];
    ctrl.model = listModel;
    [self.navigationController pushViewController:ctrl animated:YES];
    
}
//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    self.slideView.x = -scrollView.contentOffset.x/5;
    CGFloat f = scrollView.contentOffset.x/scrollView.bounds.size.width;
    if (f<=0.5) {
        [self updateSliderBgColor:0];
    }else if (0.5<f&&f<=1.5){
        [self updateSliderBgColor:1];
    }else if (1.5<f&&f<=2.5){
        [self updateSliderBgColor:2];
    }else if (2.5<f&&f<=3.5){
        [self updateSliderBgColor:3];
    }else if (3.5<f&&f<=4.5){
        [self updateSliderBgColor:4];
    }else if (4.5<f&&f<5.5){
        [self updateSliderBgColor:5];
    }else if (5.5<f&&f<=6.5){
        [self updateSliderBgColor:6];
    }else if (6.5<f&&f<=7.5){
        [self updateSliderBgColor:7];
    }else if (7.5<f&&f<=8.5){
        [self updateSliderBgColor:8];
    }else if (8.5<f&&f<=9.5){
        [self updateSliderBgColor:9];
    }else if (9.5<f&&f<=10.5){
        [self updateSliderBgColor:10];
    }else if (10.5<f&&f<=11.5){
        [self updateSliderBgColor:11];
    }else if (11.5<f&&f<=12.5){
        [self updateSliderBgColor:12];
    }else if (12.5<f&&f<=13.5){
        [self updateSliderBgColor:13];
    }else if (13.5<f&&f<=14.5){
        [self updateSliderBgColor:14];
    }
}

- (void)updateSliderBgColor:(NSInteger)index
{
    [UIView animateWithDuration:0.3 animations:^{
        self.slideView.bgColor = self.colorArray[index];
    }];
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

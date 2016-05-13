//
//  Server7ViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 周杰. All rights reserved.
//
#define BTN_TAG 6598
#import "MovieListViewController.h"
#import "MovieFirstCell.h"
#import "ZJHttpTool.h"
#import "MJExtension.h"
#import "SearchMovieModel.h"
#import "MovieDescCell.h"
#import "MovieSubTitleCell.h"
#import "MovieRecCell.h"
#import "WebViewViewController.h"

@interface MovieListViewController () <UITableViewDelegate,UITableViewDataSource,MovieFirstCellDelegate>
@property (nonatomic ,strong) UITableView * tableView;
/** 搜索结果模型 */
@property (nonatomic ,strong) SearchMovieResult * resultModel;
/** 文本框 */
@property (nonatomic ,strong) UITextField * searchText;
/** 搜索按钮 */
@property (nonatomic ,strong) UIButton * searchButton;
/** 推荐模型数组 */
@property (nonatomic ,strong) NSArray * recModelArray;
/**  */
@property (nonatomic ,strong) NSArray * urlArray;
@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI
{
    self.title = @"影视搜索";
    [self createTableview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableview
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //头视图
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    headView.backgroundColor = ZJColor(33, 118, 195);
    self.tableView.tableHeaderView = headView;
    
    //搜索框
    self.searchText = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, headView.bounds.size.width-80, 30)];
    self.searchText.placeholder =@"输入要搜索的影视";
    self.searchText.borderStyle = UITextBorderStyleRoundedRect;
    [headView addSubview:self.searchText];
    
    //搜索按钮
    self.searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.searchButton.frame = CGRectMake(CGRectGetMaxX(self.searchText.frame), 10, 70, self.searchText.bounds.size.height);
    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(scerchMovie) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.searchButton];
    
    
}
/** 点击搜索 */
- (void)scerchMovie
{
    if (self.searchText.text.length) {
        [self downloadData];
    }else{
        [ZJAlertTool showMessage:@"输入错啦" target:self];
    }
    
}
- (void)downloadData
{
    NSString * key = MovieListAPPKey;
    NSString * url = MovieListURL;
    NSString * q = self.searchText.text;
    NSMutableDictionary * para = [NSMutableDictionary dictionary];
    [para setObject:key forKey:@"key"];
    [para setObject:q forKey:@"q"];
    
    [ZJHttpTool POSTWithUrl:url andParameters:para success:^(id responseObject) {
        //字典转模型
        SearchMovieModel * model = [SearchMovieModel mj_objectWithKeyValues:responseObject];
        if (model.error_code == 0) {
            SearchMovieResult * resultModel = model.result;
            self.resultModel = resultModel;
            self.recModelArray = resultModel.video_rec;
            [self performSelectorOnMainThread:@selector(reloadTabeleViewUI) withObject:nil waitUntilDone:NO];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJAlertTool showMessage:model.reason target:self];
            });
        }
        
    } failure:^(NSError *error) {
        //
    }];
    
}

- (void)reloadTabeleViewUI
{
    [self.tableView reloadData];
}
#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    if (self.recModelArray) {
        number = 3+self.recModelArray.count;
    }
    return number;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
       CGFloat height0 = Screen_Width*258/530.0+40;
        return height0;
    }else if (indexPath.row==1){
        CGFloat h = [MovieDescCell computeCellHeight:self.resultModel];
        return h;
    }else if (indexPath.row==2){
        return 40;
    }else
        return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {     //第一个cell是整体简介
        MovieFirstCell * cell = [MovieFirstCell cellWithTableView:tableView];
        cell.model = self.resultModel;
        cell.delegate = self;
        return cell;
    }else if (indexPath.row==1){    //第二个cell是故事简介
        MovieDescCell * cell = [MovieDescCell cellWithTableView:tableView];
        cell.model = self.resultModel;
        return cell;
    }else if (indexPath.row == 2){  //第三个cell是一下cell的标题
        MovieSubTitleCell * cell = [MovieSubTitleCell cellWithTableView:tableView];
        return cell;
    }
    
    MovieRecCell * cell = [MovieRecCell cellWithTableView:tableView];
    cell.model = self.recModelArray[indexPath.row-3];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<3) {
        return;
    }
    if (indexPath.row>=3) {
        SearchMovieResultVideo_Rec * model = self.recModelArray[indexPath.row-3];
        WebViewViewController * ctrl = [[WebViewViewController alloc] init];
        ctrl.url = model.detail_url;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (void)clickbutton
{
    NSArray * array = @[@"baofeng" ,@"huashu" ,@"leshi" ,@"qq" ,@"kumi" ,@"cntv" ,@"youku" ,@"tudou" ,@"qiyi" ,@"sohu" ,@"imgo" ,@"pptv"];
    NSArray * array2 = @[@"暴风影音" ,@"华数TV" ,@"乐视" ,@"腾讯" ,@"酷米" ,@"CNTV" ,@"优酷" ,@"土豆" ,@"爱奇艺" ,@"搜狐" ,@"芒果" ,@"PPTV"];
    NSDictionary * dict = self.resultModel.playlinks;

    NSMutableArray * arrayM = [NSMutableArray array];
    NSMutableArray * arrayM2 = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        NSString * url = [dict objectForKey:array[i]];
        if (url) {
            [arrayM addObject:url];
            [arrayM2 addObject:array2[i]];
        }
    }
    self.urlArray = arrayM;
    UIView * bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:bgView];
    UIButton * bgButton = [[UIButton alloc] initWithFrame:bgView.bounds];
    [bgView addSubview:bgButton];
    [bgButton addTarget:self action:@selector(clickBgView:) forControlEvents:UIControlEventTouchUpInside];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.8;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake((Screen_Width-150)/2.0, 100, 150, 30)];
    [bgView addSubview:label];
    label.text = @"选择播放源";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    for (int i = 0; i < arrayM.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        CGFloat gap = 5;
        CGFloat X = (Screen_Width-100)/2.0;
        CGFloat Y = 150+(30+gap)*i;
        CGFloat W = 100;
        CGFloat H = 30;
        
        button.frame = CGRectMake(X, Y, W, H);
        [button setTitle:arrayM2[i] forState:UIControlStateNormal];
        button.tag = BTN_TAG +i;
        [button addTarget:self action:@selector(clickListButton:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
    }
}

- (void)clickListButton:(UIButton *)button
{
    NSInteger index = button.tag - BTN_TAG;
    NSString * url = self.urlArray[index];
    ZJLog(@"%@",url);
    WebViewViewController * ctrl = [[WebViewViewController alloc] init];
    ctrl.url = url;
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)clickBgView:(UIButton *)button
{
    [button.superview removeFromSuperview];
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

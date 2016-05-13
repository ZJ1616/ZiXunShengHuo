//
//  SpecialTopicViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "SpecialTopicViewController.h"
#import "SpecualTopicHeadView.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "HomeHeadModel.h"
#import "NewsViewController.h"
#import "ZJHttpTool.h"



@interface SpecialTopicViewController () <UITableViewDataSource,UITableViewDelegate>
/** 滚动视图 */
@property (nonatomic ,strong) UITableView * tableView;
/**模型数据 ArticleListModel 保存cell数据的数据模型数组 */
@property (nonatomic, strong) NSMutableArray * dataArray;
/** 记录NesxtUrl */
@property (nonatomic, copy) NSString * nextUrlStr;
/** 保存是否正在加载数据的状态 */
@property (nonatomic, assign) BOOL isLoading;
/** 记录下载cell数据的数量 */
@property (nonatomic ,assign) NSInteger index;
/** 背景颜色 */
@property (nonatomic, strong) UIColor * bgColor;

@end

@implementation SpecialTopicViewController

/** 背景颜色 */
- (UIColor *)bgColor
{
    if (_bgColor == nil) {
        _bgColor = ZJColor(70, 98, 110);
    }
    return _bgColor;
}

- (NSString *)articleUrl
{
    if (_articleUrl == nil) {
        _articleUrl = [NSString string];
    }
    return _articleUrl;
}
- (NSString *)nextUrlStr
{
    if (_nextUrlStr == nil) {
        _nextUrlStr = [NSString string];
    }
    return _nextUrlStr;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 1;
    //创建导航栏
    [self createNav];
    //创建表格视图
    [self createTableView];
    //下载数据
    [self downloadData];
    // Do any additional setup after loading the view.
}

/** 设置导航 */
- (void)createNav
{
    //导航标题和颜色
    self.title = @"药不能停";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = self.bgColor;
}

/** 创建滚动视图 */
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = self.bgColor;
    [self.view addSubview:self.tableView];
    
    //添加头视图
    SpecualTopicHeadView * headView = [[SpecualTopicHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width*(148.0/357.0)+40)];
    //headView.backgroundColor = self.bgColor;
    headView.imageView.image = [UIImage imageNamed:@"ybnt.png"];
    headView.label.text = @"今天又忘记吃药了，一整天都感觉自己萌萌哒！\n每天为你量身定做一瓶止笑片，切记药不能停！";
    self.tableView.tableHeaderView = headView;
    
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.isLoading) {
            NSLog(@"刷新的太快了");
        }else{
            [self downloadData];
        }
        [self.tableView.mj_header endRefreshing];
        
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self downloadNext];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

/** 下载数据 */
- (void)downloadData
{
    NSString * urlStr = [self.articleUrl stringByReplacingOccurrencesOfString:@"(date)" withString:@"index"];
    self.isLoading = YES;
    self.index = 1;
    [ZJHttpTool getWithURL:urlStr success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.nextUrlStr = responseObject[@"nextUrl"];
            NSArray * result = [NewsSimpleModel mj_objectArrayWithKeyValuesArray:responseObject[@"articleList"]];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:result];
        }
        [self performSelectorOnMainThread:@selector(reloadTableViewUI) withObject:nil waitUntilDone:NO];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        self.isLoading = NO;
        return ;
    }];

}
/** 下载下一组数据 */
- (void)downloadNext
{
    self.isLoading = YES;
    [ZJHttpTool getWithURL:self.nextUrlStr success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.nextUrlStr = responseObject[@"nextUrl"];
            NSArray * resultArray = [NewsSimpleModel mj_objectArrayWithKeyValuesArray:responseObject[@"articleList"]];
            [self.dataArray addObjectsFromArray:resultArray];
            self.index++;
            [self performSelectorOnMainThread:@selector(reloadTableViewUI) withObject:nil waitUntilDone:NO];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        self.isLoading = NO;
        return ;
    }];
    
   
}

/** 刷新表格视图数据 */
- (void)reloadTableViewUI
{
    [self.tableView reloadData];
    self.isLoading = NO;
    NSLog(@"index = %ld",self.index);
    
    if (self.index%10==0) {
        return;
    }
    [self downloadNext];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[NewsCell alloc] init].cellHeight;;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell * cell = [NewsCell cellWithTableView:tableView];
//    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCellId"];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil]lastObject];
//    }
    NewsSimpleModel * model = self.dataArray[indexPath.row];
    [cell configCellWithModel:model];
    cell.backgroundColor = self.bgColor;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.titleLabe.textColor = [UIColor whiteColor];
    cell.subTitleLabel.textColor = [UIColor lightGrayColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:64.0/255 green:89.0/255 blue:100.0/255 alpha:1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsViewController * ctrl = [[NewsViewController alloc] init];
    NewsSimpleModel * model = self.dataArray[indexPath.row];
    ctrl.simpleModel= model;
    [self.navigationController pushViewController:ctrl animated:YES];
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

//
//  RssListViewController.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "RssListViewController.h"
#import "SpecualTopicHeadView.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "HomeHeadModel.h"
#import "NewsViewController.h"
#import "ZJHttpTool.h"
#import "NewsCellLarge.h"
#import "ChanneListModel.h"
#import "DatabaseTool.h"
@interface RssListViewController () <UITableViewDelegate,UITableViewDataSource>
//滚动视图
@property (nonatomic ,strong) UITableView * tableView;
//模型数据 ArticleListModel 保存cell数据的数据模型数组
@property (nonatomic, strong) NSMutableArray * dataArray;
/**网址*/
@property (nonatomic ,copy) NSString * articleUrl;
//记录NesxtUrl
@property (nonatomic, copy) NSString * nextUrlStr;
//保存是否正在加载数据的状态
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation RssListViewController
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationController setNavigationBarHidden:NO];
    [self createTableView];
    [self downloadData];
    [self setNavicationBar];
    
    // Do any additional setup after loading the view.
}
- (void)setNavicationBar
{
    //订阅按钮
//    UIButton * rssButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rssButton.frame = CGRectMake(0, 0, 70, 35);
//    if ([DatabaseTool selectRssDataIsExist:self.model]) {
//        rssButton.selected = YES;
//    }
//    [rssButton setBackgroundImage:[UIImage imageNamed:@"switch_open_state"] forState:UIControlStateNormal];
//    [rssButton setTitle:@"订阅" forState:UIControlStateNormal];
//    rssButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [rssButton setTitle:@"已订阅" forState:UIControlStateSelected];
//    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rssButton];
//    [rssButton addTarget:self action:@selector(clickRssButton:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = item;
}
/** 订阅操作 */
//- (void)clickRssButton:(UIButton *)button
//{
//    if (button.isSelected == YES) {
//        //取消订阅
//        button.selected = NO;
//        [DatabaseTool deletRssData:self.model];
//    }else{
//        //订阅
//        [DatabaseTool addRss:self.model];
//        button.selected = YES;
//    }
//    
//}
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
//下载数据
- (void)downloadData
{
    self.title = self.model.name;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:ZJColor(0, 122, 255)}];
    NSMutableString * articleListUrl = [[NSMutableString alloc] initWithString:self.model.articleListUrl];
    NSString * urlStr = [articleListUrl stringByReplacingOccurrencesOfString:@"(date)" withString:@"index"];
    self.isLoading = YES;
    [ZJHttpTool getWithURL:urlStr success:^(id responseObject) {
        self.nextUrlStr = responseObject[@"nextUrl"];
        NSArray * result = [NewsSimpleModel mj_objectArrayWithKeyValuesArray:responseObject[@"articleList"]];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:result];
        //返回主线程
        [self performSelectorOnMainThread:@selector(reloadTableViewUI) withObject:nil waitUntilDone:NO];
    } failure:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            self.isLoading = NO;
            return ;
        }
    }];
}
- (void)downloadNext
{
    [ZJHttpTool getWithURL:self.nextUrlStr success:^(id responseObject) {
        self.nextUrlStr = responseObject[@"nextUrl"];
        NSLog(@"%@",self.nextUrlStr);
        NSArray * resultArray = [NewsSimpleModel mj_objectArrayWithKeyValuesArray:responseObject[@"articleList"]];
        [self.dataArray addObjectsFromArray:resultArray];
        
        [self performSelectorOnMainThread:@selector(reloadTableViewUI) withObject:nil waitUntilDone:NO];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        self.isLoading = NO;
        return ;
    }];
}

- (void)reloadTableViewUI
{
    [self.tableView reloadData];
    self.isLoading = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建滚动视图
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-48) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsSimpleModel * model = self.dataArray[indexPath.row];
    if (model.imgUrlList.count == 0) {
        return [[NewsCell alloc] init].cellHeight;;
    }else{
        return 250;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsSimpleModel * model = self.dataArray[indexPath.row];
    
    if (model.imgUrlList.count == 0) {
        NewsCell * cell = [NewsCell cellWithTableView:tableView];
        [cell configCellWithModel:model];
        return cell;
    }else{
        NewsCellLarge * cell = [NewsCellLarge cellWithTableView:tableView];
        [cell configCellWithModel:model];
        return cell;
    }
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

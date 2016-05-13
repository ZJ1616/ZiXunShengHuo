//
//  TouTiaoView.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "TouTiaoView.h"
#import "TouTiaoHeadView.h"
#import "HomeHeadModel.h"
#import "ZJHttpTool.h"
#import "NewsViewController.h"
#import "HotdebateViewController.h"
#import "SpecialTopicViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "NewsCell.h"
#import "News3PicCell.h"


@interface TouTiaoView () <UITableViewDelegate,UITableViewDataSource,TouTiaoHeadViewDelegate>
/** 头视图数据模型 */
@property (nonatomic ,strong) HomeHeadModel * homeHeadModel;
/** 头视图 */
@property (nonatomic ,strong) TouTiaoHeadView * headView;


/** 表格视图 */
@property (nonatomic ,strong) UITableView * tableView;
//模型数据 ArticleListModel 保存cell数据的数据模型数组
@property (nonatomic, strong) NSMutableArray * dataArray;
//记录NesxtUrl
@property (nonatomic, copy) NSString * nextUrlStr;
//保存是否正在加载数据的状态
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation TouTiaoView

//构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        [self downloadHeadViewData];
        [self getTableViewData];
        
    }
    return self;
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (NSString *)nextUrlStr
{
    if (_nextUrlStr == nil) {
        _nextUrlStr = [NSString string];
    }
    return _nextUrlStr;
}
//创建UI
- (void)createUI
{
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    
    //添加头视图
    self.headView = [[TouTiaoHeadView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width*0.7125)];
    self.headView.delegate = self;
    self.tableView.tableHeaderView = self.headView;
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.isLoading) {
            NSLog(@"刷新的太快了");
        }else{
            [self downloadTableViewData];
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

- (void)getTableViewData
{
    NSArray * dictArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"首页字典数组"];
    if (dictArray) {
        NSArray * result = [NewsSimpleModel mj_objectArrayWithKeyValuesArray:dictArray];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:result];
    }else{
        [self downloadTableViewData];
    }
}

/** 下载表格视图数据  只有刷新才会调用 */
- (void)downloadTableViewData
{
    self.isLoading = YES;
    NSString * url = TouTiaoURL;
    [ZJHttpTool getWithURL:url success:^(id responseObject) {
        //
        self.nextUrlStr = responseObject[@"nextUrl"];
        //模型数组
        NSArray * dictArray = responseObject[@"articleList"];
        NSArray * result = [NewsSimpleModel mj_objectArrayWithKeyValuesArray:dictArray];
        //把字典数组保存起来
        [[NSUserDefaults standardUserDefaults] setObject:dictArray forKey:@"首页字典数组"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:result];
        //返回主线程
        [self performSelectorOnMainThread:@selector(reloadTableViewUI) withObject:nil waitUntilDone:NO];
    } failure:^(NSError *error) {
        //
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

//****************************
//下载头视图数据
- (void)downloadHeadViewData
{
    ZJLog(@"下载头视图数据");
    [ZJHttpTool getWithURL:HomeUrl success:^(id responseObject) {
        ZJLog(@"数据请求成功");
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            ZJLog(@"解析数据");
            [NewsSimpleModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"desc":@"description"};
            }];
            self.homeHeadModel = [HomeHeadModel mj_objectWithKeyValues:responseObject];
            //self.homeHeadModel = [[HomeHeadModel alloc] initWithDictionary:responseObject error:nil];
            //ZJLog(@"%@",self.homeHeadModel.blocks[2]);
            ZJLog(@"头视图所有数据解析完成");
            //回主线程创建UI
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置头视图数据
                [self createTouTiaoHeadViewData];
            });
        }
    } failure:^(NSError *error) {
        ZJLog(@"%@",error);
    }];
}
- (void)createTouTiaoHeadViewData
{
    self.headView.headModel = self.homeHeadModel;
}
#pragma mark TouTiaoHeadView代理

- (void)clickHotdebateButton:(NSString *)articleUrl
{
    ZJLog(@"%@ click wyry  %@",[self class],articleUrl);
    HotdebateViewController * ctrl = [[HotdebateViewController alloc] init];
    ctrl.articleUrl = articleUrl;
    [self.delegate pushViewController:ctrl];
}

- (void)clickSpecialTopicButton:(NSString *)articleUrl
{
    ZJLog(@"%@ click ybnt   %@",[self class],articleUrl);
    SpecialTopicViewController * ctrl = [[SpecialTopicViewController alloc] init];
    ctrl.articleUrl = articleUrl;
    [self.delegate pushViewController:ctrl];
}

- (void)clickAdNews:(NSString *)articleUrl index:(NSInteger)index
{
    ZJLog(@"%@ click gdst %ld",[self class],index);
    NewsViewController * ctrl = [[NewsViewController alloc] init];
    //ctrl.articleUrl = articleUrl;
    BlockModel * blockModel = self.homeHeadModel.blocks[0];
    ctrl.simpleModel = blockModel.data[index];
    //ZJLog(@"%@",articleUrl);
    [self.delegate pushViewController:ctrl];
}

#pragma mark UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsSimpleModel * model = self.dataArray[indexPath.row];
    if (model.imgUrlList.count == 3) {
        return [[NewsCell alloc] init].cellHeight+80;
    }
    return [[NewsCell alloc] init].cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsSimpleModel * model = self.dataArray[indexPath.row];
    if (model.imgUrlList.count == 3) {
        News3PicCell * cell = [News3PicCell cellWithTableView:tableView];
        cell.model = model;
        return cell;
    }else{
        NewsCell * cell = [NewsCell cellWithTableView:tableView];
        [cell configCellWithModel:model];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsViewController * ctrl = [[NewsViewController alloc] init];
    NewsSimpleModel * model = self.dataArray[indexPath.row];
    ctrl.simpleModel = model;
    [self.delegate pushViewController:ctrl];
//    ctrl.articleUrl= model.articleUrl;
    //[self.navigationController pushViewController:ctrl animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

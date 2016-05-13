//
//  RssView.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "RssView.h"
#import "ZJHttpTool.h"
#import "ZJHttpTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "NewsCell.h"
#import "News3PicCell.h"
#import "HomeHeadModel.h"
#import "ChanneListModel.h"
#import "NewsViewController.h"

@interface RssView () <UITableViewDelegate,UITableViewDataSource>

/** 表格视图 */
@property (nonatomic ,strong) UITableView * tableView;
//模型数据 ArticleListModel 保存cell数据的数据模型数组
@property (nonatomic, strong) NSMutableArray * dataArray;
//记录NesxtUrl
@property (nonatomic, copy) NSString * nextUrlStr;
//保存是否正在加载数据的状态
@property (nonatomic, assign) BOOL isLoading;

@end
@implementation RssView

//构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        
        
    }
    return self;
}

-(void)setModel:(RssListModel *)model
{
    _model = model;
    [self downloadData];
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

//下载数据
- (void)downloadData
{
    NSMutableString * articleListUrl = [[NSMutableString alloc] initWithString:self.model.articleListUrl];
    NSString * urlStr = [articleListUrl stringByReplacingOccurrencesOfString:@"(date)" withString:@"index"];
    //NSString * urlStr = self.model.articleListUrl;
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
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

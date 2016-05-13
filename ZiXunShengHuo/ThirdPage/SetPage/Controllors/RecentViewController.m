//
//  RecentViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "RecentViewController.h"
#import "DatabaseTool.h"
#import "HomeHeadModel.h"
#import "FavoriteCell.h"
#import "NewsViewController.h"
#import "NewsCell.h"
@interface RecentViewController () <UITableViewDelegate,UITableViewDataSource>
/** 收藏的数据 数组 */
@property (nonatomic, strong) NSArray * modelArray;
/** 表格视图 */
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation RecentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    self.title = @"最近阅读";
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createData];
    
}
- (NSArray *)modelArray
{
    if (_modelArray == nil) {
        _modelArray = [NSArray array];
    }
    return _modelArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)createData
{
    //获取最近数据
    self.modelArray = [DatabaseTool getRecentData];
}

#pragma mark UITable代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[NewsCell alloc] init].cellHeight;;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString * cellId = @"favoriteCellId";
//    FavoriteCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCellId"];
//    if (cell == nil) {
//        cell = [[FavoriteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
    NewsCell * cell = [NewsCell cellWithTableView:tableView];
    NewsSimpleModel * model = self.modelArray[indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsViewController * ctrl = [[NewsViewController alloc] init];
    NewsSimpleModel * model = self.modelArray[indexPath.row];
    ctrl.simpleModel= model;
    ZJLog(@"%@",model.articleUrl);
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//添加获取删除单元格
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [DatabaseTool deletRecentData:self.modelArray[indexPath.row]];
        NSMutableArray * array = [NSMutableArray arrayWithArray:self.modelArray];
        [array removeObjectAtIndex:indexPath.row];
        self.modelArray = array;
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
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

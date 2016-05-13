//
//  HotdebateViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "HotdebateViewController.h"
#import "HomeHeadModel.h"
#import "NewsViewController.h"
#import "NewsCell.h"
#import "MJExtension.h"
#import "ZJHttpTool.h"

@interface HotdebateViewController () <UITableViewDataSource,UITableViewDelegate>

/** 表格视图 */
@property (nonatomic ,strong) UITableView * tableView;
/** 存放表格视图模型的数组 */
@property (nonatomic ,strong) NSArray * modelArray;

@end

@implementation HotdebateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建表格视图
    [self createTableView];
    //下载数据
    [self downloadData];
}
/** 初始化网址 */
- (NSString *)articleUrl
{
    if (_articleUrl == nil) {
        _articleUrl = [NSString string];
    }
    return _articleUrl;
}

/** 初始化模型数组 */
- (NSArray *)modelArray
{
    if (_modelArray == nil) {
        _modelArray = [NSArray array];
    }
    return _modelArray;
}

/** 创建表格视图 */
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.title = @"网友热议";
}

/** 下载数据 */
- (void)downloadData
{
    [ZJHttpTool getWithURL:self.articleUrl success:^(id responseObject) {
        ZJLog(@"网友热议页面数据请求成功");
        NSMutableArray * array = [NSMutableArray array];
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary * dict in responseObject) {
                NewsSimpleModel * model = [NewsSimpleModel mj_objectWithKeyValues:dict];
                [array addObject:model];
            }
            self.modelArray = array;
            //回主线程刷新表格视图数据
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        ZJLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    number = self.modelArray.count;
    return number;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[NewsCell alloc] init].cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCellId"];
    NewsCell * cell = [NewsCell cellWithTableView:tableView];
//    if (cell == nil) {
//        //cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil]lastObject];
//        cell = [NewsCell ]
//    }
    NewsSimpleModel * model = self.modelArray[indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsViewController * ctrl = [[NewsViewController alloc] init];
    NewsSimpleModel * model = self.modelArray[indexPath.row];
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

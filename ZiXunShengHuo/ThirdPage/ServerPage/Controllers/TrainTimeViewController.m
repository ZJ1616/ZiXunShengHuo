//
//  WifiViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 周杰. All rights reserved.
// 05e725d1d82b4317b774f1b8f60e6845
// http://op.juhe.cn/onebox/train/query_ab

#import "TrainTimeViewController.h"
#import "MJExtension.h"
#import "ZJHttpTool.h"
#import "TrainTimeModel.h"
#import "TrainTimeCell.h"
#import "WebViewViewController.h"
#import "TicketHeadView.h"
@interface TrainTimeViewController () <UITableViewDelegate,UITableViewDataSource,TicketHeadViewDelegate>
/** 查询结果模型 */
@property (nonatomic, strong) TrainTimeModel * model;
/** 查询的列车车次数组 */
@property (nonatomic, strong) NSArray * ListArray;
/** 滚动视图 */
@property (nonatomic, strong) UITableView * tableView;
/** 发站 */
@property (nonatomic, strong) UITextField * fromText;
/** 到站 */
@property (nonatomic, strong) UITextField * toText;

@end

@implementation TrainTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"火车时刻表";
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)ListArray
{
    if (_ListArray == nil) {
        _ListArray = [NSArray array];
    }
    return _ListArray;
}

- (void)downloadData
{
    NSString * url = TrainTimeURL;
    NSString * key = TrainTimeAPPKey;
    NSString * from = self.fromText.text;
    NSString * to = self.toText.text;
    
    NSMutableDictionary * para = [NSMutableDictionary dictionary];
    [para setObject:key forKey:@"key"];
    [para setObject:from forKey:@"from"];
    [para setObject:to forKey:@"to"];
    
    [ZJHttpTool POSTWithUrl:url andParameters:para success:^(id responseObject) {
        //
        if ([responseObject[@"error_code"] isEqualToNumber:@(0)]) {
            //ZJLog(@"reason %@",responseObject[@"reason"]);
            NSDictionary * dict = responseObject[@"result"];
            self.model = [TrainTimeModel mj_objectWithKeyValues:dict];
            NSMutableArray * array = [NSMutableArray array];
            for (TrainTimeList * listModel in self.model.list) {
                [array addObject:listModel];
            }
            self.ListArray = array;
            [self performSelectorOnMainThread:@selector(reloadTableViewUI) withObject:nil waitUntilDone:NO];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJAlertTool showMessage:responseObject[@"reason"] target:self];
            });
            
        }
    } failure:^(NSError *error) {
        //
        ZJLog(@"%@",error);
    }];
    
}

- (void)reloadTableViewUI
{
    
    [self.tableView reloadData];
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = ZJColor(231, 236, 240);
    [self.view addSubview:self.tableView];
    
    //头视图
    TicketHeadView * headView = [[TicketHeadView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 150)];
    self.fromText = headView.fromText;
    self.toText = headView.toText;
    self.tableView.tableHeaderView = headView;
    headView.delegate = self;

}
/** 点击查询 */
- (void)clickQueryTimeList
{
    
    if (self.fromText.text.length&&self.toText.text.length) {
        [self downloadData];
    }else{
        [ZJAlertTool showAlertViewTarget:self Title:@"提示" message:@"地址填错啦"];
    }
}

#pragma mark UITableVIewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrainTimeCell * cell = [TrainTimeCell cellWithTableView:tableView];
    cell.model = self.ListArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrainTimeList * model = self.ListArray[indexPath.row];
    NSString * url = model.m_chaxun_url;
    WebViewViewController * ctrl = [[WebViewViewController alloc] init];
    ctrl.url = url;
    ZJLog(@"%@",url);
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

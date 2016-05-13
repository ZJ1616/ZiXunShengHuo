//
//  Server4ViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 周杰. All rights reserved.
//   f9fd8913eb1850ec057829e5994c9a6a  http://op.juhe.cn/onebox/bus/query_ab  http://op.juhe.cn/onebox/bus/query
/* 	
 from 	string 	是 	出发城市，如：上海
 to 	string 	是 	到达城市，如:苏州
 key 	string 	是 	应用APPKEY(应用详细页查询)*/

/*
 station 	string 	是 	城市名称，如:北京
 key 	string 	是 	应用APPKEY(应用详细页查询)
 */
#import "CoachTimeViewController.h"
#import "ZJHttpTool.h"
#import "MJExtension.h"
#import "CoachTimeModel.h"
#import "CoachTimeCell.h"
#import "TicketHeadView.h"

@interface CoachTimeViewController () <UITableViewDelegate,UITableViewDataSource,TicketHeadViewDelegate>
/** 城市 */
@property (nonatomic ,strong) UITextField * cityText;
/** 发站 */
@property (nonatomic ,strong) UITextField * fromText;
/** 到站 */
@property (nonatomic ,strong) UITextField * toText;
/** 表格视图 */
@property (nonatomic ,strong) UITableView * tableView;
/** 时间表数组 */
@property (nonatomic ,strong) NSArray * timeListArray;
@end

@implementation CoachTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"汽车时刻表";
    [self createtableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)timeListArray
{
    if (_timeListArray == nil) {
        _timeListArray = [NSArray array];
    }
    return _timeListArray;
}
- (void)downloadDataTimeList
{
    NSString * url = CoachTimeURL;
    NSString * from = self.fromText.text;
    NSString * to = self.toText.text;
    NSMutableDictionary * para = [NSMutableDictionary dictionary];
    [para setObject:CoachAPPKey forKey:@"key"];
    [para setObject:from forKey:@"from"];
    [para setObject:to forKey:@"to"];
    
    [ZJHttpTool POSTWithUrl:url andParameters:para success:^(id responseObject) {
        //字典转模型
        CoachTimeModel * model = [CoachTimeModel mj_objectWithKeyValues:responseObject];
        //判断成功
        if (model.error_code==0) {
            ZJLog(@"%@",model.reason);
            //保存表单数组
            NSMutableArray * array = [NSMutableArray array];
            for (CoachTimeResultList * listModel in model.result.list) {
                [array addObject:listModel];
            }
            self.timeListArray = array;
            [self performSelectorOnMainThread:@selector(reloadTableViewUI) withObject:nil waitUntilDone:NO];
        }else{
            ZJLog(@"%@",model.reason);
        }
        
    } failure:^(NSError *error) {
        //
    }];
}

- (void)createtableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //头视图
    TicketHeadView * headView = [[TicketHeadView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 150)];
    self.fromText = headView.fromText;
    self.toText = headView.toText;
    self.tableView.tableHeaderView = headView;
    headView.delegate = self;
    
}

- (void)reloadTableViewUI
{
    [self.tableView reloadData];
}
#pragma TicketHeadViewDelegate
- (void)clickQueryTimeList
{
    if (self.fromText.text.length&&self.toText.text.length) {
        [self downloadDataTimeList];
    }else{
        [ZJAlertTool showMessage:@"数据填错啦" target:self];
    }
    
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    
    number = self.timeListArray.count;
    return number;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    height = 100;
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoachTimeCell * cell = [CoachTimeCell cellWithTableView:tableView];
    cell.model = self.timeListArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

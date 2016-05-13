//
//  WiFiViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "WiFiViewController.h"
#import "ZJHttpTool.h"
#import "MJExtension.h"
#import "WiFiListModel.h"
#import "WiFiListCell.h"
#import "WiFiHeadView.h"

@interface WiFiViewController () <UITableViewDelegate,UITableViewDataSource>
/** 表格视图 */
@property (nonatomic ,strong) UITableView * tableView;
/** 保存Wifi列表的数组 */
@property (nonatomic ,strong) NSArray * modelArray;
/** 头视图 显示提示信息 */
@property (nonatomic ,strong) WiFiHeadView * headView;
@end

@implementation WiFiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"附近WiFi";
    [self createTableView];
    [self downloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)modelArray
{
    if (_modelArray == nil) {
        _modelArray = [NSArray array];
    }
    return _modelArray;
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-48) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    //添加头视图
    self.headView = [[WiFiHeadView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
    self.headView.backgroundColor = [UIColor colorWithRandomColor];
    self.tableView.tableHeaderView = self.headView;
    
}

- (void)downloadData
{
    NSString * key = WiFi_APPKey;
    NSString * url = WiFi_URL;
    NSMutableDictionary * para = [NSMutableDictionary dictionary];
    [para setObject:key forKey:@"key"];
    NSDictionary * coor2D = [[NSUserDefaults standardUserDefaults] objectForKey:@"coor2D"];
    NSNumber * lon = coor2D[@"lon"];
    NSNumber * lat = coor2D[@"lat"];
    ZJLog(@"%@",coor2D);
    if (lon&&lat) {
        [para setObject:lon forKey:@"lon"];//121.48694444444445
        [para setObject:lat forKey:@"lat"];//31.380555555555556
    }else{
        self.headView.titleLabel.text = @"无法获取当前位置";
        [ZJAlertTool showMessage:@"无法获取当前位置" target:self];
        return;
    }
        [para setObject:@(3) forKey:@"gtype"];
    [para setObject:@(3000) forKey:@"r"];
    
    [ZJHttpTool POSTWithUrl:url andParameters:para success:^(id responseObject) {
        WiFiListModel * listModel = [WiFiListModel mj_objectWithKeyValues:responseObject];
        //成功  无错误码
        if (listModel.error_code == 0) {
            self.modelArray = listModel.result.data;            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadUI];
            });
        }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showError:listModel.error_code];
        });
        }
        
    } failure:^(NSError *error) {
        ZJLog(@"%@",error);
    }];
}

- (void)reloadUI
{
    [self.tableView reloadData];
    self.headView.modelArray = self.modelArray;
}

//有错误码 显示提示信息
- (void)showError:(NSInteger)error_code
{
    if (error_code == 201801) {
        [ZJAlertTool showMessage:@"错误的经纬度" target:self];
        self.headView.titleLabel.text = @"错误的经纬度";
    }else if (error_code == 201803){
        [ZJAlertTool showMessage:@"查询无结果" target:self];
        self.headView.titleLabel.text = @"查询无结果";
    }else if (error_code == 201805){
        [ZJAlertTool showMessage:@"周边查询无结果" target:self];
        self.headView.titleLabel.text = @"周边查询无结果";
    }
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WiFiListCell * cell = [WiFiListCell cellWithTableView:tableView];
    WiFi_Result_Data * model = self.modelArray[indexPath.row];
    cell.WifiListModel = model;
    //ZJLog(@"%@",model.address);
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

//
//  WeatherSetViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "WeatherSetViewController.h"
#import "WeatherModel.h"
#import "ZJHttpTool.h"
#import "MJExtension.h"

@interface WeatherSetViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) UITextField * cityNameText;
@end

@implementation WeatherSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self createData];
}

/** 界面 */
- (void)createUI
{
    [self createTableView];
    [self createHeadView];
}

- (void)createData
{
    self.title = @"天气";
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-48-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 头视图 */
- (void)createHeadView
{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    CGFloat x = 20;
    CGFloat y = 20;
    CGFloat w = (Screen_Width-40)/2+20;
    CGFloat h = 30;
    
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [headView addSubview:textField];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"请输入城市名";
    self.cityNameText = textField;
    self.tableView.tableHeaderView = headView;
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(CGRectGetMaxX(textField.frame), y, w-20, h);
    [headView addSubview:button];
    [button setTitle:@"更 改 城 市" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cliclButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cliclButton
{
    NSString * city = self.cityNameText.text;
    NSMutableDictionary * para = [[NSMutableDictionary alloc] init];
    [para setObject:Weather_APPKey forKey:@"key"];
    [para setObject:city forKey:@"cityname"];
    [ZJHttpTool POSTWithUrl:Weather_Url andParameters:para success:^(id responseObject) {
        WeatherModel * model = [WeatherModel mj_objectWithKeyValues:responseObject];
        if (model.error_code == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate setWeatherCity:city];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [self showFailureMessage:model.reason];
        }
    } failure:^(NSError *error) {
        [self showFailureMessage:@"查询失败"];
    }];
    
}


- (void)showFailureMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [ZJAlertTool showMessage:message target:self];
    });
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    return number;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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

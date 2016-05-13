//
//  ExpressViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 周杰. All rights reserved.
//
#define Key @"5977a87dd1d04ca889b38e690657aa50"
#import "ExpressViewController.h"
#import "MJExtension.h"
#import "ChooseCompanyViewController.h"
#import "ExpressCompanyModel.h"
#import "ZJHttpTool.h"
#import "ExpressDataCell.h"
#import "ExpressDataModel.h"

@interface ExpressViewController () <ChooseCompanyViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
/** 滚动视图 */
@property (nonatomic ,strong) UITableView * tableView;
/** 文本框 */
@property (nonatomic ,strong) UITextField * expressNumText;
/** 选择按钮 */
@property (nonatomic ,strong) UIButton * expressCompanyNameButton;
/** 快递公司数据模型 */
@property (nonatomic ,strong) ExpressCompanyModel * model;
/** 快递运输信息模型 */
@property (nonatomic ,strong) NSArray * ExpressDataModelArray;
/** 记录cell高 */
@property (nonatomic ,strong) NSArray * cellHeightArray;
@end

@implementation ExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view.
    
    
}

- (void)createUI
{
    self.title = @"快递查询";
    //表格视图
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //头视图
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    headView.backgroundColor = ZJColor(33, 118, 195);
    
    //文本框
    UITextField * ExpressNumText = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, self.view.bounds.size.width-40, 30)];
    ExpressNumText.placeholder = @"输入要查询的单号";
    ExpressNumText.borderStyle = UITextBorderStyleRoundedRect;
    [headView addSubview:ExpressNumText];
    self.expressNumText = ExpressNumText;
    
    //选择公司
    UIButton * companyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [companyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    companyButton.frame = CGRectMake(20, CGRectGetMaxY(ExpressNumText.frame)+10, ExpressNumText.bounds.size.width, ExpressNumText.bounds.size.height);
    [headView addSubview:companyButton];
    [companyButton setTitle:@"选择快递公司" forState:UIControlStateNormal];
    [companyButton addTarget:self action:@selector(clickcompanyButton) forControlEvents:UIControlEventTouchUpInside];
    self.expressCompanyNameButton = companyButton;
    
    //查询按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(20, CGRectGetMaxY(companyButton.frame)+10, ExpressNumText.bounds.size.width, ExpressNumText.bounds.size.height);
    [button setTitle:@"查询" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(queryExpress) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:button];
    
    self.tableView.tableHeaderView = headView;
    
}

/** 点击选择快递公司按钮 */
- (void)clickcompanyButton
{
    ChooseCompanyViewController * ctrl = [[ChooseCompanyViewController alloc] init];
    ctrl.delegate = self;
    [self.navigationController pushViewController:ctrl animated:YES];
}

/** 点击查询按钮 */
- (void)queryExpress
{
    if (self.expressNumText.text.length>0&&self.model) {
        NSString * expressNum = self.expressNumText.text;
        NSString * companyName = self.model.code;
        ZJLog(@"%@---%@",expressNum,companyName);
        [self downloadDataWithCompanyName:companyName andNum:expressNum];
    }else{
        ZJLog(@"输入不正确");
        [ZJAlertTool showMessage:@"输入不正确" target:self];
    }
    
    
}
/** 下载数据 */
- (void)downloadDataWithCompanyName:(NSString *)company andNum:(NSString *)expressId
{
    //拼接参数
    NSString * url = ExpressURL;
    NSString * key = ExpressAPPKey;
    NSMutableDictionary * para = [NSMutableDictionary dictionary];
    [para setObject:key forKey:@"key"];
    [para setObject:expressId forKey:@"id"];
    [para setObject:company forKey:@"company"];
    //下载
    [ZJHttpTool POSTWithUrl:url andParameters:para success:^(id responseObject) {
        //判断是否成功
        NSNumber * error_code = responseObject[@"error_code"];
        if ([error_code isEqualToNumber:@(0)]) {
            NSArray * array = responseObject[@"result"];
            //字典数组转模型数组
            self.ExpressDataModelArray = [ExpressDataModel mj_objectArrayWithKeyValuesArray:array];
            NSMutableArray * arrayM = [NSMutableArray array];
            for (ExpressDataModel * model in self.ExpressDataModelArray) {
                CGFloat h = [ExpressDataCell getCellHeight:model];
                [arrayM addObject:@(h)];
            }
            self.cellHeightArray = arrayM;
        }else{
            ZJLog(@"%@",responseObject[@"reason"]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJAlertTool showAlertViewTarget:self Title:@"提示" message:responseObject[@"reason"]];
            });
        }
        //刷新UI
        [self performSelectorOnMainThread:@selector(rlloadTableViewUI) withObject:nil waitUntilDone:NO];
    } failure:^(NSError *error) {
        ZJLog(@"%@",error);
    }];
}

/** 刷新数据 */
- (void)rlloadTableViewUI
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ChooseCompanyViewControllerDelegate
- (void)selectExpressCompany:(ExpressCompanyModel *)model
{
    [self.expressCompanyNameButton setTitle:model.name forState:UIControlStateNormal];
    self.model = model;
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ExpressDataModelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellHeightArray[indexPath.row] floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpressDataCell * cell = [ExpressDataCell cellWithTableView:tableView];
    cell.model = self.ExpressDataModelArray[indexPath.row];
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

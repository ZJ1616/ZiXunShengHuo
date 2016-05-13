//
//  ChooseCompanyViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "ChooseCompanyViewController.h"
#import "ExpressCompanyModel.h"
#import "MJExtension.h"

@interface ChooseCompanyViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) NSArray * modelArray;
@end

@implementation ChooseCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)createUI
{
    self.title = @"选择快递公司";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

/** 获取所有公司列表 */
- (void)createData
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"ExpressCompanyList" ofType:@"json"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //ZJLog(@"%@",dict);
    NSArray * array = dict[@"result"];
    NSArray * modelArray = [ExpressCompanyModel mj_objectArrayWithKeyValuesArray:array];
    self.modelArray = modelArray;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ExpressCompanyCellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExpressCompanyCellId"];
    }
    ExpressCompanyModel * model = self.modelArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpressCompanyModel * model = self.modelArray[indexPath.row];
    [self.delegate selectExpressCompany:model];
    [self.navigationController popViewControllerAnimated:YES];
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

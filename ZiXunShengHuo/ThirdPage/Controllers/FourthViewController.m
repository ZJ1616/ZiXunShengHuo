//
//  FourthViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "FourthViewController.h"
#import "RecentViewController.h"
#import "FavoriteViewController.h"
#import "SetViewController.h"
#import "DatabaseTool.h"
#import "SetToolCell.h"
#import "ServerCell.h"
#import "NearCell.h"
#import "WeatherHeadView.h"
#import "WeatherSetViewController.h"

@interface FourthViewController () <UITableViewDelegate,UITableViewDataSource,SetToolCellDelegate,ServerCellDelegate,NearCellDelegate,WeatherHeadViewDelegate,WeatherSetViewControllerDelegate>
/**
 *  表格视图
 */
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建表格视图
    [self createTableView];
}

/**
 *  创建表格视图
 */
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-48) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self createHeadView:nil];
}

- (void)createHeadView:(NSString *)city
{
    WeatherHeadView * headView = [[WeatherHeadView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width*0.4)];
    //headView.backgroundColor = [UIColor colorWithRandomColor];
    headView.city = city;
    self.tableView.tableHeaderView = headView;
    headView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setWeatherCity:(NSString *)city
{
    self.tableView.tableHeaderView = nil;
    [self createHeadView:city];
}
#pragma mark UITableVIewDelegate UITableViewDataSource
/** 分组数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
/** 分组的头视图 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    view.backgroundColor = ZJColor(235, 235, 235);
    
    if (section==0) {
        return view;
    }else if (section==1){
        UILabel * label = [[UILabel alloc] initWithFrame:view.frame];
        label.text = @"便捷服务";
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        return view;
    }else if (section==2){
        UILabel * label = [[UILabel alloc] initWithFrame:view.frame];
        label.text = @"附近";
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        return view;
    }
    return nil;
}
/** 分组的头视图的高 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 15;
    }else if (section==1){
        return 40;
    }else if (section==2){
        return 40;
    }
    return 0;
}

/** 分组的尾视图 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
/** 分组的尾视图的高 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

/** 指定分组Cell个数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

/** 指定位置的cell高度 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = 0;
    if (indexPath.section == 0) {
        return 70;
    }else if (indexPath.section==1){
        return 140;
    }else if (indexPath.section==2){
        return 210;
    }
    return h;
}

/** 指定位置的cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //分组1的cell 最近 收藏 设置
        SetToolCell * cell = [tableView dequeueReusableCellWithIdentifier:@"setToolCellId"];
        if (cell == nil) {
            cell = [[SetToolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setToolCellId"];
        }
        cell.delegate = self;
        return cell;
    }else if (indexPath.section==1){
        //分组2的cell  便捷服务
        ServerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"servreCellId"];
        if (cell == nil) {
            cell = [[ServerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"servreCellId"];
        }
        cell.delegate = self;
        return cell;
    }else if (indexPath.section==2){
        //附近
        NearCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NearCellId"];
        if (cell == nil) {
            cell = [[NearCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NearCellId"];
        }
        cell.delegate = self;
        return cell;
    }
    return nil;
}
/** 指定位置cell点击触发 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma 点击Cell内部按钮触发的事件
/** 推出收藏页面 */
- (void)pushFavorietViewController
{
    FavoriteViewController * ctrl = [[FavoriteViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}
/** 推出最近页面 */
- (void)pushRecentViewController
{
    RecentViewController * ctrl = [[RecentViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

/** 推出设置页面 */
- (void)pushSetViewController
{
    SetViewController * ctrl = [[SetViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

/** 推出服务页面 */
- (void)pushServerViewController:(UIViewController *)ctrl
{
    [self.navigationController pushViewController:ctrl animated:YES];
}

/** 推出附近页面 */
- (void)pushNearViewController:(UIViewController *)ctrl
{
    [self.navigationController pushViewController:ctrl animated:YES];
}
/** 推出天气设置页面*/
- (void)pushWeatherSetViewController
{
    WeatherSetViewController * ctrl = [[WeatherSetViewController alloc] init];
    ctrl.delegate = self;
    ctrl.nowcity  =@"上海";
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

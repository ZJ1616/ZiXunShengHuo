//
//  SetViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "SetViewController.h"
#import "DatabaseTool.h"

@interface SetViewController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) NSArray * titlesArray;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createData];
    [self createTableView];
}

- (void)createData
{
    self.titlesArray = @[@"清空最近阅读",@"清空收藏",@"清空缓存",@"关于"];
}

- (void)createTableView
{
    self.title = @"设置";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titlesArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //删历史
        [self deleteAllRecent];
    }else if (indexPath.row == 1){
        //删收藏
        [self deleteAllFavorite];
    }else if (indexPath.row == 2){
        //删缓存
        [self deleteCache];
    }else if (indexPath.row == 3){
        //关于
    }
    
}

- (void)deleteAllRecent
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"清空所有历史记录" preferredStyle: UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [DatabaseTool deleteAllRecentData];
        [self showAlertViewWithTitle:@"提示" message:@"操作成功"];
    }]];
    [self presentViewController:alert animated:true completion:nil];
}


- (void)deleteAllFavorite
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"清空所有收藏" preferredStyle: UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [DatabaseTool deleteAllFavoriteData];
        [self showAlertViewWithTitle:@"提示" message:@"操作成功"];
    }]];
    [self presentViewController:alert animated:true completion:nil];
}
- (void)deleteCache
{
    [DatabaseTool cleanCache];
    [self showAlertViewWithTitle:@"提示" message:@"操作成功"];
}


- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle: UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:true completion:nil];
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

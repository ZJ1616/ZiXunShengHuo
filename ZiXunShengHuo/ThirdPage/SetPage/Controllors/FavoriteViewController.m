//
//  FavoriteViewController.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/19.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "FavoriteViewController.h"
#import "DatabaseTool.h"
#import "HomeHeadModel.h"
#import "FavoriteCell.h"
#import "NewsCell.h"
#import "NewsViewController.h"
@interface FavoriteViewController () <UITableViewDelegate,UITableViewDataSource>
/** 收藏的数据 数组 */
@property (nonatomic, strong) NSArray * modelArray;
/** 表格视图 */
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建表格视图
    [self createTableView];
    self.title = @"我的收藏";
    //[self createNavication];
    
}
/** 页面将要显示时刷新数据 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createData];
}

//- (void)createNavication
//{
//    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    rightBtn.frame = CGRectMake(0, 0, 80, 30);
//    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    [rightBtn setTitle:@"完成" forState:UIControlStateSelected];
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    //[rssManagerBtn setBackgroundImage:[UIImage imageNamed:@"file_tital_but_press"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//}
//-(void)edit:(UIBarButtonItem*)item
//{
//    //判断当前的tableView是否处在编辑状态
//    if (self.tableView.isEditing == NO) {
//        //以动画的方式进入编辑模式
//        [self.tableView setEditing:YES animated:YES];
//        
//        item.title = @"完成";
//    }else{
//        [self.tableView setEditing:NO animated:YES];
//        item.title =@"编辑";
//    }
//}
//- (void)clickRightBtn:(UIButton *)button
//{
//    if (button.isSelected == YES) {
//        ZJLog(@"点击完成");
//        [self.tableView setEditing:NO animated:YES];
//        
//        
//        button.selected = NO;
//    }else{
//        ZJLog(@"点击编辑");
//        [self.tableView setEditing:YES animated:YES];
//        
//        button.selected = YES;
//    }
//}


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

//获取收藏数据
- (void)createData
{    
    self.modelArray = [DatabaseTool getFavoriteData];
    [self.tableView reloadData];
}

#pragma mark UITable代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[NewsCell alloc] init].cellHeight;
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
        [DatabaseTool deletFavoriteData:self.modelArray[indexPath.row]];
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

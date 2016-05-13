//
//  RssManageViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 周杰. All rights reserved.
//
#define RssBtn_Tag 45
#import "RssManageViewController.h"
#import "DatabaseTool.h"
#import "ChanneListModel.h"
#import "RssBtn.h"
#import "RssListViewController.h"

@interface RssManageViewController ()
@property (nonatomic ,strong) UIScrollView * scrollView;
@property (nonatomic ,strong) NSMutableArray * rssListArray;
@end

@implementation RssManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createData];
    [self createScrollView];
    [self createNavication];
}

- (void)createNavication
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateSelected];
     rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     //[rssManagerBtn setBackgroundImage:[UIImage imageNamed:@"file_tital_but_press"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)clickRightBtn:(UIButton *)button
{
    if (button.isSelected == YES) {
        ZJLog(@"点击完成");
        
        for (UIView * view in self.scrollView.subviews) {
            if ([view isKindOfClass:[RssBtn class]]) {
                RssBtn * btn = (RssBtn *)view;
                btn.isDelete = NO;
            }
        }
        
        button.selected = NO;
    }else{
        ZJLog(@"点击编辑");
        
        for (UIView * view in self.scrollView.subviews) {
            if ([view isKindOfClass:[RssBtn class]]) {
                RssBtn * btn = (RssBtn *)view;
                btn.isDelete = YES;
            }
            
            
            button.selected = YES;
        }
    }
}

//点击按钮
- (void)clickRssBtn:(RssBtn *)btn
{
    NSInteger index = btn.tag - RssBtn_Tag;
    RssListModel * model = self.rssListArray[index];
    
    if (btn.isDelete==YES) {
        //处于删除状态
        ZJLog(@"处于删除状态");
        [DatabaseTool deletRssData:model];
        [self.rssListArray removeObject:model];
        
        for (UIView * view in self.scrollView.subviews) {
            if ([view isKindOfClass:[RssBtn class]]) {
                RssBtn * btn = (RssBtn *)view;
                [btn removeFromSuperview];
            }
        }
        [self createBtn];
        for (UIView * view in self.scrollView.subviews) {
            if ([view isKindOfClass:[RssBtn class]]) {
                RssBtn * btn = (RssBtn *)view;
                btn.isDelete = YES;
            }
        }
        
        
    }else{
        //处于正常状态
        ZJLog(@"处于正常状态");
        RssListViewController * ctrl = [[RssListViewController alloc] init];
        ctrl.model = model;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    
}

- (void)createData
{
    NSArray * array = [DatabaseTool getRss];
    self.rssListArray = [[NSMutableArray alloc] initWithArray:array];
}

- (void)createScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    //添加label
    UILabel * label= [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 150, 40)];
    [self.scrollView addSubview:label];
    label.text = @"我的订阅";
    
    [self createBtn];
}

- (void)createBtn
{
    CGFloat gap = 20;
    CGFloat w = (Screen_Width-6*gap)/3.0;
    CGFloat h = 25;
    for (int i = 0; i < self.rssListArray.count; i++) {
        CGFloat x = gap*2+(w+gap)*(i%3);
        CGFloat y = 30+gap+(h+gap)*(i/3);
        RssBtn * rssBtn = [[RssBtn alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [rssBtn addTarget:self action:@selector(clickRssBtn:) forControlEvents:UIControlEventTouchUpInside];
        rssBtn.tag = RssBtn_Tag + i;
        rssBtn.isDelete= NO;
        RssListModel * model = self.rssListArray[i];
        rssBtn.listModel = model;
        [self.scrollView addSubview:rssBtn];
    }
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width,(h+gap)*(self.rssListArray.count/3+1));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

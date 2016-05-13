//
//  FirstViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "FirstViewController.h"
#import "TouTiaoView.h"
#import "RssView.h"
#import "DatabaseTool.h"
#import "ChanneListModel.h"
#import "FDSlideBar.h"
#import "RssManageViewController.h"


@interface FirstViewController () <TouTiaoViewDelegate,RssViewDelegate,UIScrollViewDelegate>
/** 首页的固定视图 */
@property (nonatomic ,strong) TouTiaoView * touTiaoView;
/** 分页的滚动视图 */
@property (nonatomic ,strong) UIScrollView * scrollView;
/* 滚动标签视图 **/
@property (nonatomic ,strong) FDSlideBar * slideBar;
/** slideBar显示的数据 */
@property (nonatomic ,strong) NSArray * slideBarTitleArray;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createScrollView];
    
}
/** 页面将要显示时调用 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航条
    [self createNavitation];
    //更新订阅导航
    [self createSlideBar];
    //添加订阅页面
    [self addRSSView];
    // 设置订阅导航的指示
    [self setSlideBarItemAtIndex];
}

//获得所有订阅的名称的数组
- (NSArray *)slideBarTitleArray
{
    NSMutableArray * arrayM = [[NSMutableArray alloc] initWithObjects:@"首页", nil];
    NSArray * array = [DatabaseTool getRss];
    for (RssListModel * model in array) {
        NSString * title = model.name;
        [arrayM addObject:title];
    }
    return [NSArray arrayWithArray:arrayM];
}
- (void)createNavitation
{
    //导航颜色
    self.navigationController.navigationBar.barTintColor = ZJColor(55, 111, 233);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //添加管理订阅按钮
    UIButton * rssManagerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rssManagerBtn.frame = CGRectMake(0, 0, 80, 30);
    [rssManagerBtn setTitle:@"管理订阅" forState:UIControlStateNormal];
    /*[rssManagerBtn setTitle:@"完成" forState:UIControlStateSelected];
    rssManagerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //[rssManagerBtn setBackgroundImage:[UIImage imageNamed:@"file_tital_but_press"] forState:UIControlStateNormal];*/
    [rssManagerBtn addTarget:self action:@selector(clickRssManagerBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rssManagerBtn];
}


/** 点击订阅管理 */
- (void)clickRssManagerBtn:(UIButton *)button
{
    RssManageViewController * ctrl = [[RssManageViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 创建页面滚动视图 */
- (void)createScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+36, Screen_Width, Screen_Height-64-48-36)];
    self.scrollView.contentSize = self.scrollView.bounds.size;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    //[self.scrollView setBounces:NO];
    [self.view addSubview:self.scrollView];
    
    //在第一页添加头条页面
    self.touTiaoView = [[TouTiaoView alloc] initWithFrame:self.scrollView.bounds];
    [self.scrollView addSubview:self.touTiaoView];
    self.touTiaoView.delegate = self;
}

/** 添加订阅的视图页面 */
- (void)addRSSView
{
    for (UIView * view in self.scrollView.subviews) {
        if ([view isKindOfClass:[RssView class]]) {
            [view removeFromSuperview];
        }
    }
    NSArray * array = [DatabaseTool getRss];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*(array.count+1), self.scrollView.bounds.size.height);
    for (int i = 0; i < array.count; i++) {
        RssView * view = [[RssView alloc] initWithFrame:CGRectMake(Screen_Width*(i+1), 0, Screen_Width, self.scrollView.bounds.size.height)];
        RssListModel * model = array[i];
        view.model = model;
        view.delegate = self;
        [self.scrollView addSubview:view];
    }
}
/** 创建导航视图SlideBar */
- (void)createSlideBar
{
    [self.slideBar removeFromSuperview];
    self.slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, 36)];
    self.slideBar.backgroundColor = [UIColor whiteColor];
    self.slideBar.itemsTitle = self.slideBarTitleArray;
    //self.slideBar.itemColor = [UIColor whiteColor];
    self.slideBar.itemSelectedColor = ZJColor(55, 111, 233);
    self.slideBar.sliderColor = ZJColor(55, 111, 233);
    
    [self.slideBar slideBarItemSelectedCallback:^(NSUInteger idx) {
        NSLog(@"%ld",idx);
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentOffset = CGPointMake(Screen_Width*idx, 0);
        }];
    }];
    [self.view addSubview:self.slideBar];
}

/** 设置订阅导航的指示 */
- (void)setSlideBarItemAtIndex
{
    NSInteger index = self.scrollView.contentOffset.x/self.scrollView.bounds.size.width;
    [self.slideBar selectSlideBarItemAtIndex:index];
}
#pragma mark UIScrollView代理方法
/** 页面停止滚动式调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    [self.slideBar selectSlideBarItemAtIndex:index];
}

#pragma mark TouTiaoView 和 RssView 的代理方法
/** 推出下一个视图控制器 */
- (void)pushViewController:(UIViewController *)ctrl
{
    [self.navigationController pushViewController:ctrl animated:YES];
}

//#pragma mark RssManageView 代理方法
///** 点击订阅管理视图上的删除功能 */
//- (void)cliclDeleteRss:(RssListModel *)model
//{
//    [DatabaseTool deletRssData:model];
//    //更新订阅导航
//    [self createSlideBar];
//    //添加订阅页面
//    [self addRSSView];
//    // 设置订阅导航的指示
//    [self setSlideBarItemAtIndex];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

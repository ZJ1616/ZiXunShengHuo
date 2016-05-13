//
//  MainTabBarController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "MainTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "FourthViewController.h"
#import "MainNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建分栏控制器
- (void)createViewControllers
{
    //设置图片
    NSArray * images = @[@"bottom_bar_tuijian_n@2x",@"bottom_bar_pindao_n@2x",@"bottom_bar_faxian_n@2x"];
    //设置被选中的图片
    NSArray * selectImages = @[@"bottom_bar_tuijian_h@2x",@"bottom_bar_pindao_h@2x",@"bottom_bar_faxian_h@2x"];
    //设置标题
    NSArray *nameArray = @[@"我的订阅",@"全部订阅",@"发现更多"];
    //把视图控制器装进数组
    NSArray *ctrlArray = @[@"FirstViewController",@"SecondViewController",@"FourthViewController"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<ctrlArray.count; i++) {
        //视图控制器
        Class cls = NSClassFromString(ctrlArray[i]);
        UIViewController *ctrl = [[cls alloc] init];
        ctrl.tabBarItem.title = nameArray[i];
        ctrl.tabBarItem.image = [UIImage imageNamed:images[i]];
        ctrl.tabBarItem.selectedImage = [UIImage imageNamed:selectImages[i]];
        //导航
        MainNavigationController *navCtrl = [[MainNavigationController alloc] initWithRootViewController:ctrl];
        ctrl.title = nameArray[i];
        [array addObject:navCtrl];
    }
    self.viewControllers = array;
    self.tabBar.barTintColor = ZJColor(235, 235, 235);
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

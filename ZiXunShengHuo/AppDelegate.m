//
//  AppDelegate.m
//  ZiXunShengHuo
//
//  Created by qianfeng on 16/4/1.
//  Copyright © 2016年 周杰. All rights reserved.
//  友盟 570285c7e0f55adcf400277f

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "DatabaseTool.h"
#import <CoreLocation/CoreLocation.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"


@interface AppDelegate () <CLLocationManagerDelegate>
/** 定位管理 */
@property (nonatomic, strong) CLLocationManager * locationManager;
@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //ShareSDK设置
    [ShareSDK registerApp:@"11e62b221a352" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
                default:
                break;
        }
    } onConfiguration:nil];
    
    
    
    //获得位置信息
    [self getLocation];
    //设置窗口跟视图控制器是MainTableBarController
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[MainTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

/** 获得位置信息 */
- (void)getLocation
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    //NSLocationAlwaysUsageDescription == YES
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

/** 定位失败 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error
{
    NSLog(@"定位出错%@", error);
}

/** 定位成功 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //定位成功后 保存经纬度信息
    CLLocation * location = [locations lastObject];
    CLLocationCoordinate2D coor = location.coordinate;
    NSLog(@"lat:%lf,lon:%lf", coor.latitude, coor.longitude);;
    [self.locationManager stopUpdatingLocation];
    NSMutableDictionary * coor2D = [[NSMutableDictionary alloc] init];
    [coor2D setObject:@(coor.latitude) forKey:@"latitude"];
    [coor2D setObject:@(coor.longitude) forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] setObject:coor2D forKey:@"coor2D"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

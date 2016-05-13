//
//  WeatherSetViewController.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 周杰. All rights reserved.
//   天气设置界面

#import "BaseViewController.h"

@protocol WeatherSetViewControllerDelegate <NSObject>

- (void)setWeatherCity:(NSString *)city;

@end
@class WeatherModel;
@interface WeatherSetViewController : BaseViewController
/** 天气数据模型 */
@property (nonatomic, strong) WeatherModel * weatherModel;
/** 城市名 */
@property (nonatomic ,copy) NSString * nowcity;
/** 代理属性 修改天气头视图城市 */
@property (nonatomic ,weak) id<WeatherSetViewControllerDelegate> delegate;
@end

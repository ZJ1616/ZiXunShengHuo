//
//  WeatherHeadView.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 周杰. All rights reserved.
//  模块3的头视图

#import <UIKit/UIKit.h>

@protocol WeatherHeadViewDelegate <NSObject>

- (void)pushWeatherSetViewController;

@end

@interface WeatherHeadView : UIView
@property (nonatomic ,weak) id<WeatherHeadViewDelegate> delegate;
@property (nonatomic ,copy) NSString * city;
@end

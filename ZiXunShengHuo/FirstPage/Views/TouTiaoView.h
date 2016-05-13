//
//  TouTiaoView.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsViewController;
@protocol TouTiaoViewDelegate <NSObject>

/** TouTiaoView代理属性 */
- (void)pushViewController:(UIViewController *)ctrl;

@end

@interface TouTiaoView : UIView

@property (nonatomic ,weak) id<TouTiaoViewDelegate> delegate;

@end

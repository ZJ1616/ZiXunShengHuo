//
//  RssView.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RssViewDelegate <NSObject>
/** RssView代理属性 */
- (void)pushViewController:(UIViewController *)ctrl;
@end
@class RssListModel;
@interface RssView : UIView
/**
 *  传递来的模型
 */
@property (nonatomic ,strong) RssListModel * model;
@property (nonatomic ,weak) id<RssViewDelegate> delegate;
@end

//
//  NearCell.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NearCellDelegate <NSObject>

- (void)pushNearViewController:(UIViewController *)ctrl;

@end

@interface NearCell : UITableViewCell
/** 推出附近页面的代理方法 */
@property (nonatomic ,weak) id<NearCellDelegate>  delegate;
@end

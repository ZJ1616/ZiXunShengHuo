//
//  SetToolCell.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/22.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetToolCellDelegate <NSObject>
/** 推出收藏页面 */
- (void)pushFavorietViewController;
/** 推出最近页面 */
- (void)pushRecentViewController;
/** 推出设置页面 */
- (void)pushSetViewController;
@end

@interface SetToolCell : UITableViewCell
/** 设置cell的代理属性 推出相应的页面 */
@property (nonatomic, weak) id<SetToolCellDelegate> delegate;

@end

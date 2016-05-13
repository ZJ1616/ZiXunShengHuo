//
//  CoachTimeCell.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoachTimeResultList;
@interface CoachTimeCell : UITableViewCell
/** 模型 */
@property (nonatomic ,strong) CoachTimeResultList * model;
/** 复用 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

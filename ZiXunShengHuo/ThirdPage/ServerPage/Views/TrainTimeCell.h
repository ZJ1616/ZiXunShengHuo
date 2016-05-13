//
//  TrainTimeCell.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/29.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TrainTimeList;
@interface TrainTimeCell : UITableViewCell
/** 一个车次的信息 */
@property (nonatomic, strong) TrainTimeList * model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

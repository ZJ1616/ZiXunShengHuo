//
//  ExpressDataCell.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExpressDataModel;
@interface ExpressDataCell : UITableViewCell
/** 快递详细信息模型 */
@property (nonatomic ,strong) ExpressDataModel * model;
/** 自定义复用方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/** 计算cell高度 */
+ (CGFloat)getCellHeight:(ExpressDataModel *)model;
@end

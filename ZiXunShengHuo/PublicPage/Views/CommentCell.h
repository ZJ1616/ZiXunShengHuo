//
//  CommentCell.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Commentinfolist;
@interface CommentCell : UITableViewCell
/** 复用 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)computeCellHeight:(Commentinfolist *)model;
@property (nonatomic, strong) Commentinfolist * model;
@end

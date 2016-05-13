//
//  MovieDescCell.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchMovieResult;
@interface MovieDescCell : UITableViewCell
/** 复用 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/** 模型 */
@property (nonatomic ,strong) SearchMovieResult * model;
/** 计算cell高度 */
+ (CGFloat)computeCellHeight:(SearchMovieResult *)model;
@end

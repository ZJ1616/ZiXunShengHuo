//
//  MovieRecCell.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchMovieResultVideo_Rec;
@interface MovieRecCell : UITableViewCell
@property (nonatomic ,strong) SearchMovieResultVideo_Rec * model;
/** 复用 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

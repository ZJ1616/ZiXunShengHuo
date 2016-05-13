//
//  MovieFirstCell.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchMovieResult;
@protocol MovieFirstCellDelegate <NSObject>

- (void)clickbutton;

@end

@interface MovieFirstCell : UITableViewCell
/** 复用 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/** 模型 */
@property (nonatomic ,strong) SearchMovieResult * model;
@property (nonatomic ,weak) id<MovieFirstCellDelegate> delegate;
@end

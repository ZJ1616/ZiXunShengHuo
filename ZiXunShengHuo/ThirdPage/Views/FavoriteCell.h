//
//  FavoriteCell.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/20.
//  Copyright © 2016年 周杰. All rights reserved.
//  收藏列表里面的CELL

#import <UIKit/UIKit.h>

@class NewsSimpleModel;
@interface FavoriteCell : UITableViewCell
/** 传入模型创建Cell数据 */
- (void)configCellWithModel:(NewsSimpleModel *)model;
@end

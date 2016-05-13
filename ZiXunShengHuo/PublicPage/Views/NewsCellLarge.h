//
//  MyTableViewCell.h
//  XMtext
//
//  Created by qianfeng on 16/3/10.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsSimpleModel;
@interface NewsCellLarge : UITableViewCell
@property (strong, nonatomic) UIImageView *picImageView;
@property (strong, nonatomic) UILabel *titleLabe;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel * descLabel;
- (void)configCellWithModel:(NewsSimpleModel *)model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

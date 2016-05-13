//
//  MyTableViewCell.h
//  XMtext
//
//  Created by qianfeng on 16/3/10.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsSimpleModel;
@interface NewsCell : UITableViewCell

@property (strong, nonatomic)  UIImageView *picImageView;
@property (strong, nonatomic)  UILabel *titleLabe;
@property (strong, nonatomic)  UILabel *subTitleLabel;
@property (nonatomic, assign) CGFloat cellHeight;

- (void)configCellWithModel:(NewsSimpleModel *)model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

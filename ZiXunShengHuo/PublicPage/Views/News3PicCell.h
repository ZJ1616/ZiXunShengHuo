//
//  News3PicCell.h
//  ZiXunShengHuo
//
//  Created by 周杰 on 16/4/19.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsSimpleModel;
@interface News3PicCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *picImageView1;
@property (strong, nonatomic)  UIImageView *picImageView2;
@property (strong, nonatomic)  UIImageView *picImageView3;
@property (strong, nonatomic)  UILabel *titleLabe;
@property (strong, nonatomic)  UILabel *subTitleLabel;
@property (nonatomic, strong) NewsSimpleModel * model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

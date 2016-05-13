//
//  MovieRecCell.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "MovieRecCell.h"
#import "SearchMovieModel.h"
#import "UIImageView+WebCache.h"

@interface MovieRecCell ()
@property (nonatomic ,strong) UIImageView * coverImageView;
@property (nonatomic ,strong) UILabel * titleLabel;

@end

@implementation MovieRecCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/** 复用 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellID = @"MovieRecCellID";
    MovieRecCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MovieRecCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellUI];
    }
    return self;
}

- (void)createCellUI
{
    self.coverImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.coverImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
}

- (void)setModel:(SearchMovieResultVideo_Rec *)model
{
    CGFloat gap = 20;
    CGFloat imageX = gap;
    CGFloat imageY = 5;
    CGFloat imageW = 50;
    CGFloat imageH = 70;
    self.coverImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    
    CGFloat labelX = gap+imageW+gap;
    CGFloat labelY = imageY;
    CGFloat labelW = Screen_Width-30-labelX;
    CGFloat labelH = imageH;
    self.titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    self.titleLabel.text = model.title;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
}
@end

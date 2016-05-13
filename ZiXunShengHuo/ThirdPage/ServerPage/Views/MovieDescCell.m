//
//  MovieDescCell.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "MovieDescCell.h"
#import "SearchMovieModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"

@interface MovieDescCell ()
/** 标题 */
@property (nonatomic ,strong) UILabel * titleLabel;
/** 详情 */
@property (nonatomic ,strong) UILabel * descLabel;
/** 按钮 */
@property (nonatomic ,strong) UIButton * moreButton;
@end

@implementation MovieDescCell

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
    static NSString * cellID = @"MovieDescCellID";
    MovieDescCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MovieDescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    //CGFloat gap = 10;
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    
    
    self.descLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.descLabel];
    
//    CGFloat btnX = titleX;
//    CGFloat btnY = CGRectGetMaxY(self.titleLabel.frame);
//    CGFloat btnW = titleW;
//    CGFloat btnH = 60;
//    self.moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.moreButton.frame  =CGRectMake(btnX, btnY, btnW, btnH);
//    self.moreButton.backgroundColor = [UIColor grayColor];
//    [self.moreButton addTarget:self action:@selector(clickMoreButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickMoreButton
{
    ZJLog(@"clickMoreButton");
}

- (void)setModel:(SearchMovieResult *)model
{
    CGFloat titleX = 20;
    CGFloat titleY = 0;
    CGFloat titleW = Screen_Width-40;
    CGFloat titleH = 30;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    self.titleLabel.text = @"剧情简介";
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    
    CGFloat descX = titleX;
    CGFloat descY = CGRectGetMaxY(self.titleLabel.frame);
    CGFloat descW = titleW;
    //CGFloat descH = 60;
    self.descLabel.text = model.desc;
    self.descLabel.font = [UIFont systemFontOfSize:14];
    self.descLabel.numberOfLines = 0;
    CGSize h = [model.desc sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_Width-40, MAXFLOAT)];
    self.descLabel.frame = CGRectMake(descX, descY, descW, h.height);
}

+ (CGFloat)computeCellHeight:(SearchMovieResult *)model
{
    return [model.desc sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_Width-40, MAXFLOAT)].height+35;
}
@end

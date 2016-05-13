//
//  MovieFirstCell.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "MovieFirstCell.h"
#import "SearchMovieModel.h"
#import "UIImageView+WebCache.h"

@interface MovieFirstCell ()
/** 图片 */
@property (nonatomic ,strong) UIImageView * coverImageView;
/** 片名 */
@property (nonatomic ,strong) UILabel * titleLabel;
/** 演员 */
@property (nonatomic ,strong) UILabel * actLabel;
/** 类型 */
@property (nonatomic ,strong) UILabel * tagLabel;
/** 时间 */
@property (nonatomic ,strong) UILabel * otherLabel;
/** 播放按钮 */
@property (nonatomic ,strong) UIButton * playButton;
@end

@implementation MovieFirstCell

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
    static NSString * cellID = @"MovieFirstCellID";
    MovieFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MovieFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //cell.contentView.backgroundColor = [UIColor grayColor];
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
    //图片
    CGFloat gap = 10;
    CGFloat imageX = 20;
    CGFloat imageY = 20;
    CGFloat imageW = Screen_Width*184/530.0;
    CGFloat imageH = Screen_Width*258/530.0;
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    [self.contentView addSubview:self.coverImageView];
    //self.coverImageView.backgroundColor = [UIColor blueColor];
    
    //片名
    CGFloat titleX = CGRectGetMaxX(self.coverImageView.frame)+gap;
    CGFloat titleY = 20;
    CGFloat titleW = Screen_Width-imageW-3*gap;
    CGFloat titleH = imageH/5.0;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    //演员
    CGFloat actX = CGRectGetMaxX(self.coverImageView.frame)+gap;
    CGFloat actY = CGRectGetMaxY(self.titleLabel.frame);
    CGFloat actW = Screen_Width-imageW-3*gap;
    CGFloat actH = imageH/5.0;
    self.actLabel = [[UILabel alloc] initWithFrame:CGRectMake(actX, actY, actW, actH)];
    self.actLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.actLabel];
    
    //类型
    CGFloat tagX = CGRectGetMaxX(self.coverImageView.frame)+gap;
    CGFloat tagY = CGRectGetMaxY(self.actLabel.frame);
    CGFloat tagW = Screen_Width-imageW-3*gap;
    CGFloat tagH = imageH/5.0;
    self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(tagX, tagY, tagW, tagH)];
    self.tagLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.tagLabel];
    
    //时间 地区
    CGFloat otherX = CGRectGetMaxX(self.coverImageView.frame)+gap;
    CGFloat otherY = CGRectGetMaxY(self.tagLabel.frame);
    CGFloat otherW = Screen_Width-imageW-3*gap;
    CGFloat otherH = imageH/5.0;
    self.otherLabel = [[UILabel alloc] initWithFrame:CGRectMake(otherX, otherY, otherW, otherH)];
    self.otherLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.otherLabel];
    
    //播放
    CGFloat btnX = CGRectGetMaxX(self.coverImageView.frame)+gap;
    CGFloat btnY = CGRectGetMaxY(self.otherLabel.frame);
    CGFloat btnW = Screen_Width-imageW-3*gap;
    CGFloat btnH = imageH/5.0;
    self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [self.playButton setTitle:@"进入播放页面" forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(playMovie) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.playButton];
    
    
    
}

- (void)setModel:(SearchMovieResult *)model
{
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    
    self.titleLabel.text = [NSString stringWithFormat:@"片名:%@",model.title];
    
    self.actLabel.text = [NSString stringWithFormat:@"演员:%@",model.act];
    
    self.tagLabel.text = [NSString stringWithFormat:@"类型:%@",model.tag];
    
    self.otherLabel.text = [NSString stringWithFormat:@"地区:%@/%@",model.area,model.year];
    
}

- (void)playMovie
{
    [self.delegate clickbutton];
}
@end

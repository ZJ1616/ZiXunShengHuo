//
//  ChanneListCell.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/22.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "ChanneListCell.h"
#import "ChanneListModel.h"
#import "UIImageView+WebCache.h"
#import "DatabaseTool.h"

@interface ChanneListCell ()
@property (nonatomic ,strong) UIImageView * iconImageView;
@property (nonatomic ,strong) UILabel * iconLabel;
@property (nonatomic ,strong) UILabel * descLabel;
@property (nonatomic ,strong) UIButton * rssButton;

@end

@implementation ChanneListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat gap = Screen_Width*(15/382.0);
        CGFloat imgX = gap;
        CGFloat imgY = gap;
        CGFloat imgW = Screen_Width*(55/382.0);
        CGFloat imgH = imgW;
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
        [self addSubview:self.iconImageView];
        
        CGFloat iconX = gap+imgW+gap;
        CGFloat iconY = imgY;
        CGFloat iconW = 150;
        CGFloat iconH = imgH*0.6;
        self.iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        self.iconLabel.font = [UIFont systemFontOfSize:17];
        self.iconLabel.numberOfLines = 1;
        [self addSubview:self.iconLabel];
        
        
        CGFloat descX = iconX;
        CGFloat descY = iconY+iconH;
        CGFloat descW = iconW;
        CGFloat descH = imgH*0.4;
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(descX, descY, descW, descH)];
        self.descLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.descLabel];
        
        self.cellHeight = imgX+imgY+imgH;
        
        
        CGFloat btnW = Screen_Width*(60/382.0);
        CGFloat btnH = Screen_Width*(27/382.0);
        CGFloat btnX = Screen_Width-gap-btnW;
        CGFloat btnY = (self.cellHeight-btnH)/2;
        
        
        self.rssButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.rssButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [self.rssButton setTitle:@"订阅" forState:UIControlStateNormal];
        [self.rssButton setTitle:@"已订阅" forState:UIControlStateSelected];
        [self.rssButton addTarget:self action:@selector(clickRssButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rssButton];
        
        
        
        
        
    }
    return self;
}

- (void)clickRssButton:(UIButton *)button
{
    if (button.isSelected==YES) {
        [DatabaseTool deletRssData:self.ListModel];
        button.selected = NO;
    }else{
        button.selected = YES;
        [DatabaseTool addRss:self.ListModel];
    }
    
}
- (void)setListModel:(RssListModel *)ListModel
{
    _ListModel = ListModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:ListModel.iconUrl]];
    self.iconLabel.text = ListModel.name;
    self.descLabel.text = ListModel.desc;
    
    
    if ([DatabaseTool selectRssDataIsExist:self.ListModel]) {
        self.rssButton.selected = YES;
    }else{
        self.rssButton.selected = NO;
    }
}

@end

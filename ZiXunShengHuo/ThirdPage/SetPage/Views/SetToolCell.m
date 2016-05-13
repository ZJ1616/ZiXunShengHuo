//
//  SetToolCell.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/22.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "SetToolCell.h"
#import "RecentViewController.h"
#import "FavoriteViewController.h"
#import "DatabaseTool.h"

@implementation SetToolCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/** 构造方法*/
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    CGFloat btnW = Screen_Width/3.0;
    CGFloat btnH = 70;
    
    UIControl * recentBtn = [self createBtnControlWithFrame:CGRectMake(0, 0, btnW, btnH) title:@"最近" imageName:@"personal_icon_history"];
    [self addSubview:recentBtn];
    [recentBtn addTarget:self action:@selector(clickRecentBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIControl * favoriteBtn = [self createBtnControlWithFrame:CGRectMake(btnW, 0, btnW, btnH) title:@"收藏" imageName:@"personal_icon_collection"];
    [self addSubview:favoriteBtn];
    [favoriteBtn addTarget:self action:@selector(clickFavoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIControl * setBtn = [self createBtnControlWithFrame:CGRectMake(btnW*2, 0, btnW, btnH) title:@"设置" imageName:@"personal_icon_setting"];
    [self addSubview:setBtn];
    [setBtn addTarget:self action:@selector(clickSetBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickRecentBtn:(UIControl *)RecentBtn
{
    ZJLog(@"Recent");
    [self.delegate pushRecentViewController];
}
- (void)clickFavoriteBtn:(UIControl *)favoriteBtn
{
    ZJLog(@"Favorite");
    [self.delegate pushFavorietViewController];
}
- (void)clickSetBtn:(UIControl *)setBtn
{
    ZJLog(@"Set");
    [self.delegate pushSetViewController];
}

- (UIControl *)createBtnControlWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName
{
    UIControl * btnControl = [[UIControl alloc] initWithFrame:frame];
    
    CGFloat w = btnControl.bounds.size.width;
    CGFloat h = btnControl.bounds.size.height;
    
    UIImageView * iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0.4*h, 0.4*h)];
    iconImageView.image = [UIImage imageNamed:imageName];
    iconImageView.center = CGPointMake(btnControl.bounds.size.width/2, 0.4*h);
    //iconImageView.contentMode = UIViewContentModeCenter;
    [btnControl addSubview:iconImageView];
    
    UILabel * iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.6*h, w, 0.4*h)];
    iconLabel.text = title;
    iconLabel.textAlignment = NSTextAlignmentCenter;
    iconLabel.font = [UIFont systemFontOfSize:13];
    [btnControl addSubview:iconLabel];
    
    return btnControl;
}
@end

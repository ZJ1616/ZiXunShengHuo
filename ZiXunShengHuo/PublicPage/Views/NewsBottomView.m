//
//  NewsBottomView.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/19.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "NewsBottomView.h"
#import "UIButton+ZJ.h"

@interface NewsBottomView ()

/** 查看评论 */
@property (nonatomic, strong) UIButton * commentButton;
/** 收藏 */
@property (nonatomic, strong) UIButton * favoriteButton;
/** 分享 */
@property (nonatomic, strong) UIButton * shareButton;
@end

@implementation NewsBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createView];
        self.backgroundColor = ZJColor(235, 235, 235);
    }
    return self;
}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    if (isSelect) {
        self.favoriteButton.selected = isSelect;
    }
}
- (void)createView
{
    self.commentButton = [UIButton createBtnFrame:CGRectMake(0, 0, Screen_Width*(0.6), self.bounds.size.height) backgroundColor:nil title:@"查看评论" titleColor:nil fontSize:16 backgroungImage:nil selectbackgroungImage:nil image:nil target:self action:@selector(commentButtonClick:)];
    [self.commentButton setTitle:@"收起评论" forState:UIControlStateSelected];
    [self addSubview:self.commentButton];
    
    
    self.favoriteButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.commentButton.frame), 0, Screen_Width*(0.2), self.bounds.size.height)];
    [self.favoriteButton setImage:[UIImage imageNamed:@"detail_icon_favorite_normal"] forState:UIControlStateNormal];
    self.favoriteButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.favoriteButton setImage:[UIImage imageNamed:@"detail_icon_favorite__select"] forState:UIControlStateSelected];
    [self.favoriteButton addTarget:self action:@selector(favoriteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.favoriteButton];
    
    
    self.shareButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.favoriteButton.frame), 0, Screen_Width*(0.2), self.bounds.size.height)];
    [self.shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.shareButton.titleLabel.font = [UIFont systemFontOfSize:16];
    //[self.shareButton setImage:[UIImage imageNamed:@"rightEar_share_on"] forState:UIControlStateNormal];
    //self.shareButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.shareButton];
    
}

- (void)commentButtonClick:(UIButton *)button
{
    [self.delegate clickCommentButton:button];
}
- (void)favoriteButtonClick:(UIButton *)button
{
    [self.delegate clickFavoriteButton:button];
}
- (void)shareButtonClick
{
    
    [self.delegate clickShareButton];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

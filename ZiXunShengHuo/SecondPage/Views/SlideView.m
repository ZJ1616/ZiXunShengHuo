//
//  SlideView.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "SlideView.h"

@interface SlideView ()
/** 背景视图 */
@property (nonatomic ,strong) UIView * bgView;
/** 宽度 */
@property (nonatomic ,assign) CGFloat Width;
/** 标签高度 */
@property (nonatomic ,assign) CGFloat labelHeight;

/** 标题数组 */
@property (nonatomic ,strong) NSArray * titleArray;
/** 图标数组 */
@property (nonatomic ,strong) NSArray * titleImageArray;

@property (nonatomic ,strong) UIView * leftView;
@property (nonatomic ,strong) UIView * rightView;
@end

@implementation SlideView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.Width = Screen_Width/5.0;
        self.labelHeight = 40;
        
        [self createView];
    }
    return self;
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
    self.leftView.backgroundColor = self.bgColor;
    self.rightView.backgroundColor = self.bgColor;
    
}
- (void)createView
{
    //白色圆圈
    UIImage * whiteImage = [UIImage imageNamed:@"mc_switch_thumb_activated_color_white"];
    UIImageView * whiteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.Width*2, 20, self.Width, 44)];
    whiteImageView.image = whiteImage;
    whiteImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:whiteImageView];
    //添加背景视图
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(self.Width*2, 0, self.Width*self.titleArray.count, self.bounds.size.height)];
    [self addSubview:self.bgView];
    
    //背景视图上添加图片
    //背景视图上添加标签
    for (int i = 0; i < self.titleArray.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.Width*i, 20, self.Width, 44)];
        imageView.image = [UIImage imageNamed:self.titleImageArray[i]];
        imageView.contentMode = UIViewContentModeCenter;
        [self.bgView addSubview:imageView];
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(self.Width*i, 64, self.Width, self.labelHeight)];
        label.text = self.titleArray[i];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:label];
    }
    //左边的遮盖视图
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.Width*2, self.bounds.size.height-self.labelHeight)];
    [self addSubview:self.leftView];
    //右边的遮盖视图
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(3*self.Width, 0, self.Width*2, self.bounds.size.height-self.labelHeight)];
    [self addSubview:self.rightView];
    
    //
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.Width, 4)];
    lineView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height-2);
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.alpha = 0.5;
    [self addSubview:lineView];
}

- (void)setX:(CGFloat)x
{
    _x = x;
    self.bgView.frame = CGRectMake(self.Width*2+x, 0, self.Width*self.titleArray.count, self.bounds.size.height);
}

- (NSArray *)titleArray
{
    
    if (_titleArray == nil) {
        _titleArray = @[@"推荐" ,@"娱乐" ,@"天下事" ,@"科技" ,@"搞笑" ,@"焦点" ,@"影视" ,@"财经" ,@"体育" ,@"游戏" ,@"情感" ,@"生活" ,@"视觉" ,@"创意" ,@"汽车"];
    }
    return _titleArray;
    
}

- (NSArray *)titleImageArray
{
    if (_titleImageArray == nil) {
        _titleImageArray = @[@"ic_guide_recommend_checked" ,@"ic_rss_entertainment_noside" ,@"ic_rss_news_noside" ,@"ic_rss_technology_noside" ,@"ic_rss_funny_noside" ,@"ic_rss_focus_noside" ,@"ic_rss_movies_noside" ,@"ic_rss_economic_noside" ,@"ic_rss_sport_noside" ,@"ic_rss_game_noside" ,@"ic_rss_emotion_noside" ,@"ic_rss_life_noside" ,@"ic_rss_vision_noside" ,@"ic_rss_originality_noside" ,@"ic_rss_car_noside"];
    }
    return _titleImageArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

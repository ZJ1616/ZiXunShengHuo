//
//  NewsBottomView.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/19.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  新闻页面底部的控制栏
 */
/**
 *  新闻页面底部的控制栏代理方法
 */
@protocol NewsBottomViewDelegate <NSObject>
/**
 *  点击了查看评论
 */
- (void)clickCommentButton:(UIButton *)button;
/**
 *  点击了收藏
 */
- (void)clickFavoriteButton:(UIButton *)button;
/**
 *  点击了分享
 */
- (void)clickShareButton;

@end

@interface NewsBottomView : UIView
@property (nonatomic, assign) BOOL isSelect;
/** NewsBottomView代理属性 */
@property (nonatomic, weak) id<NewsBottomViewDelegate> delegate;

@end

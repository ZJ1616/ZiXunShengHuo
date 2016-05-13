//
//  TouTiaoHeadView.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

/**
 *  头视图（滚动视图和2个Button）
 */
@class HomeHeadModel;

#import <UIKit/UIKit.h>


@protocol  TouTiaoHeadViewDelegate<NSObject>
/**
 *  点击网友热议
 */
- (void)clickHotdebateButton:(NSString *)articleUrl;
/**
 *  点击药不能停
 */
- (void)clickSpecialTopicButton:(NSString *)articleUrl;
/**
 *  点击滚动视图的图片
 */
- (void)clickAdNews:(NSString *)articleUrl index:(NSInteger)index;

@end


@interface TouTiaoHeadView : UIView

//**头视图数据模型*/
@property (nonatomic ,strong) HomeHeadModel * headModel;
/** 代理属性 */
@property (nonatomic ,weak) id<TouTiaoHeadViewDelegate> delegate;

@end

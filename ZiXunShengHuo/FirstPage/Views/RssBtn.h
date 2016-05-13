//
//  rssBtn.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RssListModel;

@interface RssBtn : UIControl
/** 订阅模型 */
@property (nonatomic ,strong) RssListModel * listModel;

/** 显示订阅名字 */
@property (nonatomic ,strong) UILabel * nameLabel;
/** 显示删除图标 */
@property (nonatomic ,strong) UIImageView * deleteImageView;
/** 是否处于删除状态 */
@property (nonatomic ,assign) BOOL  isDelete;
@end

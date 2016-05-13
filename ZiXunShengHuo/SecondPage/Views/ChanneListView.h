//
//  ChanneListView.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChanneListModel;
@class RssListModel;
@protocol ChanneListViewDelegate <NSObject>
//点击ChanneListButton
- (void)clickChanneListButton:(RssListModel *)listModel;
@end


@interface ChanneListView : UIView
/**一个频道列表的Model*/
@property (nonatomic ,strong) ChanneListModel * listModel;
//代理属性
@property (nonatomic, weak) id<ChanneListViewDelegate> delegate;
@end

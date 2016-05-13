//
//  ChanneListCell.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/22.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RssListModel;

@interface ChanneListCell : UITableViewCell
/** 传过来的模型 */
@property (nonatomic ,strong) RssListModel * ListModel;
/* 记录Cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end

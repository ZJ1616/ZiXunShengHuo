//
//  RssListViewController.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "BaseViewController.h"
/**
 *  订阅列表点击后的详情展示
 */
@class RssListModel;



@interface RssListViewController : BaseViewController

/** 接收到的频道列表模型 */
@property (nonatomic ,strong) RssListModel * model;
@end

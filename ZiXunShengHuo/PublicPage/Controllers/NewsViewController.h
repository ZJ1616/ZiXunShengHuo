//
//  NewsViewController.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//  新闻展示页面

#import "BaseViewController.h"
@class NewsSimpleModel;

@interface NewsViewController : BaseViewController

/** 接收的模型 新闻的简单信息 包含网址 */
@property (nonatomic, strong) NewsSimpleModel * simpleModel;
@end

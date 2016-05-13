//
//  DBManager.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/19.
//  Copyright © 2016年 周杰. All rights reserved.
//  管理收藏

#import <Foundation/Foundation.h>
@class NewsSimpleModel;
@class RssListModel;
@interface DatabaseTool : NSObject


/** 收藏一条新闻 */
+ (void)addFavorite:(NewsSimpleModel *)model;

/** 查询一条收藏 */
+ (BOOL)selectFavoriteDataIsExist:(NewsSimpleModel *)model;

/** 删除一条收藏 */
+ (void)deletFavoriteData:(NewsSimpleModel *)model;
/** 删除所有收藏 */
+ (void)deleteAllFavoriteData;
/** 取出所有收藏 模型 */
+ (NSArray *)getFavoriteData;

/** 添加一条到最近阅读 */
+ (void)addRecent:(NewsSimpleModel *)model;
/** 删除一条最近阅读 */
+ (void)deletRecentData:(NewsSimpleModel *)model;
/** 删除所有收藏 */
+ (void)deleteAllRecentData;
/** 查询一条阅读 */
+ (BOOL)selectRecentDataIsExist:(NewsSimpleModel *)model;

/** 取出所有最近阅读  模型 */
+ (NSArray *)getRecentData;

/** 添加一个订阅 */
+ (void)addRss:(RssListModel *)model;

/** 查询一条订阅 */
+ (BOOL)selectRssDataIsExist:(RssListModel *)model;

/** 删除一条订阅 */
+ (void)deletRssData:(RssListModel *)model;
/** 取出所有订阅  模型 */
+ (NSArray *)getRss;

+ (void)cleanCache;
@end

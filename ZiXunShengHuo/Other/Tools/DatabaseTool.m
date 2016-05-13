//
//  DBManager.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/19.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "DatabaseTool.h"
#import "FMDB.h"
#import "HomeHeadModel.h"
#import "ChanneListModel.h"
#import "MJExtension.h"

@implementation DatabaseTool

static FMDatabaseQueue *_queue;

+ (void)initialize
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SQLData.sqlite"];
    NSLog(@"path=%@", path);
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    //收藏
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_favorite (id integer primary key autoincrement, articleId text,time integer, dict blob);"];
    }];
    //历史阅读
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_recent (id integer primary key autoincrement, articleId text,time integer, dict blob);"];
    }];
    //订阅列表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_rss (id integer primary key autoincrement, rssId text, name text,time integer, dict blob);"];
    }];
}

/** 收藏一条新闻 */
+ (void)addFavorite:(NewsSimpleModel *)model
{
    NSMutableDictionary * dictM = [NSMutableDictionary dictionaryWithDictionary:model.mj_keyValues];
    long long time = [[NSDate date] timeIntervalSince1970]*1000;
    [dictM setObject:@(time) forKey:@"putdate"];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dictM];
    
    
    [_queue inDatabase:^(FMDatabase *db) {
        //获得需要缓存的数据
        NSNumber * articleId = model.articleId;
        
        //查询是否存在
        FMResultSet *rs = [db executeQuery:@"select * from t_favorite where articleId = ?",articleId];
        if (rs.next) {
            ZJLog(@"存在");
        }else{
            //存储数据
            
            [db executeUpdate:@"insert into t_favorite (articleId, time, dict) values(?,?,?)",articleId,@(time),data];
            ZJLog(@"添加到收藏 成功");}
    }];
}
/** 删除一条收藏 */
+ (void)deletFavoriteData:(NewsSimpleModel *)model
{
    [_queue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:@"delete from t_favorite where articleId = ?",model.articleId]) {
            ZJLog(@"删除成功");
        }else{
            ZJLog(@"删除失败");
        }
    }];
}
+ (void)deleteAllFavoriteData
{
    [_queue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:@"delete from t_favorite"]) {
            ZJLog(@"删除成功");
        }else{
            ZJLog(@"删除失败");
        }
    }];
}
/** 查询是否收藏 */
+ (BOOL)selectFavoriteDataIsExist:(NewsSimpleModel *)model
{
    __block BOOL ret;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from t_favorite where articleId = ?",model.articleId];
        if (rs.next) {
            ret = YES;
        }else{
            ret = NO;
        }
    }];
    return ret;
}
/** 取出所有收藏 */
+ (NSArray *)getFavoriteData
{
    NSMutableArray * array = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        //查询所有数据
        FMResultSet *rs = [db executeQuery:@"select * from t_favorite order by time desc"];
        while (rs.next) {
            NSData * data = [rs dataForColumn:@"dict"];
            NSDictionary * dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [NewsSimpleModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"desc":@"description"};
            }];
            NewsSimpleModel * model = [NewsSimpleModel mj_objectWithKeyValues:dict];
            [array addObject:model];
        }
    }];
    ZJLog(@"%@",array);
    return array;
}
/** 添加一条到最近阅读 */
+ (void)addRecent:(NewsSimpleModel *)model
{
    NSMutableDictionary * dictM = [NSMutableDictionary dictionaryWithDictionary:model.mj_keyValues];
    long long time = [[NSDate date] timeIntervalSince1970]*1000;
    [dictM setObject:@(time) forKey:@"putdate"];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dictM];
    [_queue inDatabase:^(FMDatabase *db) {
        //获得需要缓存的数据
        NSNumber * articleId = model.articleId;
        
        //查询是否存在
        FMResultSet *rs = [db executeQuery:@"select * from t_recent where articleId = ?",articleId];
        if (rs.next) {
            ZJLog(@"存在");
        }else{
            //存储数据
            
            [db executeUpdate:@"insert into t_recent (articleId, time, dict) values(?,?,?)",articleId,@(time),data];
            ZJLog(@"添加到最近阅读 成功");}
    }];
}
/** 删除一条收藏 */
+ (void)deletRecentData:(NewsSimpleModel *)model
{
    [_queue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:@"delete from t_recent where articleId = ?",model.articleId]) {
            ZJLog(@"删除成功");
        }else{
            ZJLog(@"删除失败");
        }
    }];
}
+ (void)deleteAllRecentData
{
    [_queue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:@"delete from t_recent"]) {
            ZJLog(@"删除成功");
        }else{
            ZJLog(@"删除失败");
        }
    }];
}
/** 查询是否在最近阅读 */
+ (BOOL)selectRecentDataIsExist:(NewsSimpleModel *)model
{
    __block BOOL ret;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from t_recent where articleId = ?",model.articleId];
        if (rs.next) {
            ret = YES;
        }else{
            ret = NO;
        }
    }];
    return ret;
}

/** 取出所有最近阅读 */
+ (NSArray *)getRecentData
{
    NSMutableArray * array = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        //查询所有数据
        FMResultSet *rs = [db executeQuery:@"select * from t_recent order by time desc"];
        while (rs.next) {
            NSData * data = [rs dataForColumn:@"dict"];
            NSDictionary * dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [NewsSimpleModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"desc":@"description"};
            }];
            NewsSimpleModel * model = [NewsSimpleModel mj_objectWithKeyValues:dict];
            [array addObject:model];
        }
    }];
    ZJLog(@"%@",array);
    return array;
    
}

/** 添加一个订阅 */
+ (void)addRss:(RssListModel *)model;
{
    NSMutableDictionary * dictM = [NSMutableDictionary dictionaryWithDictionary:model.mj_keyValues];
    long long time = [[NSDate date] timeIntervalSince1970]*1000;
    [dictM setObject:@(time) forKey:@"putdate"];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dictM];
    [_queue inDatabase:^(FMDatabase *db) {
        //获得需要缓存的数据
        NSNumber * rssId = model.Id;
        
        //查询是否存在
        FMResultSet *rs = [db executeQuery:@"select * from t_rss where rssId = ?",rssId];
        if (rs.next) {
            ZJLog(@"存在");
        }else{
            //存储数据
            
            [db executeUpdate:@"insert into t_rss (rssId, time, dict) values(?,?,?)",rssId,@(time),data];
            ZJLog(@"添加到订阅 成功");}
    }];
}

/** 查询是否订阅 */
+ (BOOL)selectRssDataIsExist:(RssListModel *)model
{
    __block BOOL ret;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from t_rss where rssId = ?",model.Id];
        if (rs.next) {
            ret = YES;
        }else{
            ret = NO;
        }
    }];
    return ret;
}
/** 删除一条订阅 */
+ (void)deletRssData:(RssListModel *)model
{
    ZJLog(@"正在删除订阅");
    [_queue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:@"delete from t_rss where rssId = ?",model.Id]) {
            ZJLog(@"删除成功");
        }else{
            ZJLog(@"删除失败");
        }
    }];
}
/** 取出所有订阅 模型 */
+ (NSArray *)getRss
{
    NSMutableArray * array = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        //查询所有数据
        FMResultSet *rs = [db executeQuery:@"select * from t_rss order by time asc"];
        while (rs.next) {
            NSData * data = [rs dataForColumn:@"dict"];
            NSDictionary * dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [RssListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"Id":@"id"};
            }];
            RssListModel * model = [RssListModel mj_objectWithKeyValues:dict];
            [array addObject:model];
        }
    }];
    //ZJLog(@"%@",array);
    return array;

}

+ (void)cleanCache
{
    //获得缓存路径
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    ZJLog(@"%@",path);
    NSFileManager * manager = [NSFileManager defaultManager];
    
    BOOL ret = [manager removeItemAtPath:path error:nil];
    if (ret) {
        ZJLog(@"删除成功");
    }else{
        ZJLog(@"删除失败");
    }
}



@end

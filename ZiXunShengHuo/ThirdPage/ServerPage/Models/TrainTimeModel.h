//
//  TrainTimeModel.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TrainTimeList,TrainTimePrice_List;
@interface TrainTimeModel : NSObject

/** 查询内容的标题 */
@property (nonatomic, copy) NSString *title;
/** 车次信息 */
@property (nonatomic, strong) NSArray<TrainTimeList *> *list;


@end
@interface TrainTimeList : NSObject

@property (nonatomic, copy) NSString *run_distance;
/** 订票网址 */
@property (nonatomic, copy) NSString *m_train_url;
/** 始发站 */
@property (nonatomic, copy) NSString *start_station;
/** 终点站 */
@property (nonatomic, copy) NSString *end_station;
/** 终点站类型 “终” */
@property (nonatomic, copy) NSString *end_station_type;
/** 始发时间 */
@property (nonatomic, copy) NSString *start_time;
/** 查询的网址 */
@property (nonatomic, copy) NSString *m_chaxun_url;
/** 运行时间 */
@property (nonatomic, copy) NSString *run_time;
/** 到站时间 */
@property (nonatomic, copy) NSString *end_time;
/** 票价信息 数组 “可能有多种” */
@property (nonatomic, strong) NSArray<TrainTimePrice_List *> *price_list;
/** 车次类型 */
@property (nonatomic, copy) NSString *train_type;
/** 始发站类型 “始” */
@property (nonatomic, copy) NSString *start_station_type;
/** 车次 */
@property (nonatomic, copy) NSString *train_no;

@end
/** 票价信息 */
@interface TrainTimePrice_List : NSObject
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 座位类型 */
@property (nonatomic, copy) NSString *price_type;

@end


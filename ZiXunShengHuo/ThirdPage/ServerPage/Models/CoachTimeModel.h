//
//  CoachTimeModel.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//  汽车时间表

#import <Foundation/Foundation.h>

@class CoachTimeResult,CoachTimeResultList;
@interface CoachTimeModel : NSObject
/** 结果集 */
@property (nonatomic, strong) CoachTimeResult *result;
/** 状态码 */
@property (nonatomic, assign) NSInteger error_code;
/** 状态 */
@property (nonatomic, copy) NSString *reason;

@end
@interface CoachTimeResult : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 时间列表 */
@property (nonatomic, strong) NSArray<CoachTimeResultList *> *list;

@end

@interface CoachTimeResultList : NSObject
/** 出发时间 */
@property (nonatomic, copy) NSString *date;
/** 到达城市 */
@property (nonatomic, copy) NSString *arrive;
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 出发站点 */
@property (nonatomic, copy) NSString *start;

@end


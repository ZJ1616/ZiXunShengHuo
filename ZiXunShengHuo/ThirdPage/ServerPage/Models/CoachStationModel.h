//
//  CoachTimeModel.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//  汽车站模型

#import <Foundation/Foundation.h>

@class CoachStationResult,CoachStationResultList;
@interface CoachStationModel : NSObject
/** 结果集 */
@property (nonatomic, strong) CoachStationResult *result;
/** 状态码 */
@property (nonatomic, assign) NSInteger error_code;
/** 状态 */
@property (nonatomic, copy) NSString *reason;

@end
@interface CoachStationResult : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 列表数组 */
@property (nonatomic, strong) NSArray<CoachStationResultList *> *list;

@end

@interface CoachStationResultList : NSObject
/** 站名 */
@property (nonatomic, copy) NSString *name;
/** 电话 */
@property (nonatomic, copy) NSString *tel;
/** 地址 */
@property (nonatomic, copy) NSString *adds;

@end


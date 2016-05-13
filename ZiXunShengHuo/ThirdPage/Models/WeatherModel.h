//
//  WeatherModel.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/23.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Weather_Result,Weather_Result_Data,Data_Pm25,Pm25,Data_Life,DataLife_Info,Data_Realtime,DataRealtime_Wind,DataRealtime_Weather,Data_Weather,WeatherArray_Info;
@interface WeatherModel : NSObject
/** 结果集 */
@property (nonatomic, strong) Weather_Result *result;
/** 状态码 */
@property (nonatomic, assign) NSInteger error_code;
/** 状态文字 */
@property (nonatomic, copy) NSString *reason;

@end

@interface Weather_Result : NSObject
/** 结果Data */
@property (nonatomic, strong) Weather_Result_Data *data;

@end

@interface Weather_Result_Data : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) Data_Life *life;

@property (nonatomic, strong) Data_Pm25 *pm25;

@property (nonatomic, strong) Data_Realtime *realtime;

@property (nonatomic, assign) NSInteger isForeign;

@property (nonatomic, strong) NSArray<Data_Weather *> *weather;

@end

@interface Data_Pm25 : NSObject
/** pm25 城市名 */
@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *key;
/** pm25 数据值 */
@property (nonatomic, strong) Pm25 *pm25;
/** pm25 时间 */
@property (nonatomic, copy) NSString *dateTime;

@property (nonatomic, assign) NSInteger show_desc;

@end

@interface Pm25 : NSObject

@property (nonatomic, copy) NSString *pm10;

@property (nonatomic, copy) NSString *quality;

@property (nonatomic, copy) NSString *pm25;

@property (nonatomic, copy) NSString *curPm;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *des;

@end

@interface Data_Life : NSObject
/** life 时间 */
@property (nonatomic, copy) NSString *date;
/** life 详细生活指数 */
@property (nonatomic, strong) DataLife_Info *info;

@end

@interface DataLife_Info : NSObject

@property (nonatomic, strong) NSArray<NSString *> *ganmao;

@property (nonatomic, strong) NSArray<NSString *> *kongtiao;

@property (nonatomic, strong) NSArray<NSString *> *chuanyi;

@property (nonatomic, strong) NSArray<NSString *> *yundong;

@property (nonatomic, strong) NSArray<NSString *> *ziwaixian;

@property (nonatomic, strong) NSArray<NSString *> *wuran;

@property (nonatomic, strong) NSArray<NSString *> *xiche;

@end

@interface Data_Realtime : NSObject

@property (nonatomic, strong) DataRealtime_Wind *wind;

@property (nonatomic, assign) NSInteger dataUptime;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger week;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *city_code;

@property (nonatomic, strong) DataRealtime_Weather *weather;

@property (nonatomic, copy) NSString *city_name;

@property (nonatomic, copy) NSString *moon;

@end

@interface DataRealtime_Wind : NSObject

@property (nonatomic, copy) NSString *windspeed;

@property (nonatomic, copy) NSString *power;

@property (nonatomic, copy) NSString *direct;

@property (nonatomic, copy) NSString *offset;

@end

@interface DataRealtime_Weather : NSObject

@property (nonatomic, copy) NSString *humidity;

@property (nonatomic, copy) NSString *temperature;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *info;

@end

@interface Data_Weather : NSObject

@property (nonatomic, copy) NSString *week;

@property (nonatomic, strong) WeatherArray_Info *info;

@property (nonatomic, copy) NSString *nongli;

@property (nonatomic, copy) NSString *date;

@end

@interface WeatherArray_Info : NSObject

@property (nonatomic, strong) NSArray<NSString *> *night;

@property (nonatomic, strong) NSArray<NSString *> *day;

@end


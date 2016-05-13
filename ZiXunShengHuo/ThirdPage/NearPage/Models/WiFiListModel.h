//
//  WiFiListModel.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WiFiListResult,WiFIList_Pageinfo,WiFi_Result_Data;
@interface WiFiListModel : NSObject
@property (nonatomic, strong) WiFiListResult *result;

@property (nonatomic, copy) NSString *resultcode;

@property (nonatomic, copy) NSString *reason;

@property (nonatomic, assign) NSInteger error_code;

@end
@interface WiFiListResult : NSObject

@property (nonatomic, strong) NSArray<WiFi_Result_Data *> *data;

@property (nonatomic, strong) WiFIList_Pageinfo *pageinfo;

@end

@interface WiFIList_Pageinfo : NSObject

@property (nonatomic, copy) NSString *pnums;

@property (nonatomic, copy) NSString *current;

@end

@interface WiFi_Result_Data : NSObject

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *baidu_lon;

@property (nonatomic, copy) NSString *google_lon;

@property (nonatomic, copy) NSString *baidu_lat;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) NSInteger distance;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *google_lat;

@end


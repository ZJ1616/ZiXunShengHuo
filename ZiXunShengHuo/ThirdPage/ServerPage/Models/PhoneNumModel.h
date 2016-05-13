//
//  PhoneNumModel.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhoneNumModel_result;
@interface PhoneNumModel : NSObject
@property (nonatomic ,copy) NSNumber * error_code;
@property (nonatomic ,copy) NSString * reason;
@property (nonatomic ,strong) PhoneNumModel_result * result;
@end

@class PhoneNumModel_result_Hy;
@interface PhoneNumModel_result : NSObject
@property (nonatomic ,copy) NSString * city;
@property (nonatomic ,copy) NSString * countDesc;
@property (nonatomic ,strong) PhoneNumModel_result_Hy * hy;;
@property (nonatomic ,strong) NSNumber * iszhapian;
@property (nonatomic ,copy) NSString * phone;
@property (nonatomic ,copy) NSString * province;
@property (nonatomic ,copy) NSString * rpt_cnt;
@property (nonatomic ,copy) NSString * rpt_comment;
@property (nonatomic ,copy) NSString * rpt_type;
@property (nonatomic ,copy) NSString * sp;
@end


@interface PhoneNumModel_result_Hy : NSObject
@property (nonatomic ,copy) NSString * city;
@property (nonatomic ,copy) NSString * name;
@property (nonatomic ,copy) NSString * addr;
@property (nonatomic ,copy) NSString * tel;
@end
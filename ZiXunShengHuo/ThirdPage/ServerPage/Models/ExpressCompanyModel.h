//
//  ExpressCompanyModel.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressCompanyModel : NSObject
/** 快递公司code */
@property (nonatomic ,copy) NSString * code;
/** 快递公司名字 */
@property (nonatomic ,copy) NSString * name;
/** 快递公司电话 */
@property (nonatomic ,copy) NSString * tel;
/** 快递公司网址 */
@property (nonatomic ,copy) NSString * web;
@end

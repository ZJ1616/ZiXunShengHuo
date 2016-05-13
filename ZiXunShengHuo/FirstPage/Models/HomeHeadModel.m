//
//  BlocksModel.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "HomeHeadModel.h"

@implementation HomeHeadModel
+ (NSDictionary *)objectClassInArray{
    return @{
             @"blocks" : @"BlockModel",
             };
}
@end

@implementation BlockModel
+ (NSDictionary *)objectClassInArray{
    return @{
             @"data" : @"NewsSimpleModel"
             };
}
@end

@implementation NewsSimpleModel


@end
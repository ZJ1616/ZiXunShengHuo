//
//  TrainTimeModel.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "TrainTimeModel.h"

@implementation TrainTimeModel


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [TrainTimeList class]};
}
@end

@implementation TrainTimeList

+ (NSDictionary *)objectClassInArray{
    return @{@"price_list" : [TrainTimePrice_List class]};
}

@end


@implementation TrainTimePrice_List

@end



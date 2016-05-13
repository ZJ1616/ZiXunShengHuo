//
//  SearchMovieModel.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "SearchMovieModel.h"

@implementation SearchMovieModel

@end

@implementation SearchMovieResult

+ (NSDictionary *)objectClassInArray{
    return @{@"act_s" : [SearchMovieResultAct_S class], @"video_rec" : [SearchMovieResultVideo_Rec class]};
}

@end


@implementation SearchMovieResultPlaylinks

@end


@implementation SearchMovieResultAct_S

@end


@implementation SearchMovieResultVideo_Rec

@end



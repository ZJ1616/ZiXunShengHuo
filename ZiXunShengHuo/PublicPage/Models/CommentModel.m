//
//  CommentModel.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

@end
@implementation CommentValue

+ (NSDictionary *)objectClassInArray{
    return @{@"commentInfoList" : [Commentinfolist class], @"hotCommentInfoList" : [Hotcommentinfolist class], @"commentMappingList" : [Commentmappinglist class]};
}

@end


@implementation Commentinfolist

@end


@implementation Hotcommentinfolist

@end


@implementation Commentmappinglist

@end



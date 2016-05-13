//
//  CommentModel.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CommentValue,Commentinfolist,Hotcommentinfolist,Commentmappinglist;
@interface CommentModel : NSObject
/** 状态码 */
@property (nonatomic, assign) NSInteger code;
/** ？ */
@property (nonatomic, copy) NSString *message;
/** ？ */
@property (nonatomic, copy) NSString *redirect;
/** 评论集合 */
@property (nonatomic, strong) CommentValue *value;

@end
@interface CommentValue : NSObject
/** 热门评论 */
@property (nonatomic, strong) NSArray<Commentinfolist *> *hotCommentInfoList;
/** 评论信息列表 */
@property (nonatomic, strong) NSArray<Commentinfolist *> *commentInfoList;
/** 注释映射表  */
@property (nonatomic, strong) NSArray<Commentmappinglist *> *commentMappingList;

@end

@interface Commentinfolist : NSObject
/** 用户头像 */
@property (nonatomic, copy) NSString *icoUrl;
/** 评论内容 */
@property (nonatomic, copy) NSString *content;
/** Unix时间*1000 */
@property (nonatomic, assign) long long posttime;

//@property (nonatomic, assign) long long id;

@property (nonatomic, assign) NSInteger userId;
/** 用户昵称 */
@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSInteger praiseCount;

@end

@interface Hotcommentinfolist : NSObject

@property (nonatomic, copy) NSString *icoUrl;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) long long posttime;

//@property (nonatomic, assign) long long id;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *userName;
/** 点赞数 */
@property (nonatomic, assign) NSInteger praiseCount;

@end

@interface Commentmappinglist : NSObject

@property (nonatomic, assign) NSInteger from;

@property (nonatomic, strong) NSArray *parentId;

//@property (nonatomic, assign) long long id;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, assign) NSInteger articleId;

@property (nonatomic, assign) BOOL copyright;

@end


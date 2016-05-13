//
//  NewsArticleModel.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  新闻详细信息的模型
 */
@interface NewsArticleModel : NSObject
/** 编号 */
@property (nonatomic ,strong) NSNumber * articleId;
/** 图片url字典 */
@property (nonatomic ,strong) NSDictionary * articleMediaMap;
/** 来源 */
@property (nonatomic ,copy) NSString * author;
/** 背景颜色 */
@property (nonatomic ,copy) NSString * bgcolor;
/** comment */
@property (nonatomic ,strong) NSNumber * comments;
/** connecTo */
@property (nonatomic ,strong) NSArray * connectTo;
/** 新闻内容 */
@property (nonatomic ,copy) NSString * content;
/** 内容来源ID */
@property (nonatomic ,strong) NSNumber * contentSourceId;
/** 来源 */
@property (nonatomic ,copy) NSString * contentSourceLogo;
/** 内容来源Logo */
@property (nonatomic ,copy) NSString * contentSourceName;
/** CP文章编号 */
@property (nonatomic ,copy) NSString * cpArticleId;
/** 时间 */
@property (nonatomic ,strong) NSNumber * date;
/** 转发 */
@property (nonatomic ,strong) NSNumber * forwarding;
/** 原地址 */
@property (nonatomic ,copy) NSString * sourceUrl;
/** 标题 */
@property (nonatomic ,copy) NSString * title;
/** 类型 */
@property (nonatomic ,copy) NSString * type;
/** 视频字典 */
@property (nonatomic ,strong) NSDictionary * videoMap;

@end

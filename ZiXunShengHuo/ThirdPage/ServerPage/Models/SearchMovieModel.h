//
//  SearchMovieModel.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchMovieResult,SearchMovieResultPlaylinks,SearchMovieResultAct_S,SearchMovieResultVideo_Rec;
@interface SearchMovieModel : NSObject
/** 结果集 */
@property (nonatomic, strong) SearchMovieResult *result;
/** 状态码 */
@property (nonatomic, assign) NSInteger error_code;
/** 状态 */
@property (nonatomic, copy) NSString *reason;

@end
/** 结果集 */
@interface SearchMovieResult : NSObject
/** rating */
@property (nonatomic, copy) NSString *rating;
/** 导演 */
@property (nonatomic, copy) NSString *dir;
/** 演员详细列表 */
@property (nonatomic, strong) NSArray<SearchMovieResultAct_S *> *act_s;
/** 影视地区 */
@property (nonatomic, copy) NSString *area;
/** 影视简介 */
@property (nonatomic, copy) NSString *desc;
/** 影片名称 */
@property (nonatomic, copy) NSString *title;
/** 影片分类 */
@property (nonatomic, copy) NSString *tag;
/** 相关推荐列表 */
@property (nonatomic, strong) NSArray<SearchMovieResultVideo_Rec *> *video_rec;
/** 专辑图片 */
@property (nonatomic, copy) NSString *cover;
/** 年份 */
@property (nonatomic, copy) NSString *year;
/** 播放地址列表 */
@property (nonatomic, strong) NSDictionary *playlinks;
/** 演员 */
@property (nonatomic, copy) NSString *act;
/** ？“play” */
@property (nonatomic, copy) NSString *vdo_status;

@end

@interface SearchMovieResultPlaylinks : NSObject

@property (nonatomic, copy) NSString *baofeng;

@property (nonatomic, copy) NSString *huashu;

@property (nonatomic, copy) NSString *leshi;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *kumi;

@property (nonatomic, copy) NSString *cntv;

@property (nonatomic, copy) NSString *youku;

@property (nonatomic, copy) NSString *tudou;

@property (nonatomic, copy) NSString *qiyi;

@property (nonatomic, copy) NSString *sohu;

@property (nonatomic, copy) NSString *imgo;

@property (nonatomic, copy) NSString *pptv;

@end

@interface SearchMovieResultAct_S : NSObject
/** 姓名 */
@property (nonatomic, copy) NSString *name;
/** 百科链接 */
@property (nonatomic, copy) NSString *url;
/** 图片 */
@property (nonatomic, copy) NSString *image;

@end

@interface SearchMovieResultVideo_Rec : NSObject
/** 封面图片 */
@property (nonatomic, copy) NSString *cover;
/**地址  */
@property (nonatomic, copy) NSString *detail_url;
/** 片名 */
@property (nonatomic, copy) NSString *title;

@end


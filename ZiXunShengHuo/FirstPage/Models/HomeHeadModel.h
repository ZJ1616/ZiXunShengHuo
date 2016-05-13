//
//  BlocksModel.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  主页面头视图 和 新闻的简略信息 模型
 */
@interface HomeHeadModel : NSObject
/** blocks模型 */
@property (nonatomic ,strong) NSArray * blocks;
@end

@interface BlockModel : NSObject
/** blocks模型的数据 */
@property (nonatomic ,strong) NSArray * data;
/** blocks模型的Type */
@property (nonatomic ,copy) NSString * type;
@end


@interface NewsSimpleModel : NSObject
/** ID */
@property (nonatomic ,strong) NSNumber * articleId;
/** 详情网址 */
@property (nonatomic ,copy) NSString * articleUrl;
/** 信息来源 */
@property (nonatomic ,copy) NSString * contentSourceName;
/** Type */
@property (nonatomic ,copy) NSString * contentType;
/** 描述 */
@property (nonatomic ,copy) NSString * desc;
/** 图片 */
@property (nonatomic ,strong) NSArray * imgUrlList;
/** 背景 */
@property (nonatomic ,copy) NSString * matteBgColor;
/** 时间 */
@property (nonatomic ,strong) NSNumber * putdate;
/** randomNum */
//@property (nonatomic ,strong) NSNumber<Optional> * randomNum;
//@property (nonatomic ,assign) BOOL * showMatte;
//@property (nonatomic ,assign) BOOL * showTitle;
/** Type */
//@property (nonatomic ,copy) NSString<Optional> * sourceType;
/** 标题 */
@property (nonatomic ,copy) NSString * title;               //标题
/** Type */
@property (nonatomic ,copy) NSString * type;
@end
//
//  ChanneListModel.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  频道列表 和 订阅详情的 Model
 */
@interface ChanneListModel : NSObject
@property (nonatomic ,copy) NSString * bgColor;
@property (nonatomic ,copy) NSString * bigIcon;
@property (nonatomic ,strong) NSNumber * defaultSubscribe;
/**图标*/
@property (nonatomic ,copy) NSString * iconUrl;
/**id*/
@property (nonatomic ,strong) NSNumber * Id;
/**名称*/
@property (nonatomic ,copy) NSString * name;
/**详细类目网址*/
@property (nonatomic ,copy) NSString * rssUrl;
@property (nonatomic ,copy) NSString * smallIcon;
@property (nonatomic ,strong) NSNumber * type;
@end


@interface RssListModel : NSObject
/** 订阅的入口网址 */
@property (nonatomic ,copy) NSString * articleListUrl;
@property (nonatomic ,copy) NSString * bgcolor;
/** 订阅的描述 */
@property (nonatomic ,copy) NSString * desc;
/** 订阅的主图片 */
@property (nonatomic ,copy) NSString * iconUrl;
/** 订阅的图片2 */
@property (nonatomic ,copy) NSString * icoUrl2;
/** 订阅的图片3 */
@property (nonatomic ,copy) NSString * icoUrl3;
@property (nonatomic ,copy) NSString * imgUrl;
/** 订阅的名称 */
@property (nonatomic ,copy) NSString * name;
@property (nonatomic ,copy) NSString * type;
@property (nonatomic ,strong) NSNumber * columnId;
/** 专题的ID */
@property (nonatomic ,strong) NSNumber * Id;
@property (nonatomic ,strong) NSArray * mapping;
@end
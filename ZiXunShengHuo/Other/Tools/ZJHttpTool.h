//
//  ZJDownloader.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/20.
//  Copyright © 2016年 周杰. All rights reserved.
//  下载工具类

#import <Foundation/Foundation.h>

@interface ZJHttpTool : NSObject

/**
 *  发送一个GET请求AFNetworking
 *
 *  @param url     请求路径和参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url success:(void (^)(id responseObject))success failure:(void(^)(NSError * error))failure;
/**
 *  发送一个GET请求  NSURLSession
 *
 *  @param url     请求路径和参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getForURLSessionWithURL:(NSString *)url success:(void (^)(id responseObject))success failure:(void(^)(NSError * error))failure;

/**
 *  发送一个Post请求 NSURLSession
 *
 *  @param urlString  请求路径
 *  @param parameters 参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+ (void)POSTWithUrl:(NSString *)urlString andParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void(^)(NSError * error))failure;
@end

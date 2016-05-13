//
//  ZJDownloader.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/20.
//  Copyright © 2016年 周杰. All rights reserved.
//  

#import "ZJHttpTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+WJTools.h"

@implementation ZJHttpTool


+ (void)getWithURL:(NSString *)url success:(void (^)(id responseObject))success failure:(void(^)(NSError * error))failure
{
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        if (error) {
            failure(error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"下载数据失败"];
            });
        }else{
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            success(responseObject);
        }
    }];
    [dataTask resume];
    /*
    AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [mgr GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"下载数据失败"];
            });
        }
    }];
     */
}



+ (void)getForURLSessionWithURL:(NSString *)url success:(void (^)(id responseObject))success failure:(void(^)(NSError * error))failure
{
    
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        if (error) {
            failure(error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"下载数据失败"];
            });
        }else{
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            success(responseObject);
        }
    }];
    [dataTask resume];
}



+ (void)POSTWithUrl:(NSString *)urlString andParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void(^)(NSError * error))failure
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    //NSURLSession POST请求
    //请求体
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    request.HTTPMethod = @"post";
    //拼接请求体Str
    NSMutableString * paramStr = [NSMutableString string];
    for (NSString * key in parameters) {
        [paramStr appendFormat:@"%@=%@&",key,parameters[key]];
    }
    NSRange range = {paramStr.length-1,1};
    [paramStr deleteCharactersInRange:range];
    
    NSData * data = [paramStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置请求体
    request.HTTPBody = data;
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"下载数据失败"];
            });
        }else{
            //下载成功
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
            if (r.statusCode == 200) {
                id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                success(responseObject);
            }else{
                failure(nil);
                
            }
        }
    }];
    //开启下载
    [dataTask resume];
}


@end

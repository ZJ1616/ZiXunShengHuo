//
//  ZJAlertTool.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJAlertTool : NSObject
/** 快速弹窗 */
+ (void)showAlertViewTarget:(id)target Title:(NSString *)title message:(NSString *)message;
/** 快速提示 */
+ (void)showMessage:(NSString *)message target:(id)target;
@end

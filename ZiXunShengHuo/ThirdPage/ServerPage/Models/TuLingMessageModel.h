//
//  TuLingMessage.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    MessageTypeMe = 0, // 自己发的
    MessageTypeOther   // 别人发的
} MessageType;
@interface TuLingMessageModel : NSObject
/**
 *  聊天内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  信息的类型
 */
@property (nonatomic, assign) MessageType type;
@end

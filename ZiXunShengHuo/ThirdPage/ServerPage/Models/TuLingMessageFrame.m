//
//  TuLingFrame.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 周杰. All rights reserved.
//  

#import "TuLingMessageFrame.h"
#import "TuLingMessageModel.h"
#import "NSString+Extension.h"
@implementation TuLingMessageFrame

- (void)setMessage:(TuLingMessageModel *)message
{
    _message = message;
    _message = message;
    // 间距
    CGFloat padding = 10;
    // 屏幕的宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    
    // 2.头像
    CGFloat iconY = padding;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    CGFloat iconX;
    if (message.type == MessageTypeOther) {// 别人发的
        iconX = padding;
    } else { // 自己的发的
        iconX = screenW - padding - iconW;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 3.正文
    CGFloat textY = iconY;
    // 文字计算的最大尺寸
    CGSize textMaxSize = CGSizeMake(200, MAXFLOAT);
    // 文字计算出来的真实尺寸(按钮内部label的尺寸)
    CGSize textRealSize = [message.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:textMaxSize];
    // 按钮最终的真实尺寸
    CGSize textBtnSize = CGSizeMake(textRealSize.width + 20 * 2, textRealSize.height + 20 * 2);
    CGFloat textX;
    if (message.type == MessageTypeOther) {// 别人发的
        textX = CGRectGetMaxX(_iconF) + padding;
    } else {// 自己的发的
        textX = iconX - padding - textBtnSize.width;
    }
    //    _textF = CGRectMake(textX, textY, textSize.width + 40, textSize.height + 40);
    _textF = (CGRect){{textX, textY}, textBtnSize};
    
    // 4.cell的高度
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    _cellHeight = MAX(textMaxY, iconMaxY) + padding;
}
@end

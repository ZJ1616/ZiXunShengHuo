//
//  WiFiHeadView.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "WiFiHeadView.h"

@interface WiFiHeadView ()

@end

@implementation WiFiHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加提示标签
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
        self.titleLabel.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = @"正在查找附近的公共WiFi...";
        [self addSubview:self.titleLabel];

    }
    return self;
}
/** 重写构造方法 刷新提示信息 */
- (void)setModelArray:(NSArray *)modelArray
{
    _modelArray = modelArray;
    self.titleLabel.text = [NSString stringWithFormat:@"你附近共有%ld个公共WiFi",_modelArray.count];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

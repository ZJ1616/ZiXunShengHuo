//
//  SpecualTopicHeadView.m
//  ZJProjectBate2
//
//  Created by 周杰 on 16/3/15.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "SpecualTopicHeadView.h"

@implementation SpecualTopicHeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, (self.bounds.size.width)*(148.0/357.0))];
        [self addSubview:self.imageView];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.imageView.frame), self.imageView.bounds.size.width, 40)];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:14];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.numberOfLines = 0;
        [self addSubview:self.label];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

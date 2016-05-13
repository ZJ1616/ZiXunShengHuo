//
//  TicketHeadView.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "TicketHeadView.h"

@interface TicketHeadView ()
@property (nonatomic ,strong) UILabel * fromLabel;
@property (nonatomic ,strong) UILabel * toLabel;
@property (nonatomic ,strong) UIButton * button;
@end

@implementation TicketHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ZJColor(33, 118, 195);
        CGFloat gap = 10;
        CGFloat w = 100;
        CGFloat h = 30;
        self.fromLabel = [[UILabel alloc] init];
        [self addSubview:self.fromLabel];
        self.fromLabel.frame = CGRectMake(gap, gap, w, h);
        self.fromLabel.textAlignment = NSTextAlignmentCenter;
        self.fromLabel.text = @"出发地";
        
        self.fromText = [[UITextField alloc] init];
        [self addSubview:self.fromText];
        self.fromText.frame = CGRectMake(gap, CGRectGetMaxY(self.fromLabel.frame)+gap, w, h);
        self.fromText.borderStyle = UITextBorderStyleRoundedRect;
        
        self.toLabel = [[UILabel alloc] init];
        [self addSubview:self.toLabel];
        self.toLabel.frame = CGRectMake(Screen_Width-w-gap, gap, w, h);
        self.toLabel.textAlignment = NSTextAlignmentCenter;
        self.toLabel.text = @"目的地";
        
        self.toText = [[UITextField alloc] init];
        [self addSubview:self.toText];
        self.toText.frame = CGRectMake(self.toLabel.frame.origin.x, CGRectGetMaxY(self.toLabel.frame)+gap, w, h);
        self.toText.borderStyle = UITextBorderStyleRoundedRect;
        
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:self.button];
        self.button.frame = CGRectMake(gap, CGRectGetMaxY(self.toText.frame)+gap, Screen_Width-2*gap, 40);
        [self.button setTitle:@"查   询" forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(clickSelectButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickSelectButton
{
    ZJLog(@"点击了查询");
    [self.delegate clickQueryTimeList];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

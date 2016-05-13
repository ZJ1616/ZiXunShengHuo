//
//  TicketHeadView.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TicketHeadViewDelegate <NSObject>

- (void)clickQueryTimeList;

@end

@interface TicketHeadView : UIView
@property (nonatomic ,strong) UITextField * fromText;
@property (nonatomic ,strong) UITextField * toText;
@property (nonatomic ,weak) id<TicketHeadViewDelegate> delegate;
@end

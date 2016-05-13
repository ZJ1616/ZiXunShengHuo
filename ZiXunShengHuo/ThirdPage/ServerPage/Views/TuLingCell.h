//
//  TuLingCell.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TuLingMessageFrame;
@interface TuLingCell : UITableViewCell
/** 自定义复用方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/** 消息的模型 */
@property (nonatomic ,strong) TuLingMessageFrame * messageFrame;
@end

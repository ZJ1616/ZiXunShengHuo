//
//  ServerCell.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ServerCellDelegate <NSObject>

- (void)pushServerViewController:(UIViewController *)ctrl;

@end

@interface ServerCell : UITableViewCell

/** 推出服务页面的代理方法 */
@property (nonatomic ,weak) id<ServerCellDelegate>  delegate;

@end

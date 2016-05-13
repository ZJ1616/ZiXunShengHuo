//
//  WiFiListCell.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WiFi_Result_Data;
@interface WiFiListCell : UITableViewCell
@property (nonatomic ,strong) WiFi_Result_Data * WifiListModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

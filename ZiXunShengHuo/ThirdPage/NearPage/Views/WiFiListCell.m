//
//  WiFiListCell.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "WiFiListCell.h"
#import "WiFiListModel.h"
@interface WiFiListCell ()
@property (nonatomic ,strong) UIImageView * iconImageView;
@property (nonatomic ,strong) UILabel * nameLabel;
@property (nonatomic ,strong) UILabel * addressLabel;
@property (nonatomic ,strong) UILabel * distanceLabel;
@end

@implementation WiFiListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/** 构造方法 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
    }
    return self;
}

/** 复用 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellID = @"WiFiListCellID";
    WiFiListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[WiFiListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}
- (void)createCell
{
    CGFloat gap = 10;
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(gap, gap, 50, 50)];
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"wifi"];
    
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+gap, gap, Screen_Width-10-20-50, 20)];
    [self addSubview:self.nameLabel];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, CGRectGetMaxY(self.nameLabel.frame), self.nameLabel.bounds.size.width, 15)];
    [self addSubview:self.addressLabel];
    self.addressLabel.font = [UIFont systemFontOfSize:12];
    
    
    self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, CGRectGetMaxY(self.addressLabel.frame), self.nameLabel.bounds.size.width, 15)];
    [self addSubview:self.distanceLabel];
    self.distanceLabel.font = [UIFont systemFontOfSize:12];
}

- (void)setWifiListModel:(WiFi_Result_Data *)wifiListModel
{
    _WifiListModel = wifiListModel;
    self.nameLabel.text = wifiListModel.name;
    self.addressLabel.text = wifiListModel.address;
    self.distanceLabel.text = [NSString stringWithFormat:@"距离%ld米",wifiListModel.distance];
}


@end

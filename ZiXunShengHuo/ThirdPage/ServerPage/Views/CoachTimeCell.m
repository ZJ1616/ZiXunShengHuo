//
//  CoachTimeCell.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "CoachTimeCell.h"
#import "CoachTimeModel.h"

@interface CoachTimeCell ()
@property (nonatomic ,strong) UILabel * startLabel;
@property (nonatomic ,strong) UILabel * arriveLabel;
@property (nonatomic ,strong) UILabel * dataLabel;
@property (nonatomic ,strong) UILabel * priceLabel;

@end
@implementation CoachTimeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"CoachTimeCellId";
    CoachTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CoachTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.startLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.startLabel];
        
        self.arriveLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.arriveLabel];
        
        self.dataLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.dataLabel];
        
        self.priceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.priceLabel];
    }
    return self;
}

- (void)setModel:(CoachTimeResultList *)model
{
    CGFloat gap = 10;
    CGFloat x1 = gap;
    CGFloat y1 = gap;
    CGFloat w1 = 60;
    CGFloat h1 = 30;
    self.dataLabel.frame = CGRectMake(x1, y1, w1, h1);
    self.dataLabel.text = model.date;
    
    CGFloat x2 = x1;
    CGFloat y2 = CGRectGetMaxY(self.dataLabel.frame);
    CGFloat w2 = 150;
    CGFloat h2 = 30;
    self.startLabel.frame = CGRectMake(x2, y2, w2, h2);
    self.startLabel.text = model.start;
    
    CGFloat x3 = x1;
    CGFloat y3 = CGRectGetMaxY(self.startLabel.frame);
    CGFloat w3 = 150;
    CGFloat h3 = 30;
    self.arriveLabel.frame = CGRectMake(x3, y3, w3, h3);
    self.arriveLabel.text = model.arrive;
    
    CGFloat x4 = Screen_Width-100;
    CGFloat y4 = gap*2;
    CGFloat w4 = 100;
    CGFloat h4 = 30;
    self.priceLabel.frame = CGRectMake(x4, y4, w4, h4);
    self.priceLabel.text = model.price;
}

@end

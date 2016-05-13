//
//  TrainTimeCell.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/29.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "TrainTimeCell.h"
#import "TrainTimeModel.h"

@interface TrainTimeCell ()
/** 车次 */
@property (nonatomic, strong) UILabel * train_noLabel;
/** 车次类型 */
@property (nonatomic, strong) UILabel * train_typeLabel;
/** 起点 */
@property (nonatomic, strong) UILabel * start_stationLabel;
/** 起点时间 */
@property (nonatomic, strong) UILabel * start_timeLabel;
/** 发站类型 */
@property (nonatomic, strong) UILabel * start_station_typeLabel;
/** 到站 */
@property (nonatomic, strong) UILabel * end_stationLabel;
/** 到站时间 */
@property (nonatomic, strong) UILabel * end_timeLabel;
/** 到站类型 */
@property (nonatomic, strong) UILabel * end_station_typeLabel;
/** 历时 */
@property (nonatomic, strong) UILabel * run_timeLabel;

@end

@implementation TrainTimeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellId = @"TrantTimeCellId";
    TrainTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[TrainTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.train_noLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.train_noLabel];
        
        self.train_typeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.train_typeLabel];
        
        self.start_stationLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.start_stationLabel];
        
        self.start_timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.start_timeLabel];
        
        self.start_station_typeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.start_station_typeLabel];
        
        self.end_stationLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.end_stationLabel];
        
        self.end_timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.end_timeLabel];
        
        self.end_station_typeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.end_station_typeLabel];
        
        self.run_timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.run_timeLabel];
    }
    return self;
}

- (void)setModel:(TrainTimeList *)model
{
    _model = model;
    //车次
    CGFloat gap = 5;
    CGFloat x1 = 10;
    CGFloat y1 = gap;
    CGFloat w1 = 50;
    CGFloat h1 = 15;
    self.train_noLabel.frame = CGRectMake(x1, y1, w1, h1);
    self.train_noLabel.text = model.train_no;
    self.train_noLabel.font = [UIFont systemFontOfSize:15];
    //发站类型
    CGFloat x2 = CGRectGetMaxX(self.train_noLabel.frame)+5;
    CGFloat y2 = gap;
    CGFloat w2 = 15;
    CGFloat h2 = 15;
    self.start_station_typeLabel.frame = CGRectMake(x2, y2, w2, h2);
    self.start_station_typeLabel.text = model.start_station_type;
    self.start_station_typeLabel.font = [UIFont systemFontOfSize:15];
    //发站
    CGFloat x3 = CGRectGetMaxX(self.start_station_typeLabel.frame)+5;
    CGFloat y3 = gap;
    CGFloat w3 = 60;
    CGFloat h3 = 15;
    self.start_stationLabel.frame = CGRectMake(x3, y3, w3, h3);
    self.start_stationLabel.text = model.start_station;
    self.start_stationLabel.font = [UIFont systemFontOfSize:15];
    //发时间
    CGFloat x4 = self.start_stationLabel.frame.origin.x;
    CGFloat y4 = CGRectGetMaxY(self.start_stationLabel.frame);
    CGFloat w4 = 60;
    CGFloat h4 = 15;
    self.start_timeLabel.frame = CGRectMake(x4, y4, w4, h4);
    self.start_timeLabel.text = model.start_time;
    self.start_timeLabel.font = [UIFont systemFontOfSize:14];
    //历时
    CGFloat x5 = x3+w3+5;
    CGFloat y5 = gap;
    CGFloat w5 = 80;
    CGFloat h5 = 15;
    self.run_timeLabel.frame = CGRectMake(x5, y5, w5, h5);
    self.run_timeLabel.text = model.run_time;
    self.run_timeLabel.font = [UIFont systemFontOfSize:14];
    //到站类型
    CGFloat x6 = Screen_Width-90;
    CGFloat y6 = gap;
    CGFloat w6 = 15;
    CGFloat h6 = 15;
    self.end_station_typeLabel.frame = CGRectMake(x6, y6, w6, h6);
    self.end_station_typeLabel.text = model.end_station_type;
    self.end_station_typeLabel.font = [UIFont systemFontOfSize:15];
    //到站
    CGFloat x7 = x6+w6+gap;
    CGFloat y7 = gap;
    CGFloat w7 = 60;
    CGFloat h7 = 15;
    self.end_stationLabel.frame = CGRectMake(x7, y7, w7, h7);
    self.end_stationLabel.text = model.end_station;
    self.end_stationLabel.font = [UIFont systemFontOfSize:15];
    //到站时间
    CGFloat x8 = x7;
    CGFloat y8 = y7+h7;
    CGFloat w8 = 60;
    CGFloat h8 = 15;
    self.end_timeLabel.frame = CGRectMake(x8, y8, w8, h8);
    self.end_timeLabel.text = model.end_time;
    self.end_timeLabel.font = [UIFont systemFontOfSize:15];
    
    //票价
    NSArray * array = model.price_list;
    for (int i = 0; i < array.count; i++) {
        UILabel * label = (UILabel *)[self.contentView viewWithTag:2016+i];
        [label removeFromSuperview];
    }
    for (int i = 0; i < array.count; i++) {
        TrainTimePrice_List * listModel = array[i];
        CGFloat y = y4+h4+20;
        CGFloat w = 100;
        CGFloat h = 15;
        CGFloat x = 10+(30+w)*i;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        label.tag = 2016+i;
        label.text = [NSString stringWithFormat:@"%@:￥%@",listModel.price_type,listModel.price];
        [self.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:13];
    }
    self.backgroundColor = ZJColor(254, 255, 255);
}

@end

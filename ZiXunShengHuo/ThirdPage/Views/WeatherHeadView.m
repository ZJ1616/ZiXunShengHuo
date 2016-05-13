//
//  WeatherHeadView.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 周杰. All rights reserved.
//  537f5bffc11dabeb3a383c95b004fc05


#import "WeatherHeadView.h"
#import "WeatherModel.h"
#import "ZJHttpTool.h"
#import "ZJTool.h"
#import "MJExtension.h"


@interface WeatherHeadView ()
/** 天气数据模型 */
@property (nonatomic, strong) WeatherModel * weatherModel;
/** 实时 */
@property (nonatomic ,strong) Data_Realtime * realTimeModel;
/** 生活 */
@property (nonatomic ,strong) Data_Life * lifeModel;
/** 日期Label */
@property (nonatomic ,strong) UILabel * dateLabel;
/** 地点 */
@property (nonatomic ,strong) UILabel * cityNameLabel;
/** 温度Label */
@property (nonatomic ,strong) UILabel * temperature;
/** 上次更新时间 */
@property (nonatomic ,strong) UILabel * timeLabel;
/** 天气Label */
@property (nonatomic ,strong) UILabel * infolabel;
@end

@implementation WeatherHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        //[self createData];
        [self addControl];
    }
    return self;
}

/** 创建爱你视图 */
- (void)createView
{
    self.backgroundColor = [UIColor colorWithRandomColor];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 20)];
    [self addSubview:self.dateLabel];
    self.dateLabel.font = [UIFont systemFontOfSize:14];
    
    self.cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-30-20, 20, 30, 20)];
    [self addSubview:self.cityNameLabel];
    self.cityNameLabel.font = [UIFont systemFontOfSize:14];
    
    self.temperature = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    self.temperature.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    [self addSubview:self.temperature];
    self.temperature.font = [UIFont systemFontOfSize:60];
    self.temperature.textAlignment = NSTextAlignmentCenter;
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.temperature.frame), CGRectGetMaxY(self.temperature.frame)-20, 150, 20)];
    [self addSubview:self.timeLabel];
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    
    
    self.infolabel = [[UILabel alloc] initWithFrame:CGRectMake(self.temperature.frame.origin.x, CGRectGetMaxY(self.temperature.frame), self.temperature.bounds.size.width, 30)];
    [self addSubview:self.infolabel];
    self.infolabel.font = [UIFont systemFontOfSize:13];
    self.infolabel.textAlignment = NSTextAlignmentCenter;
}

- (void)showData
{
    self.dateLabel.text = self.realTimeModel.date;
    self.cityNameLabel.text = self.realTimeModel.city_name;
    self.temperature.text = [NSString stringWithFormat:@"%@º",self.realTimeModel.weather.temperature];
    self.timeLabel.text = [NSString stringWithFormat:@"最近更新 %@",self.realTimeModel.time];
    self.infolabel.text = self.realTimeModel.weather.info;
}

- (void)createData
{
    if (self.city==nil) {
        self.city = @"上海";
    }
    [self downloadData];
}
- (void)setCity:(NSString *)city
{
    _city = city;
    [self createData];
}
- (void)downloadData
{
    NSMutableDictionary * para = [[NSMutableDictionary alloc] init];
    [para setObject:Weather_APPKey forKey:@"key"];
    [para setObject:self.city forKey:@"cityname"];
    
    [ZJHttpTool POSTWithUrl:Weather_Url andParameters:para success:^(id responseObject) {
        WeatherModel * model = [WeatherModel mj_objectWithKeyValues:responseObject];
        if (model.error_code == 0) {
            self.weatherModel = model;
            self.realTimeModel = self.weatherModel.result.data.realtime;
            self.lifeModel = self.weatherModel.result.data.life;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showData];
            });
        }else{
            NSString * message = model.reason;
            ZJLog(@"%@",message);
            
        }
    } failure:^(NSError *error) {
        //
        ZJLog(@"%@",error);
    }];
    
    
    
}

- (void)addControl
{
    UIControl * control = [[UIControl alloc] initWithFrame:self.bounds];
    [self addSubview:control];
    [control addTarget:self action:@selector(clickWeather) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickWeather
{
    ZJLog(@"点击了头视图");
    [self.delegate pushWeatherSetViewController];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

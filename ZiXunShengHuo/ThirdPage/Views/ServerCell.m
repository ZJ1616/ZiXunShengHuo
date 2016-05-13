//
//  ServerCell.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 周杰. All rights reserved.
//

#define Servre_Button_Tag 147
#import "ServerCell.h"
#import "ExpressViewController.h"
#import "PhoneNumViewController.h"
#import "TrainTimeViewController.h"
#import "CoachTimeViewController.h"
#import "BusTimeViewController.h"
#import "MovieListViewController.h"
#import "TuLingViewController.h"

@implementation ServerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/** 构造方法*/
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
    }
    return self;
}

- (void)createCell
{       //电视节目表  公交 https://www.juhe.cn/docs/api/id/135 影视搜索 http://www.avatardata.cn/Docs/Api/516effb0-8768-41a4-987d-fb2eee3700e2
    //NSArray * titles = @[@"查号码" ,@"查快递" ,@"火车时刻表" ,@"汽车时刻表" ,@"城市公交" ,@"电视节目表" ,@"影视搜索" ,@"问答机器人"];
    NSArray * titles = @[@"查号码" ,@"查快递" ,@"火车时刻表" ,@"汽车时刻表" ,@"影视搜索" ,@"问答机器人"];
    //NSArray * images = @[@"haoma",@"kuaidi",@"huoche2",@"qiche",@"gongjiao",@"dianshi",@"dianying",@"jiqiren"];
    NSArray * images = @[@"haoma",@"kuaidi",@"huoche2",@"qiche",@"dianying",@"jiqiren"];
    CGFloat btnW = Screen_Width/4.0;
    CGFloat btnH = 70;
    for (int i = 0; i < titles.count; i++) {
        UIControl * button = [self createBtnControlWithFrame:CGRectMake(btnW*(i%4), btnH*(i/4), btnW, btnH) title:titles[i] imageName:images[i]];
        [button addTarget:self action:@selector(clickServreButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = Servre_Button_Tag+i;
        [self addSubview:button];
    }
}

- (void)clickServreButton:(UIControl *)servreButton
{
    NSInteger index = servreButton.tag - Servre_Button_Tag;
    if (index==0) {
        ZJLog(@"0");
        //dianhua
        PhoneNumViewController * ctrl = [[PhoneNumViewController alloc] init];
        [self.delegate pushServerViewController:ctrl];
    }else if (index==1){
        ZJLog(@"1");
        //kuaidi
        ExpressViewController * ctrl = [[ExpressViewController alloc] init];
        [self.delegate pushServerViewController:ctrl];
    }else if (index==2){
        ZJLog(@"2");
        TrainTimeViewController * ctrl = [[TrainTimeViewController alloc] init];
        [self.delegate pushServerViewController:ctrl];
    }else if (index==3){
        ZJLog(@"3");
        CoachTimeViewController * ctrl = [[CoachTimeViewController alloc] init];
        [self.delegate pushServerViewController:ctrl];
    }else if (index==11){
        ZJLog(@"4");
        BusTimeViewController * ctrl = [[BusTimeViewController alloc] init];
        [self.delegate pushServerViewController:ctrl];
    }else if (index==4){
        ZJLog(@"6");
        MovieListViewController * ctrl = [[MovieListViewController alloc] init];
        [self.delegate pushServerViewController:ctrl];
    }else if (index==5){
        ZJLog(@"7");
        TuLingViewController * ctrl = [[TuLingViewController alloc] init];
        [self.delegate pushServerViewController:ctrl];
    }
}

- (UIControl *)createBtnControlWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName
{
    UIControl * btnControl = [[UIControl alloc] initWithFrame:frame];
    
    CGFloat w = btnControl.bounds.size.width;
    CGFloat h = btnControl.bounds.size.height;
    
    UIImageView * iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0.4*h, 0.4*h)];
    iconImageView.image = [UIImage imageNamed:imageName];
    iconImageView.center = CGPointMake(btnControl.bounds.size.width/2, 0.4*h);
    //iconImageView.contentMode = UIViewContentModeCenter;
    [btnControl addSubview:iconImageView];
    
    UILabel * iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.6*h, w, 0.4*h)];
    iconLabel.text = title;
    iconLabel.textAlignment = NSTextAlignmentCenter;
    iconLabel.font = [UIFont systemFontOfSize:13];
    [btnControl addSubview:iconLabel];
    
    return btnControl;
}

@end

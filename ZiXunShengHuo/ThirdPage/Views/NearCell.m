//
//  NearCell.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 周杰. All rights reserved.
//
#define Servre_Button_Tag 258
#import "NearCell.h"
#import "WiFiViewController.h"
#import "Near2ViewController.h"
#import "Near2ViewController.h"
#import "Near3ViewController.h"
#import "Near4ViewController.h"
#import "Near5ViewController.h"

@implementation NearCell

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
{
    NSArray * titles = @[@"附近WiFi",@"美食",@"外卖",@"酒店",@"出租车"];
    NSArray * images = @[@"around_local_sort_main_select",@"around_local_sort_main_food",@"around_local_sort_main_fanbu",@"around_local_sort_main_jingdian",@"around_local_sort_main_show"];
    
    CGFloat btnW = Screen_Width/2;
    CGFloat btnH = 70;
    for (int i = 0; i < titles.count; i++) {
        UIControl * button = [self createBtnControlWithFrame:CGRectMake(btnW*(i%2), btnH*(i/2), btnW, btnH) title:titles[i] imageName:images[i]];
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
        WiFiViewController * ctrl = [[WiFiViewController alloc] init];
        [self.delegate pushNearViewController:ctrl];
        
    }else if (index==1){
        ZJLog(@"1");
        Near2ViewController * ctrl = [[Near2ViewController alloc] init];
        [self.delegate pushNearViewController:ctrl];
        
    }else if (index==2){
        ZJLog(@"2");
        Near3ViewController * ctrl = [[Near3ViewController alloc] init];
        [self.delegate pushNearViewController:ctrl];
    }else if (index==3){
        ZJLog(@"3");
        Near4ViewController * ctrl = [[Near4ViewController alloc] init];
        [self.delegate pushNearViewController:ctrl];
    }else if (index==4){
        ZJLog(@"4");
        Near5ViewController * ctrl = [[Near5ViewController alloc] init];
        [self.delegate pushNearViewController:ctrl];
    }
}


- (UIControl *)createBtnControlWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName
{
    UIControl * btnControl = [[UIControl alloc] initWithFrame:frame];
    
    CGFloat w = btnControl.bounds.size.width;
    CGFloat h = btnControl.bounds.size.height;
    
    UIImageView * iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.05*w, 0.1*h, 0.3*w, 0.8*h)];
    iconImageView.image = [UIImage imageNamed:imageName];
    //iconImageView.center = CGPointMake(btnControl.bounds.size.width/2, 0.4*h);
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [btnControl addSubview:iconImageView];
    
    UILabel * iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.4*w, 0, 0.6*w, h)];
    iconLabel.text = title;
    iconLabel.textAlignment = NSTextAlignmentLeft;
    iconLabel.font = [UIFont systemFontOfSize:14];
    [btnControl addSubview:iconLabel];
    
    return btnControl;
}
@end

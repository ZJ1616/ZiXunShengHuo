//
//  FavoriteCell.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/20.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "FavoriteCell.h"
#import "HomeHeadModel.h"
#import "UIImageView+WebCache.h"

@interface FavoriteCell ()

@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * iconLabel;


@end

@implementation FavoriteCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 *  重写的构造方法
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat imgX = 10;
        CGFloat imgY = 10;
        CGFloat imgW = Screen_Width*(125/436.0);
        CGFloat imgH = Screen_Width*(94/436.0);
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
        [self addSubview:self.iconImageView];
        
        CGFloat iconX = imgX+imgW+10+10;
        CGFloat iconY = imgY;
        CGFloat iconW = Screen_Width-10-10-imgW-10;
        CGFloat iconH = imgH*0.6;
        self.iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        self.iconLabel.font = [UIFont systemFontOfSize:16];
        self.iconLabel.numberOfLines = 2;
        [self addSubview:self.iconLabel];
        
        
        CGFloat timeX = iconX;
        CGFloat timeY = iconY+iconH;
        CGFloat timeW = iconW;
        CGFloat timeH = imgH*0.4;
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, timeY, timeW, timeH)];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.timeLabel];    
    }
    return self;
}
/**
 *  传入模型创建CELL数据
 *
 *  @param model NewsSimpleModel 模型
 */
- (void)configCellWithModel:(NewsSimpleModel *)model
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[model.imgUrlList firstObject]]];
    self.iconLabel.text = model.title;
    
    //计算时间差
    NSTimeInterval index = [model.putdate integerValue]/1000;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:index];
    NSString * dataStr = [self computeTimeDifference:date];
    self.timeLabel.text = [NSString stringWithFormat:@"%@   %@",model.contentSourceName,dataStr];
}

//计算时间差
- (NSString *)computeTimeDifference:(NSDate *)date
{
    //获取现在时间
    NSDate * nowDate = [NSDate date];
    //目标时间距离现在多少秒
    CGFloat timeDiff =  [nowDate timeIntervalSinceDate:date];
    if (timeDiff < 3600) {//小于1小时
        CGFloat time = timeDiff/60; //%.0lf分;
        return [NSString stringWithFormat:@"%.0lf分钟前",time];
    }else if (timeDiff>=3600&&timeDiff < 3600*24){
        CGFloat time = timeDiff/3600; //%.0lf时;
        return [NSString stringWithFormat:@"%.0lf小时前",time];
    }else{
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM月dd日";
        return [formatter stringFromDate:date];
    }
    
    
    
    
    return nil;
}
@end

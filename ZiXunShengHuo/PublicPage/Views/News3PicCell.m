//
//  News3PicCell.m
//  ZiXunShengHuo
//
//  Created by 周杰 on 16/4/19.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "News3PicCell.h"
#import "HomeHeadModel.h"
#import "UIImageView+WebCache.h"

@implementation News3PicCell

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
/** 复用 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellID = @"News3PicCellID";
    News3PicCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[News3PicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)createCell
{
    self.picImageView1 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.picImageView1];
    self.picImageView2 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.picImageView2];
    self.picImageView3 = [[UIImageView alloc] init];
    [self.contentView addSubview:self.picImageView3];
    self.titleLabe = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabe];
    self.subTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.subTitleLabel];
}

- (void)setModel:(NewsSimpleModel *)model
{
    CGFloat gapH = Screen_Width*42/1080.0;
    CGFloat gapW = Screen_Width*35/1080.0;
    CGFloat gap = Screen_Width*27/1080.0;
    CGFloat img1X = gapW;
    CGFloat img1Y = gapH;
    CGFloat img1W = Screen_Width*312/1080.0;
    CGFloat img1H = Screen_Width*234/1080.0;
    
    CGFloat img2X = gapW+img1W+gap;
    CGFloat img2Y = gapH;
    CGFloat img2W = img1W;
    CGFloat img2H = img1H;
    
    CGFloat img3X = gapW+gap*2+img1W*2;
    CGFloat img3Y = gapH;
    CGFloat img3W = img1W;
    CGFloat img3H = img1H;
    
    self.picImageView1.frame = CGRectMake(img1X, img1Y, img1W, img1H);
    self.picImageView2.frame = CGRectMake(img2X, img2Y, img2W, img2H);
    self.picImageView3.frame = CGRectMake(img3X, img3Y, img3W, img3H);
    
    [self.picImageView1 sd_setImageWithURL:[NSURL URLWithString:model.imgUrlList[0]]];
    [self.picImageView2 sd_setImageWithURL:[NSURL URLWithString:model.imgUrlList[1]]];
    [self.picImageView3 sd_setImageWithURL:[NSURL URLWithString:model.imgUrlList[2]]];
    
    self.picImageView1.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView1.clipsToBounds = YES;
    self.picImageView2.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView2.clipsToBounds = YES;
    self.picImageView3.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView3.clipsToBounds = YES;
    
    //标题
    CGFloat titleX = gap;
    CGFloat titleY = gap+img1H;
    CGFloat titleW = Screen_Width-2*gap;
    CGFloat titleH = 50;
    //时间戳
    CGFloat subX = gap;
    CGFloat subY = gap+img1H+titleH;
    CGFloat subW = titleW;
    CGFloat subH = 30;
    
    self.titleLabe.frame = CGRectMake(titleX, titleY, titleW, titleH);
    self.titleLabe.numberOfLines = 2;
    self.titleLabe.font = [UIFont systemFontOfSize:16];
    self.titleLabe.text = model.title;
    
    self.subTitleLabel.frame = CGRectMake(subX, subY, subW, subH);
    self.subTitleLabel.font = [UIFont systemFontOfSize:12];
    NSTimeInterval index = [model.putdate integerValue]/1000;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:index];
    NSString * dataStr = [self computeTimeDifference:date];
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@  %@",model.contentSourceName,dataStr];
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

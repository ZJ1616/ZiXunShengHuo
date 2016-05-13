//
//  MyTableViewCell.m
//  XMtext
//
//  Created by qianfeng on 16/3/10.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "NewsCellLarge.h"
#import "UIImageView+WebCache.h"
#import "HomeHeadModel.h"


@implementation NewsCellLarge

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
    static NSString * cellID = @"NewsCellLargeID";
    NewsCellLarge * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[NewsCellLarge alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)createCell
{
    self.picImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.picImageView];
    
    self.titleLabe = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabe];
    
    self.subTitleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.subTitleLabel];
}

- (void)configCellWithModel:(NewsSimpleModel *)model
{
    CGFloat gap = Screen_Width*35/1080;
    CGFloat imageX = gap;
    CGFloat imageY = gap;
    CGFloat imageW = Screen_Width-2*gap;
    CGFloat imageH = Screen_Width*457/1080;
    self.picImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    /*
     UIViewContentModeScaleToFill,
     UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
     UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
     UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
     UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
     UIViewContentModeTop,
     UIViewContentModeBottom,
     UIViewContentModeLeft,
     UIViewContentModeRight,
     UIViewContentModeTopLeft,
     UIViewContentModeTopRight,
     UIViewContentModeBottomLeft,
     UIViewContentModeBottomRight,
     */
    self.picImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView.clipsToBounds = YES;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrlList.firstObject]];
    
    CGFloat titleX = gap;
    CGFloat titleY = gap+imageH;
    CGFloat titleW = imageW;
    CGFloat titleH = 45;
    self.titleLabe.frame = CGRectMake(titleX, titleY, titleW, titleH);
    self.titleLabe.font = [UIFont systemFontOfSize:16];
    self.titleLabe.numberOfLines = 2;

    self.titleLabe.text = model.title;
    CGFloat subX = gap;
    CGFloat subY = CGRectGetMaxY(self.titleLabe.frame);
    CGFloat subW = titleW;
    CGFloat subH = 15;
    self.subTitleLabel.font = [UIFont systemFontOfSize:12];
    self.subTitleLabel.frame = CGRectMake(subX, subY, subW, subH);
    //计算时间差
    NSTimeInterval index = [model.putdate integerValue]/1000;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:index];
    NSString * dataStr = [self computeTimeDifference:date];
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@  %@",model.contentSourceName,dataStr];
    
    //CGFloat cellHeight = Screen_Width*755/1080;
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
}
/*    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
 formatter.dateFormat = @"MM月dd日";
 NSString * dataStr = [formatter stringFromDate:date];
 
 */
@end

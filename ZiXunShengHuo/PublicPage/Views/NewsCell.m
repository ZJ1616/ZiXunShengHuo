//
//  MyTableViewCell.m
//  XMtext
//
//  Created by qianfeng on 16/3/10.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "HomeHeadModel.h"

@interface NewsCell ()

@end

@implementation NewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat cellH = Screen_Width*319/1080.0;
        self.cellHeight = cellH;
    }
    return self;
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
    static NSString * cellID = @"NewsCellID";
    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    //新闻图标
    CGFloat gapH = Screen_Width*42/1080.0;
    CGFloat gapW = Screen_Width*35/1080.0;
    CGFloat imageX = gapW;
    CGFloat imageY = gapH;
    CGFloat imageW = Screen_Width*312/1080.0;
    CGFloat imageH = Screen_Width*234/1080.0;
    //标题
    CGFloat titleX = 2*gapW+imageW;
    CGFloat titleY = imageY;
    CGFloat titleW = Screen_Width-3*gapW-imageW;
    CGFloat titleH = imageH*0.6;
    //时间戳
    CGFloat subX = titleX;
    CGFloat subY = gapH+titleH;
    CGFloat subW = titleW;
    CGFloat subH = imageH*0.4;
    
    
    self.picImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    //self.picImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.picImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView.clipsToBounds = YES;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrlList.firstObject]];
    
    //没有图片就不显示
    if (model.imgUrlList.count == 0) {
        //标题
        titleX = gapW;
        titleY = imageY;
        titleW = Screen_Width-2*gapW;
        titleH = 50;
        //时间戳
        subX = titleX;
        subY = gapH+titleH;
        subW = titleW;
        subH = 30;
    }
    
    self.titleLabe.frame = CGRectMake(titleX, titleY, titleW, titleH);
    self.titleLabe.font = [UIFont systemFontOfSize:16];
    self.titleLabe.numberOfLines = 2;
    self.titleLabe.text = model.title;
    
    self.subTitleLabel.font = [UIFont systemFontOfSize:12];
    self.subTitleLabel.frame = CGRectMake(subX, subY, subW, subH);

    //计算时间差
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
/*    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
 formatter.dateFormat = @"MM月dd日";
 NSString * dataStr = [formatter stringFromDate:date];
 
 */
@end

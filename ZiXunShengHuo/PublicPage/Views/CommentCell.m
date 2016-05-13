//
//  CommentCell.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"

@interface CommentCell ()
/** 头像 */
@property (nonatomic, strong) UIImageView * iconImageView;
/** 昵称 */
@property (nonatomic, strong) UILabel * nameLabel;
/** 时间 */
@property (nonatomic, strong) UILabel * timeLabel;
/** 内容 */
@property (nonatomic, strong) UILabel * contentLabel;
@end

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellID = @"CommentCellID";
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellUI];
    }
    return self;
}

- (void)createCellUI
{
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.contentLabel];
}

- (void)setModel:(Commentinfolist *)model
{
    _model = model;
    
    CGFloat iconX = 20;
    CGFloat iconY = 10;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    self.iconImageView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icoUrl]];
    
    
    CGFloat nameX = CGRectGetMaxX(self.iconImageView.frame)+10;
    CGFloat nameY = iconY;
    CGFloat nameW = 150;
    CGFloat nameH = 20;
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
    self.nameLabel.text = model.userName;
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame);
    CGFloat timeW = nameW;
    CGFloat timeH = nameH;
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeW, timeH);
    
    //计算时间差
    NSTimeInterval index = model.posttime/1000;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:index];
    NSString * dataStr = [self computeTimeDifference:date];
    self.timeLabel.text = dataStr;
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    
    
    CGFloat contentX = nameX;
    CGFloat contentY = CGRectGetMaxY(self.timeLabel.frame)+15;
    CGFloat contentW = Screen_Width-iconX-iconW-10-20;
    CGFloat contentH = [model.content sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(contentW, MAXFLOAT)].height;
    self.contentLabel.frame = CGRectMake(contentX, contentY, contentW, contentH);
    self.contentLabel.text = model.content;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    //self.contentLabel.backgroundColor = [UIColor grayColor];
    //ZJLog(@"%lf",self.contentLabel.frame.origin.y);
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

+ (CGFloat)computeCellHeight:(Commentinfolist *)model
{
    CGFloat iconX = 20;
    CGFloat iconW = 40;
    CGFloat contentW = Screen_Width-iconX-iconW-10-20;
    return [model.content sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(contentW, MAXFLOAT)].height+65.0+10;
}
@end

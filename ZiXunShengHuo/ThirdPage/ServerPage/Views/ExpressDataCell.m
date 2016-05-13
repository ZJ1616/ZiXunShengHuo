//
//  ExpressDataCell.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "ExpressDataCell.h"
#import "ExpressDataModel.h"
#import "NSString+Extension.h"

@interface ExpressDataCell ()
@property (nonatomic ,strong) UILabel * timeLabel;
@property (nonatomic ,strong) UILabel * actionLabel;
@end

@implementation ExpressDataCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/** 复用方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellId = @"ExpressDataCellId";
    ExpressDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ExpressDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

/** 创建cell界面 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.timeLabel];
        
        self.actionLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.actionLabel];
    }
    
    return self;
}

/** 模型的set方法 创建cell数据 */
- (void)setModel:(ExpressDataModel *)model
{
    _model = model;
    self.timeLabel.text = model.time;
    self.timeLabel.frame = CGRectMake(30, 0, Screen_Width-30, 30);
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    
    self.actionLabel.text = model.action;
    self.actionLabel.numberOfLines = 0;
    self.actionLabel.font = [UIFont systemFontOfSize:15];
    CGSize size = [model.action sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(Screen_Width-60, MAXFLOAT)];
    self.actionLabel.frame = CGRectMake(30, 30, Screen_Width-60, size.height);
}

/** 计算cell高度*/
+ (CGFloat)getCellHeight:(ExpressDataModel *)model
{
    CGSize size = [model.action sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(Screen_Width-60, MAXFLOAT)];
    return 30+size.height+20;
}
@end

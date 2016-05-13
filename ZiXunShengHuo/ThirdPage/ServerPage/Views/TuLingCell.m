//
//  TuLingCell.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "TuLingCell.h"
#import "TuLingMessageModel.h"
#import "TuLingMessageFrame.h"

@interface TuLingCell ()
/** 头像 */
@property (nonatomic, strong) UIImageView *iconView;
/* 正文 */
@property (nonatomic, strong) UIButton *textView;
@end
@implementation TuLingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TuLingCellId";
    TuLingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TuLingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        UIButton *textView = [[UIButton alloc] init];
        textView.titleLabel.numberOfLines = 0; // 自动换行
        textView.titleLabel.font = [UIFont systemFontOfSize:15];
        textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        // 4.设置cell的背景色
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)setMessageFrame:(TuLingMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    TuLingMessageModel * message = messageFrame.message;
    // 2.头像
    NSString *icon = (message.type == MessageTypeMe) ? @"itest" : @"jiqiren";
    self.iconView.image = [UIImage imageNamed:icon];
    self.iconView.frame = messageFrame.iconF;
    
    // 3.正文
    [self.textView setTitle:message.text forState:UIControlStateNormal];
    self.textView.frame = messageFrame.textF;
    
    // 4.正文的背景
    if (message.type == MessageTypeMe) { // 自己发的,蓝色
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_send_nor"] forState:UIControlStateNormal];
    } else { // 别人发的,白色
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_recive_nor"] forState:UIControlStateNormal];
    }
}

@end

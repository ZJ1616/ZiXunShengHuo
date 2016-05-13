//
//  rssBtn.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "RssBtn.h"
#import "ChanneListModel.h"

@interface RssBtn ()
@property (nonatomic ,strong) UIImageView * bgImageView;

@end

@implementation RssBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.bgImageView];
        self.bgImageView.image = [UIImage imageNamed:@"night_trend_comment_bg@2x"];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.nameLabel];
        self.deleteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, -10, 20, 20)];
        self.deleteImageView.image = [UIImage imageNamed:@"reader_list_attachment_delete_pressed"];
        
        [self addSubview:self.deleteImageView];
    }
    return self;
}

- (void)setIsDelete:(BOOL)isDelete
{
    _isDelete = isDelete;
    [self.deleteImageView setHidden:!self.isDelete];
}

- (void)setListModel:(RssListModel *)listModel
{
    self.nameLabel.text = listModel.name;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

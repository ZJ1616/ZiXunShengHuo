//
//  TouTiaoHeadView.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "TouTiaoHeadView.h"
#import "HomeHeadModel.h"
#import "UIButton+WebCache.h"

@interface TouTiaoHeadView () <UIScrollViewDelegate>
//滚动视图
@property (nonatomic, strong) UIScrollView * scrollView;
//网友热议
@property (nonatomic ,strong) UIButton * wyryButton;
//药不能停
@property (nonatomic ,strong) UIButton * ybntButton;
@property (nonatomic ,copy) NSString * wyryButtonUrl;
@property (nonatomic ,copy) NSString * ybntButtonUrl;
@property (nonatomic ,copy) NSArray * gdstButtonUrls;
@property (nonatomic ,strong) NSArray * headModelArray;
@property (nonatomic ,strong) NSTimer * timer;
@end

@implementation TouTiaoHeadView

//构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
//创建UI
- (void)createUI
{
    //滚动视图
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.479*Screen_Width)];
    [self addSubview:self.scrollView];
    self.scrollView.delegate = self;
    //self.scrollView.backgroundColor = [UIColor colorWithRandomColor];
    self.scrollView.pagingEnabled = YES;
    
    //网友热议按钮
    self.wyryButton = [[UIButton alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.scrollView.bounds)+5, (Screen_Width-15)/2, ((Screen_Width-15)/2)*(118.0/291.0))];
    //self.wyryButton.backgroundColor = [UIColor colorWithRandomColor];
    [self.wyryButton addTarget:self action:@selector(wyryButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.wyryButton];
    //药不能停按钮
    self.ybntButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.wyryButton.frame)+5, CGRectGetMaxY(self.scrollView.frame)+5, (Screen_Width-15)/2, ((Screen_Width-15)/2)*(118.0/291.0))];
    //self.ybntButton.backgroundColor = [UIColor colorWithRandomColor];
    [self.ybntButton addTarget:self action:@selector(ybntButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.ybntButton];
}
- (void)wyryButtonClick
{
    ZJLog(@"%@ click wyry",[self class]);
    if (self.wyryButtonUrl) {
        [self.delegate clickHotdebateButton:self.wyryButtonUrl];
    }
}

- (void)ybntButtonClick
{
    ZJLog(@"%@ click ybnt",[self class]);
    if (self.ybntButtonUrl) {
        [self.delegate clickSpecialTopicButton:self.ybntButtonUrl];
    }
}
- (void)clickImage:(UIButton *)button
{
    
    NSInteger index = button.tag - 16;
    ZJLog(@"点击了第%ld张图片  url==%@",index,self.gdstButtonUrls[index]);
    //if (self.gdstButtonUrls) {
        [self.delegate clickAdNews:self.gdstButtonUrls[index] index:index];
   // }
        
}
//****************************
//设置数据
- (void)setHeadModel:(HomeHeadModel *)headModel
{
    _headModel = headModel;
    
    //滚动视图数据
    BlockModel * scrollViewDataModel = self.headModel.blocks[0];
    NSArray * headModelArray = scrollViewDataModel.data;
    ZJLog(@"滚动视图数据%@",headModelArray);
    self.headModelArray = headModelArray;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*headModelArray.count, self.scrollView.bounds.size.height);
    NSMutableArray * urlsArray = [NSMutableArray array];
    for (int i = 0; i < headModelArray.count; i++) {
        NewsSimpleModel * model = headModelArray[i];
        //背景View
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.bounds.size.width*i, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
        [self.scrollView addSubview:view];
        //view.backgroundColor = [UIColor orangeColor];
        
        
        //给背景View上加Button显示图片
        UIButton * imageButton = [[UIButton alloc] initWithFrame:view.bounds];
        ZJLog(@"%@",model.imgUrlList);
        [imageButton sd_setBackgroundImageWithURL:[model.imgUrlList lastObject] forState:UIControlStateNormal];
        [imageButton addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.tag = 16+i;
        [view addSubview:imageButton];
        [urlsArray addObject:model.articleUrl];
        self.gdstButtonUrls = urlsArray;
        
        
        //标题文字
        
        UIView * labelBgView = [[UIView alloc] initWithFrame:CGRectMake(0, view.bounds.size.height-40, view.bounds.size.width, 40)];
        labelBgView.backgroundColor = [UIColor blackColor];
        labelBgView.alpha = 0.5;
        [view addSubview:labelBgView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:labelBgView.frame];
        label.text = model.title;
        label.textColor = [UIColor whiteColor];
        //label.backgroundColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
    }
    
    //网友热议数据
    BlockModel * btnModel = self.headModel.blocks[1];
    NewsSimpleModel * wyryModel = btnModel.data[0];
    ZJLog(@"网友热议数据%@",wyryModel);
    [self.wyryButton sd_setBackgroundImageWithURL:[wyryModel.imgUrlList firstObject] forState:UIControlStateNormal];
    self.wyryButtonUrl = wyryModel.articleUrl;
    //药不能停数据
    NewsSimpleModel * ybntModel = btnModel.data[1];
    [self.ybntButton sd_setBackgroundImageWithURL:[ybntModel.imgUrlList firstObject] forState:UIControlStateNormal];
    self.ybntButtonUrl = ybntModel.articleUrl;
    ZJLog(@"药不能停数据%@",ybntModel);
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
}

- (void)timerAct
{
    NSInteger index = _scrollView.contentOffset.x/_scrollView.bounds.size.width;
    if (index < self.headModelArray.count-1) {
        [UIView animateWithDuration:0.25 animations:^{
            _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width*(index+1), 0);
        }];
    }else if (index == self.headModelArray.count-1){
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset = CGPointZero;
        }];
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end

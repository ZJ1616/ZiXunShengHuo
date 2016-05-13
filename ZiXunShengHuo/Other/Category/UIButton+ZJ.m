//
//  UIButton+ZJ.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/19.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "UIButton+ZJ.h"

@implementation UIButton (ZJ)
+ (UIButton *)createBtnFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor title:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize backgroungImage:(NSString *)bgImageName selectbackgroungImage:(NSString *)selectBgImageName image:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (backgroundColor) {
        btn.backgroundColor = backgroundColor;
    }
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }else{
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (bgImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    
    //选中图片
    if (selectBgImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:selectBgImageName] forState:UIControlStateSelected];
    }
    
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}



@end

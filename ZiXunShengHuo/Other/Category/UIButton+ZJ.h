//
//  UIButton+ZJ.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/19.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZJ)
/**
 *  快速创建UIButton
 *
 *  @param frame             <#frame description#>
 *  @param backgroundColor   <#backgroundColor description#>
 *  @param title             <#title description#>
 *  @param titleColor        <#titleColor description#>
 *  @param fontSize          <#fontSize description#>
 *  @param bgImageName       <#bgImageName description#>
 *  @param selectBgImageName <#selectBgImageName description#>
 *  @param imageName         <#imageName description#>
 *  @param target            <#target description#>
 *  @param action            <#action description#>
 *
 *  @return <#return value description#>
 */
+ (UIButton *)createBtnFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor title:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize backgroungImage:(NSString *)bgImageName selectbackgroungImage:(NSString *)selectBgImageName image:(NSString *)imageName target:(id)target action:(SEL)action;
@end

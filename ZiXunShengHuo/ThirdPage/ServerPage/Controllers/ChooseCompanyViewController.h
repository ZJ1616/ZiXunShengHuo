//
//  ChooseCompanyViewController.h
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "BaseViewController.h"
@class ExpressCompanyModel;
@protocol ChooseCompanyViewControllerDelegate <NSObject>

- (void)selectExpressCompany:(ExpressCompanyModel *)model;

@end
@interface ChooseCompanyViewController : BaseViewController
@property (nonatomic ,weak) id<ChooseCompanyViewControllerDelegate> delegate;
@end

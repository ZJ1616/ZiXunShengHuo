//
//  CommentView.h
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentViewDelegate <NSObject>
- (void)showNoCommentAlert;
@end
@interface CommentView : UIView
@property (nonatomic, strong) NSNumber * articleId;
@property (nonatomic, weak) id<CommentViewDelegate> delegate;
@end

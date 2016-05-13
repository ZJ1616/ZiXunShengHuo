//
//  CommentView.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/30.
//  Copyright © 2016年 周杰. All rights reserved.
//  http://reader.meizu.com/android/unauth/comment/getarticlecomment.do?articleId=117726457&startPos=-1&commentId=-1

#import "CommentView.h"
#import "CommentModel.h"
#import "MJExtension.h"
#import "ZJHttpTool.h"
#import "CommentCell.h"

@interface CommentView () <UITableViewDelegate,UITableViewDataSource>
/** 表格视图 */
@property (nonatomic, strong) UITableView * tableView;
/** 热门评论列表数组*/
@property (nonatomic, strong) NSArray * hotCommentInfoListArray;
/** 热门评论列表数组Cell高度 */
@property (nonatomic, strong) NSArray * hotCommentCellHeightArray;
/** 普通评论列表 */
@property (nonatomic, strong) NSArray * commentInfoListArray;
/** 普通评论列表数组Cell高度 */
@property (nonatomic, strong) NSArray * commentCellHeightArray;
@end
@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
}

- (void)reloadTableViewUI
{
    [self.tableView reloadData];
    if (self.hotCommentInfoListArray.count==0&&self.commentInfoListArray.count==0) {
        //ZJLog(@"此资讯暂时没有评论");
        [self.delegate showNoCommentAlert];
    }
}

- (void)setArticleId:(NSNumber *)articleId
{
    _articleId = articleId;
    [self downloadData:articleId];
}

- (void)downloadData:(NSNumber *)articleId
{
    NSString * urlStr = [NSString stringWithFormat:CommentDataURL,articleId];
    [ZJHttpTool getForURLSessionWithURL:urlStr success:^(id responseObject) {
        //
        CommentModel * comModel = [CommentModel mj_objectWithKeyValues:responseObject];
        if (comModel.code==200) {//判断是否成功
            CommentValue * valueModel = comModel.value;
            //接收评论数据
            self.hotCommentInfoListArray = valueModel.hotCommentInfoList;
            self.commentInfoListArray = valueModel.commentInfoList;
            
            //计算Cell高度
            NSMutableArray * arrayM1 = [NSMutableArray array];
            for (Commentinfolist * model in self.hotCommentInfoListArray) {
                CGFloat height = [CommentCell computeCellHeight:model];
                [arrayM1 addObject:@(height)];
            }
            self.hotCommentCellHeightArray = arrayM1;
            NSMutableArray * arrayM2 = [NSMutableArray array];
            for (Commentinfolist * model in self.commentInfoListArray) {
                CGFloat height = [CommentCell computeCellHeight:model];
                [arrayM2 addObject:@(height)];
            }
            self.commentCellHeightArray = arrayM2;
            
            
            [self performSelectorOnMainThread:@selector(reloadTableViewUI) withObject:nil waitUntilDone:NO];
        }
    } failure:^(NSError *error) {
        //
        ZJLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.hotCommentInfoListArray) {
            return self.hotCommentInfoListArray.count;
        }
        return 0;
    }else if (section == 1){
        if (self.commentInfoListArray) {
            return self.commentInfoListArray.count;
        }
        return 0;
    }else
        return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self.hotCommentCellHeightArray[indexPath.row] floatValue];
    }else if (indexPath.section == 1){
    
        return [self.commentCellHeightArray[indexPath.row] floatValue];
    }else
        return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //
        CommentCell * cell = [CommentCell cellWithTableView:tableView];
        cell.model = self.hotCommentInfoListArray[indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        //
        CommentCell * cell = [CommentCell cellWithTableView:tableView];
        cell.model = self.commentInfoListArray[indexPath.row];
        return cell;
    }else
        return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

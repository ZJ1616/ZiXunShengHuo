//
//  ChanneListView.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "ChanneListView.h"
#import "ChanneListModel.h"
#import "ZJHttpTool.h"
#import "MJExtension.h"
#import "ChanneListCell.h"
#import "DatabaseTool.h"

@interface ChanneListView () <UITableViewDelegate,UITableViewDataSource>
/** 保存模型数组 */
@property (nonatomic ,strong) NSArray * modelArray;
@property (nonatomic ,strong) UITableView * tableView;
@end

@implementation ChanneListView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createTableView];
        
        
    }
    return self;
}

/*******/
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Screen_Width*(83/382.0);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"ChanneListCellId";
    ChanneListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ChanneListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.ListModel = self.modelArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate clickChanneListButton:self.modelArray[indexPath.row]];
}
/******/

- (void)setListModel:(ChanneListModel *)listModel
{
    _listModel = listModel;
    
    [self downloadData:listModel.rssUrl];
    
    
}

- (void)downloadData:(NSString *)rssUrl
{
    [ZJHttpTool getWithURL:rssUrl success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            [RssListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"Id":@"id",@"desc":@"description"};
            }];
            self.modelArray = [RssListModel mj_objectArrayWithKeyValuesArray:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                //[self createButton];
                [self.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        if (error) {
            ZJLog(@"%@",error);
        }
    }];
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  Server8ViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 周杰. All rights reserved.
//  ec03182e7fb462ac63e3ae713d47fc55

#import "TuLingViewController.h"
#import "ZJHttpTool.h"
#import "TuLingMessageModel.h"
#import "TuLingMessageFrame.h"
#import "TuLingCell.h"
@interface TuLingViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) UITextField * textField;
/** 保存cell内部控件的位置尺寸 包含模型 通过传递模型计算 */
@property (nonatomic ,strong) NSMutableArray * frameArray;


@end

@implementation TuLingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"和机器人聊天";
    //创建表格视图
    [self createTableView];
    //创建底部的输入视图
    [self createBottomView];
    //添加监听
    [self addNotificaitonObserver];
}


- (NSMutableArray *)frameArray
{
    if (_frameArray == nil) {
        _frameArray = [NSMutableArray array];
    }
    return _frameArray;
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-48) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    // 去除分割线
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO; // 不允许选中
    
}

- (void)createBottomView
{
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-48, self.view.bounds.size.width, 48)];
    [self.view addSubview:bottomView];
    //背景
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:bottomView.bounds];
    bgImageView.image = [UIImage imageNamed:@"chat_bottom_bg"];
    [bottomView addSubview:bgImageView];
    //输入框
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 5, bottomView.bounds.size.width-100, bottomView.bounds.size.height-10)];
    textField.background = [UIImage imageNamed:@"chat_bottom_textfield"];
    [bottomView addSubview:textField];
    self.textField = textField;
    //发送按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(CGRectGetMaxX(textField.frame), 0, 60, bottomView.bounds.size.height);
    [bottomView addSubview:button];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    
    
}

/** 点击发送 */
- (void)clickButton
{
    //输入框没有内容  不发送
    if (self.textField.text.length==0) {
        return;
    }
    
    NSString * message = self.textField.text;
    //转成消息模型
    TuLingMessageModel * model = [[TuLingMessageModel alloc] init];
    model.text = message;
    model.type = MessageTypeMe;
    //计算内部位置尺寸
    TuLingMessageFrame * mf = [[TuLingMessageFrame alloc] init];
    mf.message = model;
    //加入数组
    [self.frameArray addObject:mf];
    //刷新界面
    [self reloadTableViewUI];
    //清空输入框内容
    self.textField.text = nil;
    [self downloadData:message];
}

//接收返回信息
- (void)downloadData:(NSString *)message
{
    NSString * key = TuLingAPPKey;
    NSString * url = TuLingURL;
    NSMutableDictionary * para = [[NSMutableDictionary alloc] init];
    [para setObject:key forKey:@"key"];
    [para setObject:message forKey:@"info"];
    [para setObject:@"1406187962" forKey:@"userid"];
    
    [ZJHttpTool POSTWithUrl:url andParameters:para success:^(id responseObject) {
        if ([responseObject[@"reason"] isEqualToString:@"成功的返回"]) {
            NSDictionary * dict = responseObject[@"result"];
            //信息转模型
            TuLingMessageModel * model = [[TuLingMessageModel alloc] init];
            model.text = dict[@"text"];
            //ZJLog(@"%@",model.text);
            model.type = MessageTypeOther;
            //计算位置尺寸
            TuLingMessageFrame * fm = [[TuLingMessageFrame alloc] init];
            fm.message = model;
            //加入数组
            [self.frameArray addObject:fm];
            [self performSelectorOnMainThread:@selector(reloadTableViewUI) withObject:nil waitUntilDone:NO];
        }
    } failure:^(NSError *error) {
        //
        ZJLog(@"%@",error);
    }];
    
}

/** 刷新界面 */
- (void)reloadTableViewUI
{
    [self.tableView reloadData];
    if (self.tableView.contentSize.height<self.tableView.bounds.size.height) {
        self.tableView.userInteractionEnabled = NO;
    }else{self.tableView.userInteractionEnabled = YES;}
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height -self.tableView.bounds.size.height) animated:NO];
    
}
/** 添加通知 */
-(void)addNotificaitonObserver
{
    //键盘显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary * dict = notification.userInfo;
    NSLog(@"---->%@",dict);
    //获取键盘弹出所需的事件
    CGFloat duration = [dict[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.bounds = CGRectMake(0, 258, self.view.bounds.size.width, self.view.bounds.size.height);
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    NSDictionary * dict = notification.userInfo;
    NSLog(@"---->%@",dict);
    //获取键盘弹出所需的事件
    CGFloat duration = [dict[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }];
}
#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.frameArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TuLingMessageFrame * mf = self.frameArray[indexPath.row];
    return mf.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TuLingCell * cell = [TuLingCell cellWithTableView:tableView];
    cell.messageFrame = self.frameArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

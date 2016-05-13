//
//  PhoneNumViewController.m
//  ZJProjectBete3
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 周杰. All rights reserved.
//  https://www.juhe.cn/docs/api/id/72


#import "PhoneNumViewController.h"
#import "ZJHttpTool.h"
#import "PhoneNumModel.h"
#import "MJExtension.h"

@interface PhoneNumViewController ()
@property (nonatomic ,strong) PhoneNumModel * phoneNumModel;
@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) UITextField * textField;
@end

@implementation PhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self downloadData];
    [self createUI];
    [self createHeatView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI
{
    self.title = @"查号码";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-48) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)createHeatView
{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 150)];
    self.tableView.tableHeaderView = headView;
    headView.backgroundColor = ZJColor(33, 118, 195);
    CGFloat gap = 20;
    CGFloat labelX = gap;
    CGFloat labelY = gap;
    CGFloat labelW = Screen_Width-40;
    CGFloat labelH = 30;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    label.text = @"输 入 号 码";
    label.textAlignment = NSTextAlignmentCenter;
    //label.font = [UIFont systemFontOfSize:13];
    [headView addSubview:label];
    
    CGFloat textX = gap;
    CGFloat textY = gap+40;
    CGFloat textW = labelW;
    CGFloat textH = labelH;
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(textX, textY, textW, textH)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [headView addSubview:self.textField];
    
    CGFloat btnX = gap;
    CGFloat btnY = 100;
    CGFloat btnW = labelW;
    CGFloat btnH = 40;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [button setTitle:@"查   询" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:button];
}

/** 点击查询按钮 */
- (void)clickButton
{
    NSString * tel = self.textField.text;
    if (tel.length>0) {
        [self downloadData:tel];
    }else{
        [ZJAlertTool showMessage:@"没有输入无法查询啊" target:self];
    }
}

- (void)createFootView
{
    NSString * phomeNum = [NSString stringWithFormat:@"查询号码:%@",self.phoneNumModel.result.phone];
    NSString * province = [NSString stringWithFormat:@"号码所属省份:%@",self.phoneNumModel.result.province];
    NSString * city = [NSString stringWithFormat:@"号码所属城市:%@",self.phoneNumModel.result.city];
    NSString * sp = [NSString stringWithFormat:@"号码所属运营商号码:%@",self.phoneNumModel.result.sp];
    NSString * rpt_type = [NSString stringWithFormat:@"号码性质:%@",self.phoneNumModel.result.rpt_type];
    NSString * rpt_comment = [NSString stringWithFormat:@"号码性质描述:%@",self.phoneNumModel.result.rpt_comment];
    NSString * countDesc = [NSString stringWithFormat:@"号码被查询状况:%@",self.phoneNumModel.result.countDesc];
    NSMutableString * tempStr = [NSMutableString string];
    if (self.phoneNumModel.result.phone.length>0) {
        [tempStr appendFormat:@"%@\n",phomeNum];
    }
    if (self.phoneNumModel.result.province.length>0) {
        [tempStr appendFormat:@"%@\n",province];
    }
    if (self.phoneNumModel.result.city.length>0) {
        [tempStr appendFormat:@"%@\n",city];
    }
    if (self.phoneNumModel.result.sp.length>0) {
        [tempStr appendFormat:@"%@\n",sp];
    }
    if (self.phoneNumModel.result.rpt_type.length>0) {
        [tempStr appendFormat:@"%@\n",rpt_type];
    }
    if (self.phoneNumModel.result.rpt_comment.length>0) {
        [tempStr appendFormat:@"%@\n",rpt_comment];
    }
    if (self.phoneNumModel.result.countDesc.length>0) {
        [tempStr appendFormat:@"%@\n",countDesc];
    }
    
    ZJLog(@"%@",tempStr);
    
    UIView * footView = [[UIView alloc] init];
    UILabel * label = [[UILabel alloc] init];
    label.text = tempStr;
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    NSDictionary * attribute = @{NSFontAttributeName:label.font};
    CGSize maxSize = CGSizeMake(Screen_Width-40, CGFLOAT_MAX);
    CGSize size = [label.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    label.frame = CGRectMake(20, 20, size.width, size.height);
    [footView addSubview:label];
    footView.frame = CGRectMake(0, 0, Screen_Width, 40+label.bounds.size.height);
    self.tableView.tableFooterView = footView;
    
}
- (void)downloadData:(NSString *)tel
{
    NSMutableDictionary * para = [NSMutableDictionary dictionary];
    [para setObject:PhoneNumberAPPKey forKey:@"key"];
    [para setObject:tel forKey:@"tel"];
    [ZJHttpTool POSTWithUrl:PhoneNumberURL andParameters:para success:^(id responseObject) {
        if ([responseObject[@"error_code"] isEqualToNumber:@(0)]) {
            self.phoneNumModel = [PhoneNumModel mj_objectWithKeyValues:responseObject];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self createFootView];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJAlertTool showMessage:responseObject[@"reason"] target:self];
            });
        }
        
    } failure:^(NSError *error) {
        ZJLog(@"%@",error);
    }];
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

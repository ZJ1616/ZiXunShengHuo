//
//  Near2ViewController.m
//  ZJProjectBete3
//
//  Created by 周杰 on 16/3/25.
//  Copyright © 2016年 周杰. All rights reserved.
//

#import "Near2ViewController.h"

@interface Near2ViewController ()

@end

@implementation Near2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString * urlStr = MeiTuanURL;
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-48)];
    [self.view addSubview:webView];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.scalesPageToFit = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

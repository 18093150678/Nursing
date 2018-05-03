//
//  ReportController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/16.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "ReportController.h"

@interface ReportController ()

@end

@implementation ReportController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"我的报告单";
    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    UIButton *leftBack = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBack.frame = CGRectMake(0, 0, 30, 30);
    [leftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    leftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [leftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [leftBack addTarget:self action:@selector(RepBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBack];
    
    
    self.navigationItem.leftBarButtonItem = LeftButtonItem;
    
    
    ViewB = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    
    [self.view addSubview:ViewB];
    
    [self WebGetDataProductInfo];

}

-(void)WebGetDataProductInfo{
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,64, SIZE_WIDTH,SIZE_HEIGHT-40)];
    webView.delegate = self ;
    webView.backgroundColor = [UIColor whiteColor];
    //是否支持互动
    [webView setUserInteractionEnabled:YES];
    //是否适应屏幕
    [webView setScalesPageToFit:YES];
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    [ViewB addSubview:webView];
    NSString *repUrl =service_Report;
    NSString *StrUrl = [NSString stringWithFormat:@"%@%@?user_tel=%@&ios=1&user_id=%@",[USER_DEFAULT objectForKey:@"SERVERIP"],repUrl,[USER_DEFAULT objectForKey:@"UserName"],[USER_DEFAULT objectForKey:@"user_id"]];
    NSLog(@"StrUrl------%@",StrUrl);
    NSURL *url= [NSURL URLWithString:StrUrl];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

#pragma mark - 自定义返回按钮事件
-(void)RepBackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

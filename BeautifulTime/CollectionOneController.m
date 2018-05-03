//
//  CollectionOneController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/27.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "CollectionOneController.h"

@interface CollectionOneController ()

@end

@implementation CollectionOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"孕检百科";
    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *CollLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CollLeftBack.frame =CGRectMake(0, 0, 30, 30);
    [CollLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    CollLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [CollLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [CollLeftBack addTarget:self action:@selector(CollectionBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:CollLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    
    self.navigationController.navigationBar.translucent = YES;
    
    
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT-64)];
    NSString *url=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],@"mamaishouce/index.html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -返回按钮
-(void)CollectionBackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end

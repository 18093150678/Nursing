//
//  CollectionTowController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/5.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "CollectionTowController.h"

@interface CollectionTowController ()

@end

@implementation CollectionTowController
@synthesize titleName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = titleName;
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
    
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64,SIZE_WIDTH, SIZE_HEIGHT-64)];
    NSString *url=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],_WebUrl];
    NSLog(@"url----%@",url);
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

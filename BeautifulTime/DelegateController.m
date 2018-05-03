//
//  DelegateController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/16.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "DelegateController.h"

@interface DelegateController ()

@end

@implementation DelegateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.font = [UIFont systemFontOfSize:14.0];
    ConTitleView.text = @"服务条款";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *serverLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    serverLeftBack.frame =CGRectMake(0, 0, 30, 30);
    [serverLeftBack setBackgroundImage:[UIImage imageNamed:@"backbutton.png"] forState:UIControlStateNormal];
    [serverLeftBack addTarget:self action:@selector(serverBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:serverLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;

}

#pragma mark -返回按钮
-(void)serverBackFunc:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

@end

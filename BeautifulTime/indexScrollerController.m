//
//  indexScrollerController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/11.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "indexScrollerController.h"

@interface indexScrollerController ()

@end

@implementation indexScrollerController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.font = [UIFont systemFontOfSize:14.0];
    ConTitleView.text = @"资讯";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *scrLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    scrLeftBack.frame =CGRectMake(0, 0, 30, 30);
    scrLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [scrLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [scrLeftBack addTarget:self action:@selector(BackConFuncscro:) forControlEvents:UIControlEventTouchUpInside];
    [scrLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    UIBarButtonItem *LeftBarButtonscr = [[UIBarButtonItem alloc]initWithCustomView:scrLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftBarButtonscr;
    
    
    [self webViewUrlLoadFunc];
}

#pragma mark -页面加载方法
-(void)webViewUrlLoadFunc{
    
    scrowebView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH,SIZE_HEIGHT)];
    scrowebView.backgroundColor = [UIColor whiteColor];
    scrowebView.delegate = self;
    //适应屏幕
    [scrowebView setScalesPageToFit:YES];
    //是否支持互动
    [scrowebView setUserInteractionEnabled:YES];
    //关闭右侧和下册滚动条显示
    scrowebView.scrollView.showsHorizontalScrollIndicator = NO;
    scrowebView.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:scrowebView];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@",_infomentID];
    
    [scrowebView loadRequest:[NSURLRequest requestWithURL:[self urlLoad:strUrl]]];
    
    
}


#pragma mark -加载地址

-(NSURL *)urlLoad:(NSString *)Strurl{

    NSString *Url = [NSString stringWithFormat:@"%@",Strurl];
    NSURL *NsPloadUrl = [NSURL URLWithString:Url];
    return NsPloadUrl;
    
}


-(void)BackConFuncscro:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

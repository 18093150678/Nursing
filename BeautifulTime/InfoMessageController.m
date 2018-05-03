//
//  InfoMessageController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/14.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "InfoMessageController.h"

@interface InfoMessageController ()

@end

@implementation InfoMessageController
@synthesize infomentID;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"资讯";
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *LeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LeftBack.frame =CGRectMake(0, 0, 30, 30);
    LeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [LeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [LeftBack addTarget:self action:@selector(BackConFunc:) forControlEvents:UIControlEventTouchUpInside];
    [LeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc]initWithCustomView:LeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftBarButton;


    [self webViewUrlLoadFunc];

}

#pragma mark -页面加载方法
-(void)webViewUrlLoadFunc{

    webView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH,SIZE_HEIGHT)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.delegate = self;
    //适应屏幕
    [webView setScalesPageToFit:YES];
    //是否支持互动
    [webView setUserInteractionEnabled:YES];
    //关闭右侧和下册滚动条显示
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:webView];
 
    NSString *strUrl = [NSString stringWithFormat:@"%@mycenter/ios_news_info.htm?id=%@",[USER_DEFAULT objectForKey:@"SERVERIP"],infomentID];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[self urlLoad:strUrl]]];
    

}


#pragma mark -加载地址

-(NSURL *)urlLoad:(NSString *)Strurl{

    NSString *Url = [NSString stringWithFormat:@"%@",Strurl];
    NSURL *NsPloadUrl = [NSURL URLWithString:Url];
    return NsPloadUrl;

}

-(void)BackConFunc:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

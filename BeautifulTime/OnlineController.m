//
//  OnlineController.m
//  BeautifulTime
//
//  Created by lee on 2017/5/16.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "OnlineController.h"

@interface OnlineController ()

@end

@implementation OnlineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"在线咨询";
    [indexLabel setFont:[UIFont fontWithName:@"BanglaSangamMN-Bold" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    UIButton *leftBack = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBack.frame = CGRectMake(0, 0, 30, 30);
    [leftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    leftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [leftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [leftBack addTarget:self action:@selector(closeFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBack];
    
    
    self.navigationItem.leftBarButtonItem = LeftButtonItem;

    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self WebGetDataProductInfo];


}


-(void)WebGetDataProductInfo{
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(5,64, SIZE_WIDTH-10,SIZE_HEIGHT-65)];
    webView.delegate = self ;
    webView.backgroundColor = [UIColor whiteColor];
    //是否支持互动
    [webView setUserInteractionEnabled:YES];
    //是否适应屏幕
    [webView setScalesPageToFit:YES];
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:webView];
    
    NSString *StrUrl = [NSString stringWithFormat:@"%@",@"http://kefu.kuaishang.cn/bs/im.htm?cas=6059___18887&fi=7028"];
    
    NSURL *url= [NSURL URLWithString:StrUrl];
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

-(void)closeFunc:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end

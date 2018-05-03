//
//  CorporateController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/11.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "CorporateController.h"

@interface CorporateController ()

@end

@implementation CorporateController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.font = [UIFont systemFontOfSize:14.0];
    ConTitleView.text = @"企业文化";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *cLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cLeftBack.frame =CGRectMake(0, 0, 30, 30);
    cLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [cLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [cLeftBack addTarget:self action:@selector(BackConFuncC:) forControlEvents:UIControlEventTouchUpInside];
    [cLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    UIBarButtonItem *LeftBarButtonscr = [[UIBarButtonItem alloc]initWithCustomView:cLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftBarButtonscr;
    
     [self webViewUrlLoadFunc];

}

#pragma mark -页面加载方法
-(void)webViewUrlLoadFunc{
    
    CwebView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH,SIZE_HEIGHT)];
    CwebView.backgroundColor = [UIColor whiteColor];
    CwebView.delegate = self;
    //适应屏幕
    [CwebView setScalesPageToFit:YES];
    //是否支持互动
    [CwebView setUserInteractionEnabled:YES];
    //关闭右侧和下册滚动条显示
    CwebView.scrollView.showsHorizontalScrollIndicator = NO;
    CwebView.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:CwebView];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@",_infomentID];
    
    [CwebView loadRequest:[NSURLRequest requestWithURL:[self urlLoad:strUrl]]];
    
    
}

#pragma mark -加载地址

-(NSURL *)urlLoad:(NSString *)Strurl{
    
    NSString *Url = [NSString stringWithFormat:@"%@",Strurl];
    NSURL *NsPloadUrl = [NSURL URLWithString:Url];
    return NsPloadUrl;
    
}


-(void)BackConFuncC:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

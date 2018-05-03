//
//  BookingController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/11.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "BookingController.h"

@interface BookingController ()

@end

@implementation BookingController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.font = [UIFont systemFontOfSize:14.0];
    ConTitleView.text = @"在线预约";
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
    
    BookingwebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH,SIZE_HEIGHT)];
    BookingwebView.backgroundColor = [UIColor whiteColor];
    
    BookingwebView.delegate=self;
    //是否支持互动
    [BookingwebView setUserInteractionEnabled:YES];
    //关闭右侧和下册滚动条显示
    BookingwebView.scrollView.showsHorizontalScrollIndicator = NO;
    BookingwebView.scrollView.showsVerticalScrollIndicator = NO;
    NSString *strUrl = [NSString stringWithFormat:@"%@",_infomentID];
    NSLog(@"strUrl------%@",strUrl);
    
    [BookingwebView loadRequest:[NSURLRequest requestWithURL:[self urlLoad:strUrl]]];
    
//    [BookingwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.163.com"]]];

    [self.view addSubview:BookingwebView];
    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationTyp{

    NSString *requestString = [[[request URL] absoluteString]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"requestString : %@",requestString);
    
    
    NSArray *components = [requestString componentsSeparatedByString:@"|"];
    NSLog(@"=components=====%@",components);
    
    
    NSString *str1 = [components objectAtIndex:0];
    NSLog(@"str1:::%@",str1);
    
    
    NSArray *array2 = [str1 componentsSeparatedByString:@"/"];
    NSLog(@"array2:====%@",array2);
    
    
    NSInteger coun = array2.count;
    NSString *method = array2[coun-1];
    NSLog(@"method:===%@",method);
    
    if ([method isEqualToString:@"index.htm"]) {
        
        NSLog(@"跳转到首页");
        [self.navigationController popViewControllerAnimated:YES];
    }

    if ([method isEqualToString:@"yy.htm"]) {
        
        NSLog(@"跳转到首页");
        [self.navigationController popViewControllerAnimated:YES];
    }

    
    return YES;
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

//
//  TeYueDoctorWebController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/8.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "TeYueDoctorWebController.h"

@interface TeYueDoctorWebController ()

@end

@implementation TeYueDoctorWebController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"特邀名医";
    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;

    
    UIButton *DoctorLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    DoctorLeftBack.frame =CGRectMake(0, 0, 30, 30);
    [DoctorLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    DoctorLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [DoctorLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [DoctorLeftBack addTarget:self action:@selector(DoctorBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:DoctorLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerCompletion:)
                                                 name:@"RegisterCompletionNotification"
                                               object:nil];
    
    
    searchwebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT-64)];
    searchwebView.delegate= self;
    [self webUrlLoad];
    [self.view addSubview:searchwebView];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)registerCompletion:(NSNotification*)notification {
    //接受notification的userInfo，可以把参数存进此变量
    NSDictionary *theData = [notification userInfo];
    _doctorID = [theData objectForKey:@"doctorID"];
    
    NSLog(@"username = %@",_doctorID);
    [self webUrlLoad];
}


-(void)DoctorBackFunc:(id)sender{

     [self.navigationController popViewControllerAnimated:YES];

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationTyp{
    
    AppointmentController *Appointment=nil;
    
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
    

    
        if ([method isEqualToString:@"doctor_confirm.htm"]) {
            
            if([USER_DEFAULT objectForKey:@"user_id"] ==NULL){
                
                
                NSLog(@"未登陆");
                [self loginController];
                
                return NO;
                
            }else{
            
                NSLog(@"已经登陆");
                return YES;
            }
            
            
        }


    if ([method isEqualToString:@"index.htm"]) {
        
        NSLog(@"跳转到首页");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if ([method isEqualToString:@"yy.htm"]) {
        
        NSLog(@"预约列表");
        
        if ([_teyuejonClass isEqualToString:@"userClass"]) {
            
        [self.navigationController popViewControllerAnimated:YES];
            
        }else{

        Appointment=[[AppointmentController alloc]init];
        Appointment.hidesBottomBarWhenPushed = YES;
        Appointment.jionClass =@"algin";
        [self.navigationController pushViewController:Appointment animated:YES];
        }
        
    }
    if ([method isEqualToString:@"zxzx.htm"]) {
        
        return YES;
    }
    
    if (navigationTyp == UIWebViewNavigationTypeLinkClicked)
    {
        NSURL *url = [request URL];
        NSLog(@"url--%@",url);
        // 这里加入判断语句，判断网页url，是否需要继续跳转，或是使用原生页面
        return NO; // 返回NO，结束网页跳转，如果要继续跳转，需要返回YES
    }
    
    return YES;
}

#pragma mark -调用登陆Controller
-(void)loginController{
    
    loginCon=[[LoginController alloc]init];
    loginNav=[[UINavigationController alloc]initWithRootViewController:loginCon];
    [self presentViewController:loginNav animated:YES completion:^{
        
    }];
    
}

-(void)webUrlLoad{

    NSString *url_1=@"yuyue/doctor_info.htm?id=";
    NSString *surl_1=[NSString stringWithFormat:@"%@%@",url_1,_doctorID];
    NSString *url_2=@"ios=1";
    NSString *url_3=[NSString stringWithFormat:@"user_id=%@",[USER_DEFAULT objectForKey:@"user_id"]];
    NSString *url = [USER_DEFAULT objectForKey:@"SERVERIP"];
    NSString *Url=[NSString stringWithFormat:@"%@%@&%@&%@",url,surl_1,url_2,url_3];
    NSLog(@"url-----%@",Url);
    [searchwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:Url]]];

}



@end

//
//  LoginController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/8.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//



#import "LoginController.h"


@interface LoginController (){


    UITextField *userPhone;
    UITextField *userPassword;
    UITextField *userName;
    UITextField *smsOder;
    UIButton *smsBut;

}

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *viewBackground=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    UIImageView *imageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    imageView.image = [UIImage imageNamed:@"login_bg.jpg"];
    [viewBackground addSubview:imageView];
    [self.view addSubview:viewBackground];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    //  self.navigationController.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bj.jpg"]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 100 , SIZE_WIDTH-120, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:26.0]];
    titleLabel.textColor = [UIColor blackColor];//设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"大肚婆";
    titleLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    UIButton *LeftCloses=[[UIButton alloc]initWithFrame:CGRectMake(15,30, 24, 24)];
    [LeftCloses setImage:[UIImage imageNamed:@"login_back.png"] forState:UIControlStateNormal];
    //   LeftClose.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"back_but.png"]];
    [LeftCloses setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [LeftCloses addTarget:self action:@selector(closeConFunc) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:LeftCloses];
//    UIBarButtonItem *BarLeftButs=[[UIBarButtonItem alloc]initWithCustomView:LeftCloses];
//    self.navigationItem.leftBarButtonItem=BarLeftButs;
    
    UIView *userView=[[UIView alloc]initWithFrame:CGRectMake(30, 160, SIZE_WIDTH-60,40)];
    userView.layer.cornerRadius = 20;
    userView.layer.masksToBounds = true;
    userView.layer.borderColor = [[UIColor whiteColor]CGColor];
    userView.layer.borderWidth = 1;

    [userView setBackgroundColor:[UIColor clearColor]];
    
    
    UILabel *usernamelabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 30)];
    usernamelabel.backgroundColor=[UIColor clearColor];
    usernamelabel.text=@"手机号:";
    usernamelabel.textColor=[UIColor whiteColor];
    usernamelabel.font=[UIFont systemFontOfSize:14.0f];
    [userView addSubview:usernamelabel];
    
    userPhone=[[UITextField alloc]initWithFrame:CGRectMake(70, 0, userView.frame.size.width-100, 40)];
    userPhone.borderStyle=UITextBorderStyleRoundedRect;
    userPhone.font = [UIFont systemFontOfSize:14.0];
    userPhone.backgroundColor=[UIColor clearColor];
    userPhone.keyboardType=UIKeyboardTypeNumberPad;
    userPhone.textColor =[UIColor whiteColor];
    [userPhone setBorderStyle:UITextBorderStyleNone];
       [userView addSubview:userPhone];
    
    [self.view addSubview:userView];
    
    
    UIView *smsoderview=[[UIView alloc]initWithFrame:CGRectMake(30, 220, SIZE_WIDTH-60, 40)];
    smsoderview.layer.cornerRadius = 20;
    smsoderview.layer.masksToBounds = true;
    smsoderview.layer.borderColor = [[UIColor whiteColor]CGColor];
    smsoderview.layer.borderWidth = 1;
    [smsoderview setBackgroundColor:[UIColor clearColor]];
    
    UILabel *sms=[[UILabel alloc]initWithFrame:CGRectMake(10,5,60, 30)];
    sms.backgroundColor=[UIColor clearColor];
    sms.text=@"验证码:";
    sms.textColor=[UIColor whiteColor];
    sms.font=[UIFont systemFontOfSize:14.0f];
    [smsoderview addSubview:sms];
    
    smsOder=[[UITextField alloc]initWithFrame:CGRectMake(65, 5,SIZE_WIDTH-210, 30)];
    smsOder.borderStyle=UITextBorderStyleRoundedRect;
    smsOder.keyboardType=UIKeyboardTypeNumberPad;
    smsOder.font = [UIFont systemFontOfSize:14.0f];
    [smsOder setBorderStyle:UITextBorderStyleNone];
    smsOder.textColor = [UIColor whiteColor];
    [smsoderview addSubview:smsOder];
    
    
    smsBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    smsBut.frame = CGRectMake(smsoderview.frame.size.width-105,4,100, 33);
    [smsBut.layer setMasksToBounds:YES];
    [smsBut.layer setCornerRadius:16.0];
    smsBut.titleLabel.font=[UIFont systemFontOfSize:14.0f];
    [smsBut setBackgroundColor:[UIColor clearColor]];
    smsBut.alpha = 1.0;
    //   [smsBut setImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateNormal];
    [smsBut addTarget:self action:@selector(getSmsfunc) forControlEvents:UIControlEventTouchUpInside];
    [smsoderview addSubview:smsBut];
    [self.view addSubview:smsoderview];
    
    labelBut=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, smsBut.frame.size.width, 33)];
    labelBut.text=@"获取验证码";
    labelBut.font = [UIFont systemFontOfSize:14.0f];
    labelBut.textColor  = [UIColor whiteColor];
    labelBut.textAlignment = NSTextAlignmentCenter;
    [smsBut addSubview:labelBut];
    
    
    
    b_button=[[UIButton alloc]initWithFrame:CGRectMake(30, 280, SIZE_WIDTH-60, 40)];
    b_button.backgroundColor=[UIColor clearColor];
    [b_button setTitle:@" 登 陆 " forState:UIControlStateNormal];
    b_button.layer.cornerRadius = 20;
    b_button.layer.masksToBounds = true;
    b_button.layer.borderColor = [[UIColor whiteColor]CGColor];
    b_button.layer.borderWidth = 1;
    [b_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [b_button addTarget:self action:@selector(regButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b_button];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    UIButton *ceshibut=[[UIButton alloc]initWithFrame:CGRectMake(100, 340, 140, 30)];
    [ceshibut setTitle:@"按钮" forState:UIControlStateNormal];
    ceshibut.backgroundColor=[UIColor redColor];
    [ceshibut addTarget:self action:@selector(gotoUserInfo) forControlEvents:UIControlEventTouchUpInside];
    
  //  [self.view addSubview:ceshibut];
    
    
}
-(void)viewWillAppear:(BOOL)animated{

    resultSMS = @"error";

}

-(void)getSmsfunc{
    
    
    if (userPhone.text.length<=0) {
        
        [self anminView:@"请先输入手机号码"];
        
    }else{
        
        
        //调用发送短信接口
        
        myThreadone=[[NSThread alloc]initWithTarget:self selector:@selector(GetSmsCode) object:nil];
        [myThreadone start];
        
        __block int timeout=59; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                   // [smsBut setTitle:@"获取验证码" forState:UIControlStateNormal];
                    labelBut.text = @"获取验证码";
                    smsBut.userInteractionEnabled = YES;
                    
                });
            }else{
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    //NSLog(@"____%@",strTime);
//                    labelBut.text=@"";
//                    [UIView beginAnimations:nil context:nil];
//                    [UIView setAnimationDuration:1];
//                    [smsBut setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
//                    [smsBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                    [UIView commitAnimations];
                    smsBut.userInteractionEnabled = NO;
                    labelBut.text=[NSString stringWithFormat:@"%@秒后重发",strTime];
                });
                
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }
    
}


-(void)regButtonAction:(id)sender{

        //添加参数
        NSDictionary *parameters=@{@"tel":userPhone.text,@"code":smsOder.text};
        NSString *telUrl = LogingUrl;
        NSString *strurlLogin=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],telUrl];
        
    
        //创建请求
        manager = [AFHTTPSessionManager manager];
        
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        //发送POST请求
        [manager POST:strurlLogin parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        } progress:^(NSProgress * _Nonnull uploadProgress) {
  
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@",responseObject);
        if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"succ"]) {
        
            user_id = [[responseObject objectAtIndex:0] valueForKey:@"user_id"];
            yunqi = [[responseObject objectAtIndex:0] valueForKey:@"yuchanqi"];
            jitai = [[responseObject objectAtIndex:0] valueForKey:@"jitai"];
            nickname = [[responseObject objectAtIndex:0] valueForKey:@"nickname"];
            sex = [[responseObject objectAtIndex:0] valueForKey:@"sex"];
            headimgurl = [[responseObject objectAtIndex:0] valueForKey:@"headimgurl"];
            
            
            [USER_DEFAULT setObject:[NSString stringWithFormat:@"%@",userPhone.text] forKey:@"UserName"];
            [USER_DEFAULT setObject:user_id forKey:@"user_id"];
            [USER_DEFAULT setObject:yunqi forKey:@"yunqi"];
            [USER_DEFAULT setObject:jitai forKey:@"jitai"];
            [USER_DEFAULT setObject:nickname forKey:@"nickname"];
            [USER_DEFAULT setObject:sex forKey:@"sex"];
            [USER_DEFAULT setObject:headimgurl forKey:@"headimgurl"];
            
            NSString *yuchanqi = [[responseObject objectAtIndex:0] valueForKey:@"yuchanqi"];
            if ([yuchanqi isEqualToString:@"0"]) {
                
                UserMesaageinfoController *userCon =[[UserMesaageinfoController alloc]init];
                [self.navigationController pushViewController:userCon animated:YES];
                return ;
            }
            
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                NSLog(@"关闭登陆窗口回调");
                //发送登陆成功通知
//                //注册通知
//                NSNotification *nsnotifcation = [NSNotification notificationWithName:@"LoginOrderJT" object:nil];
//                //发送通知
//                [[NSNotificationCenter defaultCenter] postNotification:nsnotifcation];
                
            }];
            
            
            
        }else{
         
            [self anminMessage:@"手机号或短信验证码错误"];
        }

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

-(void)closeConFunc{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void )GetSmsCode{
    
    
    
    NSDictionary *parameters=@{@"tel":userPhone.text};
    NSString *telUrl = TelCodeUrl;
    NSString *strurlLogin=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],telUrl];

    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    //发送POST请求
    
    [manager POST:strurlLogin parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject  %@",[[responseObject objectAtIndex:0] valueForKey:@"result"]);
        resultSMS = [[responseObject objectAtIndex:0] valueForKey:@"result"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

//动画
-(void)anminMessage:(NSString *)strInfo{
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(50, SIZE_HEIGHT-80, SIZE_WIDTH-100,30)];
    footView.backgroundColor=[UIColor blackColor];
    footView.layer.cornerRadius=8.0;
    UILabel *labelView=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, footView.frame.size.width, 20)];
    labelView.text=strInfo;
    labelView.backgroundColor=[UIColor clearColor];
    labelView.textAlignment=NSTextAlignmentCenter;
    labelView.font=[UIFont systemFontOfSize:14.0];
    labelView.textColor=[UIColor whiteColor];
    
    [footView addSubview:labelView];
    footView.alpha=0.0;
    
    [self.view addSubview:footView];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    footView.alpha=0.6;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    footView.alpha=0.0;
    [UIView commitAnimations];
    
    
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    
    [self.view endEditing:YES];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

//动画
-(void)anminView:(NSString *)strlabels{
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(50, SIZE_HEIGHT-80, SIZE_WIDTH-100,30)];
    footView.backgroundColor=[UIColor blackColor];
    footView.layer.cornerRadius=8.0;
    UILabel *labelView=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, footView.frame.size.width, 20)];
    labelView.text=strlabels;
    labelView.backgroundColor=[UIColor clearColor];
    labelView.textAlignment=NSTextAlignmentCenter;
    labelView.font=[UIFont systemFontOfSize:14.0];
    labelView.textColor=[UIColor whiteColor];
    
    [footView addSubview:labelView];
    footView.alpha=0.0;
    
    [self.view addSubview:footView];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    footView.alpha=0.6;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    footView.alpha=0.0;
    [UIView commitAnimations];
    
    
}

-(void)gotoUserInfo{

    UserMesaageinfoController *userCon =[[UserMesaageinfoController alloc]init];
    [self.navigationController pushViewController:userCon animated:YES];

}

@end

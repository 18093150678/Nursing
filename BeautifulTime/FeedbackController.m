//
//  FeedbackController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/12/12.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "FeedbackController.h"

@implementation FeedbackController

-(void)viewDidLoad{

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    
    UILabel *FeedTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    FeedTitleView.textColor = [UIColor blackColor];
    FeedTitleView.font = [UIFont systemFontOfSize:14.0];
    FeedTitleView.text = @"意见反馈";
    FeedTitleView.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = FeedTitleView;
    
    
    UIButton *FeedLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    FeedLeftBack.frame =CGRectMake(0, 0, 30, 30);
    [FeedLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    FeedLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [FeedLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    
    [FeedLeftBack addTarget:self action:@selector(FeedBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc]initWithCustomView:FeedLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftBarButton;
    
    
    UIButton *feedBackDelete = [UIButton buttonWithType:UIButtonTypeSystem];
    feedBackDelete.titleLabel.font = [UIFont systemFontOfSize:12.0];
    feedBackDelete.frame = CGRectMake(0, 0, 30, 30);
    [feedBackDelete setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    feedBackDelete.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [feedBackDelete setTitle:@"\U0000e60a" forState:UIControlStateNormal];
    [feedBackDelete addTarget:self action:@selector(feedtellConFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:feedBackDelete];
    
    self.navigationItem.rightBarButtonItem = RightButtonItem;
    


    [self feedControlerr];

}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    
    palaceLabel.text=@"";
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{

    NSLog(@"应编辑");
}

//将要结束/退出编辑模式
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{

    if(feedTextFile.text.length<=0){
    
        palaceLabel.text = @"请输入您要反馈的内容";
        
    }
    return YES;

}
#pragma mark -意见反馈控件
-(void)feedControlerr{

    
    feedTextFile = [[UITextView alloc]initWithFrame:CGRectMake(10, 80,SIZE_WIDTH-20 , 160)];
    [feedTextFile.layer setMasksToBounds:YES];
    [feedTextFile.layer setCornerRadius:5.0];
    feedTextFile.font = [UIFont systemFontOfSize:14.0];
    feedTextFile.backgroundColor = [UIColor whiteColor];
    feedTextFile.keyboardType = UIKeyboardTypeDefault;
    feedTextFile.returnKeyType =UIReturnKeyDone;
    feedTextFile.delegate=self;
    feedTextFile.textAlignment = NSTextAlignmentLeft;
    feedTextFile.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.8];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    palaceLabel = [[UILabel alloc]init];
    palaceLabel.text = @"请输入您要反馈的内容";
    palaceLabel.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.6];
    palaceLabel.frame = CGRectMake(5, (feedTextFile.frame.size.height-20)/2, feedTextFile.frame.size.width, 20);
    palaceLabel.font = [UIFont systemFontOfSize:12.0];
    
    [feedTextFile addSubview:palaceLabel];
    
    [self.view addSubview:feedTextFile];
    
    
    UIButton *FeedPlusBut = [UIButton buttonWithType:UIButtonTypeCustom];
    FeedPlusBut.frame = CGRectMake(20, 80+(feedTextFile.frame.size.height)+20+10, SIZE_WIDTH-40, 35);
    [FeedPlusBut.layer setMasksToBounds:YES];
    [FeedPlusBut.layer setCornerRadius:3.0];
    [FeedPlusBut setTitle:@" 提交 " forState:UIControlStateNormal];
    FeedPlusBut.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [FeedPlusBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [FeedPlusBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateNormal];
    [FeedPlusBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateHighlighted];
    [FeedPlusBut addTarget:self action:@selector(FeedPlusFuncinfo:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:FeedPlusBut];
    
    UITapGestureRecognizer *touchCloseKey = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchCloseFunc:)];
    [self.view addGestureRecognizer:touchCloseKey];

}

#pragma mark-意见反馈提交
-(void)FeedPlusFuncinfo:(id)sender{

    if (feedTextFile.text.length<=0) {
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请不要提交空内容！" preferredStyle:UIAlertControllerStyleAlert];
    
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
    }
    
    [self SubmitFeedFunc];
}


#pragma mark -提交意见反馈
-(void)SubmitFeedFunc{

    service_feedback_save
    
    //添加参数
    NSDictionary *feedparms=@{@"content":feedTextFile.text,@"user_id":[USER_DEFAULT objectForKey:@"UserName"]};
    NSString *changeAdressUrl = service_feedback_save;
    NSString *feedUrl=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],changeAdressUrl];

    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求
    
    
    [manager POST:feedUrl parameters:feedparms constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 
        if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"succ"]){
        
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"你提交的意见我们已经收到！感谢你的的建议" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }]];
            [self presentViewController:alertCon animated:YES completion:nil];
   
        }
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败%@",error);
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交失败了！请您检查下网络连接是否正常！" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        
    }];


}


#pragma -mark -关闭键盘
-(void)touchCloseFunc:(id)sender{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

-(void)FeedBackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -拨打电话方法
-(void)feedtellConFunc:(id)sender{
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    NSString *tel = [NSString stringWithFormat:@"tel:%@",[USER_DEFAULT valueForKey:@"phone"]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tel]]];

    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}


@end

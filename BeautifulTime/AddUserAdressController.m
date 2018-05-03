//
//  AddUserAdressController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/20.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "AddUserAdressController.h"

@interface AddUserAdressController ()

@end

@implementation AddUserAdressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    backGroundView.backgroundColor =[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:0.7];
    
    [self.view addSubview:backGroundView];
    
    UITapGestureRecognizer *touchCloseKey = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchCloseFunc:)];
    [backGroundView addGestureRecognizer:touchCloseKey];
    
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"添加地址";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *addLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addLeftBack.frame =CGRectMake(0, 0, 30, 30);
    addLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [addLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [addLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addLeftBack addTarget:self action:@selector(addBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:addLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    
    

    [self layoutControllerFunc];
    [self AddAdressSaveFunc];
    
}

#pragma mark -Controller布局设置
-(void)layoutControllerFunc{

    CGFloat L_height = 75.0;
    def = @"0";
    
    //姓名
    UIView *ReserveViw = [[UIView alloc]initWithFrame:CGRectMake(0,L_height, SIZE_WIDTH, 41)];
    ReserveViw.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *ReserveLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 20)];
    ReserveLabel.text = @"预约人:";
    ReserveLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
    ReserveLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [ReserveViw addSubview:ReserveLabel];
    
    
    ReserveProes = [[UITextField alloc]initWithFrame:CGRectMake(70, 10, SIZE_HEIGHT-85, 20)];
    //设置水印内容
    ReserveProes.placeholder = @"请输入预约人姓名";
    ReserveProes.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.7];
    ReserveProes.font = [UIFont fontWithName:@"Arial" size:14.0f];
    ReserveProes.textAlignment =NSTextAlignmentLeft;
    
    [ReserveViw addSubview:ReserveProes];
    
    
    UIView  *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SIZE_WIDTH, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:0.5];
    
    [ReserveViw addSubview:lineView];
    
    [backGroundView addSubview:ReserveViw];

    
    //手机号
    UIView *ReservetelViw = [[UIView alloc]initWithFrame:CGRectMake(0,ReserveViw.frame.size.height+L_height, SIZE_WIDTH, 41)];
    ReservetelViw.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *ReservetelLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 20)];
    ReservetelLabel.text = @"手机号:";
    ReservetelLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
    ReservetelLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [ReservetelViw addSubview:ReservetelLabel];
    
    
    ReservetelProes = [[UITextField alloc]initWithFrame:CGRectMake(70, 10, SIZE_HEIGHT-85, 20)];
    //设置水印内容
    ReservetelProes.placeholder = @"请输入手机号码";
    ReservetelProes.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.7];
    ReservetelProes.font = [UIFont fontWithName:@"Arial" size:14.0f];
    ReservetelProes.textAlignment =NSTextAlignmentLeft;
    ReservetelProes.keyboardType = UIKeyboardTypeNumberPad;
    [ReservetelViw addSubview:ReservetelProes];
    
    
    UIView  *linetelView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SIZE_WIDTH, 1)];
    linetelView.backgroundColor =[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:0.5];
    
    [ReservetelViw addSubview:linetelView];
    
    [backGroundView addSubview:ReservetelViw];

    
    
    //地址
    UIView *ReserveAddresViw = [[UIView alloc]initWithFrame:CGRectMake(0,ReservetelViw.frame.size.height*2+L_height, SIZE_WIDTH, 41)];
    ReserveAddresViw.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *ReserveAddresLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 20)];
    ReserveAddresLabel.text = @"地址:";
    ReserveAddresLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
    ReserveAddresLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [ReserveAddresViw addSubview:ReserveAddresLabel];
    
    
    ReserveAddresProes = [[UITextField alloc]initWithFrame:CGRectMake(70, 10, SIZE_HEIGHT-85, 20)];
    //设置水印内容
    ReserveAddresProes.placeholder = @"请输入地址";
    ReserveAddresProes.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.7];
    ReserveAddresProes.font = [UIFont fontWithName:@"Arial" size:14.0f];
    ReserveAddresProes.textAlignment =NSTextAlignmentLeft;
    ReserveAddresProes.keyboardType = UIReturnKeyDone;
    
    [ReserveAddresViw addSubview:ReserveAddresProes];
    
    
    UIView  *lineAddresView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SIZE_WIDTH, 1)];
    lineAddresView.backgroundColor =[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:0.5];
    
    [ReserveAddresViw addSubview:lineAddresView];
    
    [backGroundView addSubview:ReserveAddresViw];
    
    
    //默认
    UIView *ReservedefaultViw = [[UIView alloc]initWithFrame:CGRectMake(0,ReserveAddresViw.frame.size.height*3+L_height, SIZE_WIDTH, 41)];
    ReservedefaultViw.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *ReservedefaultLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,120, 20)];
    ReservedefaultLabel.text = @"设为默认地址";
    ReservedefaultLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
    ReservedefaultLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [ReservedefaultViw addSubview:ReservedefaultLabel];
    
    
    UIView  *linedefaultView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SIZE_WIDTH, 1)];
    linedefaultView.backgroundColor =[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:0.5];
    
    [ReservedefaultViw addSubview:linedefaultView];
    
    
    UISwitch *openSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(SIZE_WIDTH-60, 5, 40, 20)];
    // 控件大小，不能设置frame，只能用缩放比例
    openSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [openSwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
    
    [ReservedefaultViw addSubview:openSwitch];
    
    [backGroundView addSubview:ReservedefaultViw];


}

#pragma mark -开关按钮事件
-(void)switchValueChange:(id)sender{


    UISwitch *defultSwitch = (UISwitch *)sender;
    
    if (defultSwitch.on == NO ) {
        
        NSLog(@"不设置为默认");
        def = @"0";
        
    }else{
    
        def = @"1";
        NSLog(@"设置为默认");
    
    }

}

#pragma mark -返回按钮
-(void)addBackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -添加新地址按钮
-(void)AddAdressSaveFunc{
    
    UIButton *_AddressBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _AddressBut.frame = CGRectMake(0, SIZE_HEIGHT-40, SIZE_WIDTH, 40);
    _AddressBut.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_AddressBut setTitle:@" 保存新地址 " forState:UIControlStateNormal];
    [_AddressBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_AddressBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateNormal];
    [_AddressBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateHighlighted];
    [_AddressBut addTarget:self action:@selector(UserAddAdressSaveFuncsss:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_AddressBut];
    
}

-(void)UserAddAdressSaveFuncsss:(id)sender{

   
    
    
    if ([ReserveProes.text isEqualToString:@""]) {
        
        
      UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写预约人!" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
                      
        }]];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
        
    }

    if ([ReservetelProes.text isEqualToString:@""]) {
        
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写预约人手机号!" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
        
    }

    if ([ReserveAddresProes.text isEqualToString:@""]) {
        
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写预约人地址!" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
        
    }

    
    [self saveAdress];
    
    
   
    
    
}

#pragma mark -发送保存地址请求
-(void)saveAdress{

    //添加参数
    NSDictionary *parameters=@{@"user_id":[USER_DEFAULT objectForKey:@"user_id"],@"user_name":ReserveProes.text,@"mobile":ReservetelProes.text,@"address":ReserveAddresProes.text,@"def":def};
    NSString *saveAdressUrl = service_address_save;
    NSString *strurlLogin=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],saveAdressUrl];
    
    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求  
    
    
    [manager POST:strurlLogin parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject%@",responseObject);
    
        if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"succ"]) {
            
            [self.navigationController  popViewControllerAnimated:YES];
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败%@",error);
        
    }];

}


#pragma -mark -关闭键盘
-(void)touchCloseFunc:(id)sender{

     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

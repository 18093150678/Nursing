//
//  ChangeAddressController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/22.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "ChangeAddressController.h"

@interface ChangeAddressController ()

@end

@implementation ChangeAddressController

@synthesize addressArrayDict;

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    changebackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    changebackGroundView.backgroundColor =[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:0.7];
    
    [self.view addSubview:changebackGroundView];
    
    UITapGestureRecognizer *touchCloseKey = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchCloseFunc:)];
    [changebackGroundView addGestureRecognizer:touchCloseKey];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"修改地址";
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *LeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LeftBack.frame =CGRectMake(0, 0, 30, 30);
    LeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [LeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [LeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [LeftBack addTarget:self action:@selector(BackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:LeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    
    
    
    
    NSLog(@"addressArrayDict ---%@",addressArrayDict);
    
    [self layoutControllerFunc];
    [self AddAdressSaveFunc];
    
}

#pragma mark -Controller布局设置
-(void)layoutControllerFunc{
    
    CGFloat L_height = 75.0;
    def = [addressArrayDict valueForKey:@"def"];
    
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
   // ReserveProes.placeholder = @"请输入预约人姓名";
    ReserveProes.text = [addressArrayDict valueForKey:@"user_name"];
    ReserveProes.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.7];
    ReserveProes.font = [UIFont fontWithName:@"Arial" size:14.0f];
    ReserveProes.textAlignment =NSTextAlignmentLeft;
    
    [ReserveViw addSubview:ReserveProes];
    
    
    UIView  *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SIZE_WIDTH, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:0.5];
    
    [ReserveViw addSubview:lineView];
    
    [changebackGroundView addSubview:ReserveViw];
    
    
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
    //ReservetelProes.placeholder = @"请输入手机号码";
    ReservetelProes.text = [addressArrayDict valueForKey:@"mobile"];
    ReservetelProes.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.7];
    ReservetelProes.font = [UIFont fontWithName:@"Arial" size:14.0f];
    ReservetelProes.textAlignment =NSTextAlignmentLeft;
    ReservetelProes.keyboardType = UIKeyboardTypeDefault;
    [ReservetelViw addSubview:ReservetelProes];
    
    
    UIView  *linetelView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SIZE_WIDTH, 1)];
    linetelView.backgroundColor =[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:0.5];
    
    [ReservetelViw addSubview:linetelView];
    
    [changebackGroundView addSubview:ReservetelViw];
    
    
    
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
  //  ReserveAddresProes.placeholder = @"请输入地址";
    ReserveAddresProes.text  = [addressArrayDict valueForKey:@"address"];
    ReserveAddresProes.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.7];
    ReserveAddresProes.font = [UIFont fontWithName:@"Arial" size:14.0f];
    ReserveAddresProes.textAlignment =NSTextAlignmentLeft;
    
    [ReserveAddresViw addSubview:ReserveAddresProes];
    
    
    UIView  *lineAddresView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SIZE_WIDTH, 1)];
    lineAddresView.backgroundColor =[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:0.5];
    
    [ReserveAddresViw addSubview:lineAddresView];
    
    [changebackGroundView addSubview:ReserveAddresViw];
    
    
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
    
    
    UISwitch *openSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(SIZE_WIDTH-60, 5, 50, 30)];
    
    NSString *defs = [NSString stringWithFormat:@"%@",[addressArrayDict valueForKey:@"def"]];
    
    if ([defs isEqualToString:@"1"]) {
   
        openSwitch.on = YES;
    
    }else{
    
        openSwitch.on = NO;
    }
    
    // 控件大小，不能设置frame，只能用缩放比例
    openSwitch.transform = CGAffineTransformMakeScale(0.85, 0.85);
    [openSwitch addTarget:self action:@selector(AddressMFunc:) forControlEvents:UIControlEventValueChanged];
    
    [ReservedefaultViw addSubview:openSwitch];
    
    [changebackGroundView addSubview:ReservedefaultViw];
    
    
}

#pragma mark -开关按钮事件
-(void)AddressMFunc:(id)sender{
    
    
    UISwitch *defultSwitch = (UISwitch *)sender;
    
    if (defultSwitch.on == NO ) {
        
        NSLog(@"不设置为默认");
        def = @"0";
        
    }else{
        
        def = @"1";
        NSLog(@"设置为默认%@",def);
        
    }
    
}

#pragma mark -返回按钮
-(void)BackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -添加新地址按钮
-(void)AddAdressSaveFunc{
    
    UIButton *_OrderBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _OrderBut.frame = CGRectMake(0, SIZE_HEIGHT-40, SIZE_WIDTH, 40);
    _OrderBut.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_OrderBut setTitle:@" 修改地址 " forState:UIControlStateNormal];
    [_OrderBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_OrderBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateNormal];
    [_OrderBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateHighlighted];
    [_OrderBut addTarget:self action:@selector(UserAddAdressSaveFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_OrderBut];
    
}

-(void)UserAddAdressSaveFunc:(id)sender{
    


    
    
    [self saveAdress];
    
    
    
   // [self.navigationController  popViewControllerAnimated:YES];
    
}

#pragma mark -发送修改收货地址 请求
-(void)saveAdress{
    
    //添加参数
    NSDictionary *parameters=@{@"id":[addressArrayDict valueForKey:@"id"],@"user_id":[USER_DEFAULT objectForKey:@"user_id"],@"user_name":ReserveProes.text,@"mobile":ReservetelProes.text,@"address":ReserveAddresProes.text,@"def":def};
    NSString *changeAdressUrl = service_address_edit;
    NSString *strurlchange=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],changeAdressUrl];
    NSLog(@"parameters%@",parameters);
    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求
    
    [manager POST:strurlchange parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        
        if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"succ"]) {

           alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"地址修改成功,点击确定返回!" preferredStyle:UIAlertControllerStyleAlert];
            
            
            [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
   
               [self.navigationController  popViewControllerAnimated:YES];
                
                
            }]];

            [self presentViewController:alertCon animated:YES completion:nil];
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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

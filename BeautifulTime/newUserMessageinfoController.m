//
//  newUserMessageinfoController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/10.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "newUserMessageinfoController.h"
@interface newUserMessageinfoController (){
    
    int  sexStatus;
}

@end

@implementation newUserMessageinfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor=[UIColor colorWithRed:255/255.0 green:125/255.0 blue:125/255.0 alpha:1.0];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self contentView];
}


-(void)contentView{
    
    view=[[UIView alloc]initWithFrame:CGRectMake(0,30, SIZE_WIDTH, SIZE_HEIGHT-90)];
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(20, 0,SIZE_WIDTH-40, 30)];
    ConTitleView.textColor = [UIColor whiteColor];
    ConTitleView.text = @"请选择你的身份并完善信息";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:20.0]];
    
    [view addSubview:ConTitleView];
    
    
    UITapGestureRecognizer *tapwonman = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectSexFunc:)];
    
    imageViewWonMan=[[UIImageView alloc]initWithFrame:CGRectMake((SIZE_WIDTH/2-90)/2, 30, 90, 90)];
    imageViewWonMan.userInteractionEnabled=YES;
    imageViewWonMan.tag=1;
    imageViewWonMan.image=[UIImage imageNamed:@"female.png"];
    
    imageViewWonMan.layer.cornerRadius = imageViewWonMan.frame.size.width / 2;
    imageViewWonMan.layer.masksToBounds = YES;
    
    if ([[USER_DEFAULT valueForKey:@"sex"] isEqualToString:@"0"]) {
        sexStatus=0;
        imageViewWonMan.layer.borderColor = [[UIColor whiteColor]CGColor];
        imageViewWonMan.layer.borderWidth =4;
    }

    
    
    tapwonman.view.tag = imageViewWonMan.tag;
    [imageViewWonMan addGestureRecognizer:tapwonman];
    
    [view addSubview:imageViewWonMan];
    
    UITapGestureRecognizer *tapman = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectSexFunc:)];
    
    imageViewMan=[[UIImageView alloc]initWithFrame:CGRectMake(SIZE_WIDTH/2+((SIZE_WIDTH/2-90)/2), 30, 90, 90)];
    imageViewMan.userInteractionEnabled=YES;
    imageViewMan.tag=2;
    imageViewMan.image=[UIImage imageNamed:@"male.png"];
    imageViewMan.layer.cornerRadius = imageViewWonMan.frame.size.width / 2;
    imageViewMan.layer.masksToBounds = YES;
    
    if ([[USER_DEFAULT valueForKey:@"sex"] isEqualToString:@"1"]) {
        sexStatus=1;
        imageViewMan.layer.borderColor = [[UIColor whiteColor]CGColor];
        imageViewMan.layer.borderWidth =4;
    }
    

    
    tapman.view.tag = imageViewMan.tag;
    [imageViewMan addGestureRecognizer:tapman];
    
    [view addSubview:imageViewMan];
    
    
    UILabel *demaleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 120, SIZE_WIDTH/2, 30)];
    demaleLable.textColor = [UIColor whiteColor];
    demaleLable.textAlignment=NSTextAlignmentCenter;
    demaleLable.font=[UIFont systemFontOfSize:14.0];
    demaleLable.text = @"宝妈/准妈";
    [view addSubview:demaleLable];
    
//    [USER_DEFAULT setObject:yunqi forKey:@"yunqi"];
//    [USER_DEFAULT setObject:jitai forKey:@"jitai"];
//    [USER_DEFAULT setObject:nickname forKey:@"nickname"];
//    [USER_DEFAULT setObject:sex forKey:@"sex"];
    
    UILabel *maleLable=[[UILabel alloc]initWithFrame:CGRectMake(SIZE_WIDTH/2, 120, SIZE_WIDTH/2, 30)];
    maleLable.textColor = [UIColor whiteColor];
    maleLable.textAlignment=NSTextAlignmentCenter;
    maleLable.font=[UIFont systemFontOfSize:14.0];
    maleLable.text = @"宝爸/准爸";
    [view addSubview:maleLable];
    
    UIView *userNameView= [[UIView alloc]initWithFrame:CGRectMake(30,150, SIZE_WIDTH-60, 40)];
    userNameView.layer.cornerRadius = 20;
    userNameView.layer.masksToBounds = true;
    userNameView.layer.borderColor = [[UIColor whiteColor]CGColor];
    userNameView.layer.borderWidth = 1;


    userNameField=[[UITextField alloc]initWithFrame:CGRectMake(10,0, userNameView.frame.size.width-20, 40)];
    userNameField.placeholder = @"请输入你的昵称";
    userNameField.font = [UIFont systemFontOfSize:12.0];
    userNameField.delegate=self;
    userNameField.text =  [USER_DEFAULT valueForKey:@"nickname"];
    [userNameField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [userNameField setValue:[UIFont systemFontOfSize:12.0] forKeyPath:@"_placeholderLabel.font"];
    userNameField.textColor = [UIColor whiteColor];
    
    [userNameView addSubview:userNameField];
    [view addSubview:userNameView];
    
    
    UIView *userExpectedView= [[UIView alloc]initWithFrame:CGRectMake(30,200, SIZE_WIDTH-60, 40)];
    userExpectedView.layer.cornerRadius = 20;
    userExpectedView.layer.masksToBounds = true;
    userExpectedView.layer.borderColor = [[UIColor whiteColor]CGColor];
    userExpectedView.layer.borderWidth = 1;
    
    userExpected=[[UITextField alloc]initWithFrame:CGRectMake(10,0, SIZE_WIDTH-20, 40)];
    userExpected.placeholder = @"请选择预产期";
    userExpected.delegate=self;
    userExpected.text = [USER_DEFAULT valueForKey:@"yunqi"];
    [userExpected setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [userExpected setValue:[UIFont systemFontOfSize:12.0] forKeyPath:@"_placeholderLabel.font"];
    userExpected.textColor = [UIColor whiteColor];
    userExpected.font = [UIFont systemFontOfSize:12.0];
    userExpected.clearButtonMode = UITextFieldViewModeAlways;
    userExpected.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [userExpectedView addSubview:userExpected];
    [view addSubview:userExpectedView];
    
    UIView *numSelectView = [[UIView alloc]initWithFrame:CGRectMake(30, 250, SIZE_WIDTH-60, 40)];
    
    oneBut = [[UIButton alloc]initWithFrame:CGRectMake(5, 0, numSelectView.frame.size.width/2-10, 40)];
    
    oneBut.alpha=0.6;
    [oneBut setTitle:@"一胎" forState:UIControlStateNormal];
    [oneBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    oneBut.titleLabel.font=[UIFont systemFontOfSize:14.0];
    oneBut.layer.cornerRadius = 20;
    oneBut.layer.masksToBounds = true;
    oneBut.layer.borderColor = [[UIColor whiteColor]CGColor];
    oneBut.layer.borderWidth = 1;
    if ([[USER_DEFAULT valueForKey:@"jitai"] isEqualToString:@"0"]) {
        
        oneBut.backgroundColor = [UIColor whiteColor];
        oneBut.alpha =0.8;
        [oneBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        towBut.backgroundColor = [UIColor clearColor];
        [towBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        intstatus=1;
    }

    oneBut.tag=1;
    [oneBut addTarget:self action:@selector(newselectFunc:) forControlEvents:UIControlEventTouchUpInside];
    [numSelectView addSubview:oneBut];
    
    towBut = [[UIButton alloc]initWithFrame:CGRectMake(numSelectView.frame.size.width/2+5, 0, numSelectView.frame.size.width/2-10, 40)];
    
    [towBut setTitle:@"二胎" forState:UIControlStateNormal];
    [towBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    towBut.titleLabel.font=[UIFont systemFontOfSize:14.0];
    towBut.layer.cornerRadius = 20;
    towBut.layer.masksToBounds = true;
    towBut.layer.borderColor = [[UIColor whiteColor]CGColor];
    towBut.layer.borderWidth = 1;

    
    if ([[USER_DEFAULT valueForKey:@"numtai"] isEqualToString:@"1"]) {
        
        towBut.backgroundColor = [UIColor whiteColor];
        towBut.alpha =0.8;
        [towBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        oneBut.backgroundColor = [UIColor clearColor];
        [oneBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        intstatus=2;

    }

  
    towBut.tag=2;
    [towBut addTarget:self action:@selector(newselectFunc:) forControlEvents:UIControlEventTouchUpInside];
    [numSelectView addSubview:towBut];
    
    [view addSubview:numSelectView];
    
    UIButton *saveBut=[[UIButton alloc]initWithFrame:CGRectMake(30,320, SIZE_WIDTH-60, 40)];
    saveBut.userInteractionEnabled=YES;
    [saveBut setTitle:@" 保 存 " forState:UIControlStateNormal];
    [saveBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBut addTarget:self action:@selector(saveFunc:) forControlEvents:UIControlEventTouchUpInside];
    saveBut.layer.cornerRadius = 20;
    saveBut.layer.masksToBounds = true;
    saveBut.layer.borderColor = [[UIColor whiteColor]CGColor];
    saveBut.layer.borderWidth = 1;
    [view addSubview:saveBut];
    
    
    UIButton *OutBut=[[UIButton alloc]initWithFrame:CGRectMake(120,375, SIZE_WIDTH-240, 40)];
    [OutBut setBackgroundColor:[UIColor clearColor]];
    OutBut.userInteractionEnabled=YES;
    [OutBut setTitle:@" 以后在说 " forState:UIControlStateNormal];
    [OutBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [OutBut addTarget:self action:@selector(OutButFunc:) forControlEvents:UIControlEventTouchUpInside];
    OutBut.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [view addSubview:OutBut];
    
    
    [self.view addSubview:view];
    
    [self setupDateKeyPan];
    
    UITapGestureRecognizer *touchCloseKey = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(usermesstouchCloseFunc:)];
    [self.view addGestureRecognizer:touchCloseKey];
    
}

//选择事件
-(void)newselectFunc:(id)sender{
    
    
    UIButton *statusBut = (UIButton *)sender;
    
    if (statusBut.tag==1) {
        
        oneBut.backgroundColor = [UIColor whiteColor];
        oneBut.alpha =0.8;
        [oneBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        towBut.backgroundColor = [UIColor clearColor];
        [towBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        intstatus=1;
        
    }else{
        
        towBut.backgroundColor = [UIColor whiteColor];
        towBut.alpha =0.8;
        [towBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        oneBut.backgroundColor = [UIColor clearColor];
        [oneBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        intstatus=2;
        
    }
    
    
}

-(void)selectSexFunc:(id)sender{
    
    UITapGestureRecognizer *tap=(UITapGestureRecognizer *)sender;
    NSInteger tapindex=tap.view.tag;
    NSLog(@"------image-----%ld",(long)tapindex);
    
    if (tapindex==1) {
        
        sexStatus=0;
        imageViewWonMan.layer.borderColor = [[UIColor whiteColor]CGColor];
        imageViewWonMan.layer.borderWidth =4;
        
        imageViewMan.layer.borderColor = [[UIColor whiteColor]CGColor];
        imageViewMan.layer.borderWidth =0;
        
    }else{
        
        sexStatus=1;
        imageViewMan.layer.borderColor = [[UIColor whiteColor]CGColor];
        imageViewMan.layer.borderWidth =4;
        
        imageViewWonMan.layer.borderColor = [[UIColor whiteColor]CGColor];
        imageViewWonMan.layer.borderWidth =0;
        
    }
    
}


-(void)saveFunc:(id)sender{
    
    NSLog(@"--------save-------");
    if(sexStatus==2){
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择您是宝妈还是宝爸" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
    }
    
    [self savegButtonActions];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

#pragma -mark -关闭键盘
-(void)usermesstouchCloseFunc:(id)sender{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//
//    NSLog(@"---s---");
//  //  view.frame=CGRectMake(0, 80, SIZE_WIDTH, SIZE_HEIGHT);
//    CGRect frame = textField.frame;
//
//    CGFloat heights = view.frame.size.height;
//
//    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
//
//    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
//
//    int offset = frame.origin.y + 42- ( heights - 216.0-35.0);//键盘高度216
//
//    NSTimeInterval animationDuration = 0.30f;
//
//    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
//
//    [UIView setAnimationDuration:animationDuration];
//
//    float width = view.frame.size.width;
//
//    float height = view.frame.size.height;
//
//    if(offset > 0)
//
//    {
//
//        CGRect rect = CGRectMake(0.0f, -offset,width,height);
//
//        view.frame = rect;
//
//    }
//
//    [UIView commitAnimations];
//

//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    NSLog(@"touchesBegan");
    
    [view endEditing:YES];
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0,30, SIZE_WIDTH, SIZE_HEIGHT-90);
    
    view.frame = rect;
    
    [UIView commitAnimations];
    
}

//返回方法
//-(void)userLoginInfoFunc:(id)sender{
//
//    [self.navigationController popViewControllerAnimated:YES];
//
//}

-(void)savegButtonActions{
    
    //添加参数 sexStatus 昵称 userNameField  孕期 userExpected 用户id [USER_DEFAULT objectForKey:@"user_id"] 几胎 intstatus
    
    NSString *strSex = [NSString stringWithFormat:@"%ld",(long)sexStatus];
    NSString *strintstatus = [NSString stringWithFormat:@"%ld",(long)intstatus];
    NSDictionary *parameters=@{@"tel":[USER_DEFAULT objectForKey:@"user_id"],@"nickname":userNameField.text,@"sex":strSex,@"yuchanqi":userExpected.text,@"jitai":strintstatus};
    NSString *telUrl = ios_edit_userinfo;
    NSString *strurlLogin=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],telUrl];
    
    [USER_DEFAULT setObject:userExpected.text forKey:@"yunqi"];
    [USER_DEFAULT setObject:strintstatus forKey:@"numtai"];
    [USER_DEFAULT setObject:userNameField.text forKey:@"nicheng"];
    [USER_DEFAULT setObject:strSex forKey:@"sex"];
    
    NSLog(@"strurlLogin-----%@",parameters);
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
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                NSLog(@"关闭登陆窗口回调");
                //发送登陆成功通知
                //                //注册通知
                //                NSNotification *nsnotifcation = [NSNotification notificationWithName:@"LoginOrderJT" object:nil];
                //                //发送通知
                //                [[NSNotificationCenter defaultCenter] postNotification:nsnotifcation];
                
            }];
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

-(void)OutButFunc:(id)sender{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"关闭登陆窗口回调");
        //发送登陆成功通知
        //                //注册通知
        //                NSNotification *nsnotifcation = [NSNotification notificationWithName:@"LoginOrderJT" object:nil];
        //                //发送通知
        //                [[NSNotificationCenter defaultCenter] postNotification:nsnotifcation];
        
    }];
}



-(void)setupDateKeyPan {
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    //设置地区: zh-中国
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    //设置日期模式(Displays month, day, and year depending on the locale setting)
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    //监听DataPicker的滚动
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    self.datePicker = datePicker;
    
    //设置时间输入框的键盘框样式为时间选择器
    userExpected.inputView = datePicker;
}

//became first responder(已经成为第一响应者的时候调用), 目的是为了弹出键盘, TF默认显示当前日期
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==userExpected) {
        // userExpected.inputView=self.datePicker;
        [self dateChange:_datePicker];
    }
    
    
}


//禁止用户输入文字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField==userExpected) {
        // userExpected.inputView=self.datePicker;
        return NO;
    }
    
    return YES;
}


-(void)dateChange:(id)sender
{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str=[outputFormatter stringFromDate:self.datePicker.date];
    userExpected.text=str;
    
    NSLog(@"%@",self.datePicker.date);
    NSLog(@"%@",str);
}

@end

//
//  UserInfoController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//


#import "UserInfoController.h"
#import "AppointmentController.h"
#import "ReportController.h"
#import "IntegralController.h"
#import "MysaveController.h"
#import "CollectionTowController.h"
#import "newUserMessageinfoController.h"

@interface UserInfoController ()

@end

@implementation UserInfoController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    backgroundView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
    [self.view addSubview:backgroundView];
    
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"个人中心";
    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    UIButton *RightBackUser = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBackUser.titleLabel.font = [UIFont systemFontOfSize:12.0];
    RightBackUser.frame = CGRectMake(0, 0, 30, 30);
    [RightBackUser setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    RightBackUser.titleLabel.font = [UIFont fontWithName:@"iconfont" size:18];
    [RightBackUser setTitle:@"\U0000e600" forState:UIControlStateNormal];
    [RightBackUser addTarget:self action:@selector(UseriinfoConFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBackUser];
    
    self.navigationItem.rightBarButtonItem = RightButtonItem;
    

    [self TableViewFunc];
    [self GetArrayDataFunc];

}

-(void)viewWillAppear:(BOOL)animated{
    
    userNameFix =[NSString stringWithFormat:@"%@",[USER_DEFAULT objectForKey:@"UserName"]];
    
    if ([USER_DEFAULT objectForKey:@"UserName"] !=NULL) {
        
        
        [self GetHttpyunqiDataFunManager];
        [self GetHttpuserInfoDataFunManager];
        
    }

    [self.TableViews reloadData];
    

}



-(void)TableViewFunc{
    
    [backgroundView addSubview:self.TableViews];
    
    [self geturlimagelogo];

}

-(UITableView *)TableViews{
    
    NSLog(@"懒加载_tableHeaderView");
    
    if (!_TableViews) {
        
        _TableViews = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SIZE_WIDTH,SIZE_HEIGHT-49) style:UITableViewStylePlain];
        _TableViews.delegate = self;
        _TableViews.dataSource = self;
        // TableView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
        _TableViews.showsVerticalScrollIndicator = NO;
        [_TableViews setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                      green:145/255.0
                                                       blue:145/255.0
                                                      alpha:0.2]];
        
        _TableViews.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _TableViews.scrollEnabled = YES;

        
    }
    
    return _TableViews;

   
}

#pragma mark 一共有多少组（section == 区域\组）
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

#pragma mark -每一组有多少cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return  userInfoArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    static NSString *IdentifierCell = @"userTabelInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IdentifierCell];
    }
    
    //点击的选择样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    while ([cell.contentView.subviews lastObject] != nil)
    {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    
    if (indexPath.row==0) {
        
        loginImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg.jpg"]];
        loginImageView.userInteractionEnabled = YES;
        
        // 图片自适应填充
        loginImageView.contentMode = UIViewContentModeTop;
        loginImageView.clipsToBounds=YES;
        
        loginImageView.frame = CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT*0.31);
        
        //定义登陆用户头像的位置
        //图片大小
        
        CGFloat imageSzie  = 110;
        
        //距左位置
        CGFloat image_left = loginImageView.bounds.size.width/2 -(imageSzie/2);
        CGFloat image_height = loginImageView.bounds.size.height/2-(imageSzie/2+30);
        
        jifenLabel=[[UILabel alloc]init];
        jifenLabel.frame=CGRectMake(image_left,image_height+imageSzie, SIZE_WIDTH-80+imageSzie+10, 30);
        
        headerImagelogo=[[UIImageView alloc]init];
        //user_id
        if ([USER_DEFAULT objectForKey:@"user_id"] == NULL) {
            
            headerImagelogo.frame = CGRectMake(image_left,image_height,imageSzie, imageSzie);
            
            headerImagelogo.image=[UIImage imageNamed:@"userinfo_logo.png"];
            userName = [[UILabel alloc]initWithFrame:CGRectMake(0,image_height+imageSzie, SIZE_WIDTH, 30)];
            userName.textColor = [UIColor whiteColor];
            userName.text = @"您还未登陆";
            userName.font = [UIFont systemFontOfSize:14.0];
            userName.textAlignment = NSTextAlignmentCenter;
            [loginImageView addSubview:userName];
            
            UIButton *loginBut = [[UIButton alloc]initWithFrame:CGRectMake((SIZE_WIDTH-110)/2,image_height+imageSzie+30, 110, 30)];
            [loginBut setTitle:@"点击登陆" forState:UIControlStateNormal];
            loginBut.titleLabel.font = [UIFont systemFontOfSize:14.0];
            loginBut.layer.cornerRadius = 10;
            loginBut.layer.masksToBounds = true;
            loginBut.layer.borderColor = [[UIColor whiteColor]CGColor];
            loginBut.layer.borderWidth = 1;
            [loginBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [loginBut addTarget:self action:@selector(Actiondo:) forControlEvents:UIControlEventTouchUpInside];
            
            [loginImageView addSubview:loginBut];
            
        }else{
            
            
            if ([USER_DEFAULT objectForKey:@"headimgurl"] == NULL) {

                
                if([[USER_DEFAULT objectForKey:@"userLogo"] isEqualToString:@"YES"]){
                    
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *docDir = [paths objectAtIndex:0];
                    NSString *StrUserLogoImage = [NSString stringWithFormat:@"%@/%@",docDir,@"userLogo.png"];
                    
                    UIImage *sassveimage = [[UIImage alloc]initWithContentsOfFile:StrUserLogoImage];
                    headerImagelogo.frame = CGRectMake(image_left,image_height,imageSzie, imageSzie);
                    
                    headerImagelogo.image = sassveimage;
                    headerImagelogo.layer.cornerRadius = headerImagelogo.frame.size.width/2;
                    headerImagelogo.layer.masksToBounds = true;
                    headerImagelogo.layer.borderColor = [[UIColor whiteColor]CGColor];
                    headerImagelogo.layer.borderWidth = 2 ;
                    
                }else{
                    
                    headerImagelogo.image=[UIImage imageNamed:@"userinfo_logoYes.png"];
                    
                }

            }else{

                
                NSString *urlStr = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],[USER_DEFAULT objectForKey:@"headimgurl"]];
                
                AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(image_left,image_height,imageSzie, imageSzie)];
                asynImageView.placeholderImage=[UIImage imageNamed:@"userinfo_logoYes.png"];
                asynImageView.imageURL = [NSString stringWithFormat:@"%@",urlStr];
    
                headerImagelogo=asynImageView;
                headerImagelogo.layer.cornerRadius = headerImagelogo.frame.size.width/2;
                headerImagelogo.layer.masksToBounds = true;
                headerImagelogo.layer.borderColor = [[UIColor whiteColor]CGColor];
                headerImagelogo.layer.borderWidth = 2 ;
                
            }
            
            NSString *username = @"";
            if([USER_DEFAULT objectForKey:@"nickname"] == NULL ){
            
                username = [USER_DEFAULT objectForKey:@"UserName"];
                NSString *out_4 = [username substringToIndex:4];
                NSString *out_3 = [username substringToIndex:8];
                username = [NSString stringWithFormat:@"%@****%@",out_4,out_3];
            
            }else{
            
                username = [USER_DEFAULT objectForKey:@"nickname"];
            
            }
            
            userName = [[UILabel alloc]initWithFrame:CGRectMake(0,image_height+imageSzie+10, SIZE_WIDTH, 30)];
            userName.textColor = [UIColor whiteColor];
            userName.textAlignment = NSTextAlignmentCenter;
            userName.text = [NSString stringWithFormat:@"欢迎您:%@",username];
            [userName setFont:[UIFont systemFontOfSize:14.0]];
            [loginImageView addSubview:userName];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userInfoChangeFunc:)];
            [headerImagelogo addGestureRecognizer:tapGesture];
            
        }
        
        headerImagelogo.userInteractionEnabled = YES;
        [loginImageView addSubview:headerImagelogo];
 
        [cell.contentView addSubview:loginImageView];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        
    }else if (indexPath.row ==1 || indexPath.row == 10) {
        
        UIView *NullCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 15)];
        NullCellView.backgroundColor =[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
        
        [cell.contentView addSubview:NullCellView];
        
    }else if (indexPath.row==2){
        
        NSString *cell_name = userInfoArray[indexPath.row];
        
        UIImageView *imageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 20, 20)];
        NSString *imageName = [NSString stringWithFormat:@"ico_%ld.png",(long)indexPath.row];
        imageLogo.image = [UIImage imageNamed:imageName];
        
        [cell.contentView addSubview:imageLogo];
        
        UILabel *NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, SIZE_WIDTH/3, 20)];
        NameLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
        NameLabel.text  = cell_name;
        NameLabel.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:NameLabel];
     
        YunqiName = [[UILabel alloc]initWithFrame:CGRectMake(SIZE_WIDTH/3+100, 10, SIZE_WIDTH-(SIZE_WIDTH/3+100)-35, 20)];
        YunqiName.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
        YunqiName.font = [UIFont systemFontOfSize:12.0];
        YunqiName.textAlignment = NSTextAlignmentRight;
        YunqiName.text = yunqi;
        [cell.contentView addSubview:YunqiName];
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    }else{

    NSString *cell_name = userInfoArray[indexPath.row];

    UIImageView *imageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11,20,20)];
    NSString *imageName = [NSString stringWithFormat:@"ico_%ld.png",(long)indexPath.row];
    imageLogo.image = [UIImage imageNamed:imageName];
    
    [cell.contentView addSubview:imageLogo];
    
    UILabel *NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, SIZE_WIDTH/3, 20)];
    NameLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
    NameLabel.text  = cell_name;
    NameLabel.font = [UIFont systemFontOfSize:14.0];
    
    [cell.contentView addSubview:NameLabel];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    }
    
    return cell;
}


#pragma mark -选择事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     UIAlertController *AlertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登陆吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    UserAddressController *userAddresCon = [[UserAddressController alloc]init];
//    MoreController *MoreCon = [[MoreController alloc]init];
    myorderCon = [[MyorderController alloc]init];
    FeedbackController *feedCon = [[FeedbackController alloc]init];
    DeleteController *deleteCon = [[DeleteController alloc]init];
    AppointmentController *Appointment=nil;
    ReportController *RepCon = nil;
    IntegralController *IntegralCon = nil;
    MysaveController *mysaveCon= [[MysaveController alloc]init];
    CollectionTowController *woshiyunmaCon=[[CollectionTowController alloc]init];
    NSString *urlyq=nil;
    if (indexPath.row == 1 || indexPath.row == 10) {
        
        return;
    }
    
    if ([USER_DEFAULT objectForKey:@"user_id"] != NULL) {
        
        switch (indexPath.row) {
            
            case 2:
                NSLog(@"---2----");
                woshiyunmaCon = [[CollectionTowController alloc]init];
                woshiyunmaCon.hidesBottomBarWhenPushed=YES;
                woshiyunmaCon.titleName = @"我是孕妈";
                urlyq= [NSString stringWithFormat:@"mycenter/remind.htm?user_id=%@&ios=1",[USER_DEFAULT objectForKey:@"user_id"]];
                woshiyunmaCon.WebUrl = urlyq;
                [self.navigationController pushViewController:woshiyunmaCon animated:YES];
                break;
                
            case 3:
                
                IntegralCon = [[IntegralController alloc]init];
                IntegralCon.hidesBottomBarWhenPushed = YES ;
                [self.navigationController pushViewController:IntegralCon animated:YES];
                break;
            case 4:
                
                myorderCon.hidesBottomBarWhenPushed = YES ;
                myorderCon.deleClass = self;
                [self.navigationController pushViewController:myorderCon animated:YES];
                
                break;
            case 5:
                
                userAddresCon.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:userAddresCon animated:YES];
                
                break;
            case 6:
   
                Appointment=[[AppointmentController alloc]init];
                Appointment.hidesBottomBarWhenPushed = YES;
                Appointment.jionClass = @"userClass";
                [self.navigationController pushViewController:Appointment animated:YES];
                
                break;
            case 7:
            
                mysaveCon = [[MysaveController alloc]init];
                mysaveCon.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:mysaveCon animated:YES];
                
                
                break;
            case 8:
            
                
                break;
            case 9:
                
                RepCon=[[ReportController alloc]init];
                RepCon.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:RepCon animated:YES];
                break;
           
            case 11:
                
                feedCon.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:feedCon animated:YES];
                
                break;
            case 12:
                
                deleteCon.hidesBottomBarWhenPushed = YES;
                 [self.navigationController pushViewController:deleteCon animated:YES];
                
                break;
            case 13:
                
//                MoreCon.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:MoreCon animated:YES];
               
                [AlertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                    NSLog(@"点击取消回调方法");
                    
                }]];
      
                [AlertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    
                    NSLog(@"点击确定回调方法");
                    [USER_DEFAULT setObject:NULL forKey:@"UserName"];
                    [USER_DEFAULT setObject:NULL forKey:@"user_id"];
                    
                 //   [self.navigationController popToRootViewControllerAnimated:YES];
                    [self.TableViews setContentOffset:CGPointMake(0,-64) animated:YES];
                    [self viewWillAppear:YES];
                    
                }]];
         
                
                [self presentViewController:AlertCon animated:YES completion:nil];
    
                break;
          
        }
    
    }else{
    
        [self loginController];
    
    }
    
}


#pragma mark -返回每行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        
        return SIZE_HEIGHT*0.31;
        
    }
    
    if (indexPath.row == 1 ) {
        
        return 15;
    }
    if (indexPath.row == 10 ) {
        
        return 15;
    }

    return 42;
}



-(void)GetArrayDataFunc{

    userInfoArray = @[@"",@"nil",@"我是孕妈",@"我的积分",@"我的订单",@"我的地址",@"我的预约",@"我的收藏",@"我的优惠券",@"我的报告单",@"nil",@"意见反馈",@"用户协议",@"退       出"];
  //  userInfoArray = [[NSMutableArray alloc]initWithObjects:@"我的订单",@"我的地址",@"意见反馈",@"用户协议",@"更多设置", nil];
    
}

-(void)Actiondo:(id)sender{

    if([USER_DEFAULT objectForKey:@"user_id"] ==NULL){
    
         [self loginController];
    
    }else{
        return;
    }
  
}

#pragma mark -调用登陆Controller
-(void)loginController{

    loginCon=[[LoginController alloc]init];
    loginNav=[[UINavigationController alloc]initWithRootViewController:loginCon];
    [self presentViewController:loginNav animated:YES completion:^{
        
    }];

}

#pragma mark -用户个人信息修改
-(void)UseriinfoConFunc:(id)sender{

//    UIWebView * callWebview = [[UIWebView alloc] init];
//    NSString *tel = [NSString stringWithFormat:@"tel:%@",[USER_DEFAULT valueForKey:@"phone"]];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tel]]];
//    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];

    if ([USER_DEFAULT objectForKey:@"user_id"] == NULL) {
    
        [self loginController];
        return;
    }
    newUserMessageinfoController *userMessageCon=[[newUserMessageinfoController alloc]init];
    loginNav=[[UINavigationController alloc]initWithRootViewController:userMessageCon];
    [self presentViewController:loginNav animated:YES completion:^{
        
    }];

    
}


#pragma mark -孕期数据解析
-(void)GetHttpyunqiDataFunManager{
    
    //定义请求路径
    
    NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
    if (URL == NULL) {
        
        URL = newurl;
    }
    
    NSString *Urladress = ios_wsym;
    NSString *strUrl =[NSString stringWithFormat:@"%@%@?uid=%@",URL,Urladress,[USER_DEFAULT objectForKey:@"user_id"]];
    //创建链接
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    
    [manager GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject---%@",responseObject);
        week =[NSString stringWithFormat:@"%@", [[responseObject objectAtIndex:0] valueForKey:@"week"]];
        day = [NSString stringWithFormat:@"%@", [[responseObject objectAtIndex:0] valueForKey:@"day"]];;
        
        if ([week isEqualToString:@"0"] && [day isEqualToString:@"0"]) {
           
            yunqi=@"";
        
        }else{
        
            yunqi=[NSString stringWithFormat:@"怀孕中 %@周 +%@天",week,day];
            
        }
              
        [self.TableViews reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
    
}

//变更头像图片
-(void)ChangeImagelogo{

    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        //点击取消调用的方法
        
    }]];
    
    UIImagePickerController *imagePickerCon = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //点击确认调用的方法
            NSLog(@"选择相机");
            
            imagePickerCon.delegate = self;
            imagePickerCon.allowsEditing = YES;
            imagePickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerCon animated:YES completion:^{
                
            }];
            
            
            
        }]];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"相册图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //点击确认调用的方法
            NSLog(@"相册图片");
            // UIImagePickerController *imagePickerCon = [[UIImagePickerController alloc]init];
            imagePickerCon.delegate = self;
            imagePickerCon.allowsEditing = YES;
            imagePickerCon.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerCon animated:YES completion:^{
                
            }];
            
            
        }]];
    }
    
    // 由于它是一个控制器 直接modal出来就好了
    
    [self presentViewController:alertCon animated:YES completion:nil];


}

-(void)userInfoChangeFunc:(id)sender{

    userinfochangeController *userInfoChange = [[userinfochangeController alloc]init];
    userInfoChange.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoChange animated:YES];

}


-(void)geturlimagelogo{

    NSString *urlStr = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],[USER_DEFAULT objectForKey:@"headimgurl"]];
    
    NSLog(@"urlStr-----%@",urlStr);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL * url = [NSURL URLWithString:@"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"];
        NSData * data = [[NSData alloc]initWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc]initWithData:data];
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                headerImagelogo.image = image;
                headerImagelogo.layer.cornerRadius = headerImagelogo.frame.size.width/2;
                headerImagelogo.layer.masksToBounds = true;
                headerImagelogo.layer.borderColor = [[UIColor whiteColor]CGColor];
                headerImagelogo.layer.borderWidth = 2 ;
                
                [self.TableViews reloadData];
                
            });
        }
    });
}


#pragma mark -用户信息数据解析
-(void)GetHttpuserInfoDataFunManager{
    
    //定义请求路径
    NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
    if (URL == NULL) {
        
        URL = newurl;
    }
    
    NSString *Urladress = service_userinfo;
    NSString *strUrl =[NSString stringWithFormat:@"%@%@?user_id=%@",URL,Urladress,[USER_DEFAULT objectForKey:@"user_id"]];
    //创建链接
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    
    [manager GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject---%@",responseObject);
        
        NSString *headimgurl = [[responseObject objectAtIndex:0] valueForKey:@"headimgurl"];
        NSString *nickname = [[responseObject objectAtIndex:0] valueForKey:@"nickname"];
        
        [USER_DEFAULT setObject:headimgurl forKey:@"headimgurl"];
        [USER_DEFAULT setObject:nickname forKey:@"nickname"];
       
        
        [self.TableViews reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

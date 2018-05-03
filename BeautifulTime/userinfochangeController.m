//
//  userinfochangeController.m
//  BeautifulTime
//
//  Created by lee on 2017/4/25.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//


#define H_one 120.0;
#define H_tow 40.0;

#import "userinfochangeController.h"

@interface userinfochangeController ()

@end

@implementation userinfochangeController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"修改个人信息";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [userAddressLeftBack addTarget:self action:@selector(changeFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    
    UIButton *RightBack = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBack.frame = CGRectMake(0, 0, 40, 30);
    [RightBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    RightBack.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [RightBack setTitle:@"保存" forState:UIControlStateNormal];
    [RightBack addTarget:self action:@selector(saveImageFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBack];
    
    self.navigationItem.rightBarButtonItem = RightButtonItem;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    

    
    NSLog(@"USER_DEFAULT----->%@", [USER_DEFAULT objectForKey:@"userLogo"]);
    userInfoActivityView = [ [ UIActivityIndicatorView alloc ]
                                  initWithFrame:CGRectMake((SIZE_WIDTH-120)/2,220.0,120.0,120.0)];
    
    UILabel *quesswirteAcivity = [[UILabel alloc]initWithFrame:CGRectMake(0,10, userInfoActivityView.frame.size.width,20)];
    quesswirteAcivity.text =@"头像上传中...";
    quesswirteAcivity.font = [UIFont systemFontOfSize:12.0];
    quesswirteAcivity.textColor = [UIColor whiteColor];
    quesswirteAcivity.backgroundColor = [UIColor blackColor];
    quesswirteAcivity.textAlignment = NSTextAlignmentCenter;
    
    [userInfoActivityView addSubview:quesswirteAcivity];
    
    userInfoActivityView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleWhiteLarge;
    
    userInfoActivityView.backgroundColor = [UIColor blackColor];//155
    [userInfoActivityView.layer setMasksToBounds:YES];
    [userInfoActivityView.layer setCornerRadius:5.0];
    
    
    [self contentViewFunc];
    [self GetHttpuserInfoDataFunManager];
}




//contentView
-(void)contentViewFunc{

    
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    backgroundView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    [self.view addSubview:backgroundView];
    
    userTable = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SIZE_WIDTH,100) style:UITableViewStylePlain];
    userTable.delegate = self;
    userTable.dataSource = self;
    // TableView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
    userTable.showsVerticalScrollIndicator = NO;
    [userTable setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                  green:145/255.0
                                                   blue:145/255.0
                                                  alpha:0.2]];
    userTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    userTable.scrollEnabled = NO;
    [backgroundView addSubview:userTable];

}
//返回又几块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

//返回又几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 2;
}


//返回每个cell

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    static NSString *IdentifierCell = @"userinfoTabelInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    
    //判断是不是需要重用cell如果cell==nil 创建新的cell
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IdentifierCell];
    }

    //每次重复使用cell之前把cell中的内容全部清除
    while ([cell.contentView.subviews lastObject] != nil)
    {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }

    if(indexPath.row == 0){
    
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 120)];
        contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *LogoNameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,100, 120)];
        LogoNameLable.font = [UIFont systemFontOfSize:14.0];
        LogoNameLable.text = @"修改头像:";
        LogoNameLable.textColor = [UIColor blackColor];
        
        [contentView addSubview:LogoNameLable];
        
        userLogoImage = [[UIImageView alloc]initWithFrame:CGRectMake(110, 5 , 90, 90)];
        userLogoImage.userInteractionEnabled = YES;
        
        
        if ([USER_DEFAULT objectForKey:@"headimgurl"] == NULL) {
            
            
            NSLog(@"userLogo------->%@",[USER_DEFAULT objectForKey:@"userLogo"]);
            
            if([[USER_DEFAULT objectForKey:@"userLogo"] isEqualToString:@"YES"]){
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *docDir = [paths objectAtIndex:0];
                NSString *StrUserLogoImage = [NSString stringWithFormat:@"%@/%@",docDir,@"userLogo.png"];
                
                UIImage *sassveimage = [[UIImage alloc]initWithContentsOfFile:StrUserLogoImage];
                
                userLogoImage.image = sassveimage;
                userLogoImage.layer.cornerRadius = userLogoImage.frame.size.width/2;
                userLogoImage.layer.masksToBounds = true;
                userLogoImage.layer.borderColor = [[UIColor whiteColor]CGColor];
                userLogoImage.layer.borderWidth = 2 ;
                
            }else{
                
                userLogoImage.image=[UIImage imageNamed:@"userinfo_logoYes.png"];
                
            }
            
        }else{
            
            
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],[USER_DEFAULT objectForKey:@"headimgurl"]];
            
            AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(110, 5 , 90, 90)];
            asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
            asynImageView.imageURL = [NSString stringWithFormat:@"%@",urlStr];
            
            userLogoImage=asynImageView;
            userLogoImage.layer.cornerRadius = userLogoImage.frame.size.width/2;
            userLogoImage.layer.masksToBounds = true;
            userLogoImage.layer.borderColor = [[UIColor whiteColor]CGColor];
            userLogoImage.layer.borderWidth = 2 ;
            userLogoImage.userInteractionEnabled = YES;
            
        }
   
      
//
//        userLogoImage.image = [UIImage imageNamed:@"userinfo_logoYes.png"];
//        userLogoImage.userInteractionEnabled = YES;
//        userLogoImage.layer.cornerRadius = 45;
//        userLogoImage.layer.masksToBounds = true;
//        userLogoImage.layer.borderColor = [[UIColor redColor]CGColor];
//        userLogoImage.layer.borderWidth = 2 ;

        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adduserImageTapFunc:)];
        [userLogoImage addGestureRecognizer:tap];

        [contentView addSubview:userLogoImage];
        
        cell.accessoryType= UITableViewCellAccessoryNone;
        [cell.contentView addSubview:contentView];
        
    }
    
    //点击的选择样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

//返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row ==0) {
        
        return H_one;
    }
      //默认高度
    return 20;

}



#pragma mark -添加附件
-(void)adduserImageTapFunc:(id)sender{
    
    
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

#pragma mark -保存图片至沙盒

-(NSString *)saveImage:(UIImage *)currentImage witchName:(NSString *)imageName{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage,1);
    NSString *filePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    imageUrl = filePath;
    NSLog(@"-----imageUrl---%@",imageUrl);
    
    //将图片写入文件
    [imageData writeToFile:filePath atomically:NO];
    
    return filePath;
    
}

#pragma mark -选择完成后调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //保存图片侄本地 上传图片到服务器需要使用
    NSString *fullpath = [self saveImage:image witchName:@"userLogo.png"];
    
    //  NSString *fullpath = [[NSHomeDirectory() stringByAppendingString:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    
    saveimage = [[UIImage alloc]initWithContentsOfFile:fullpath];
    
    userLogoImage.image = saveimage;
    
    
}

-(void)changeFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)saveImageFunc:(id)sender{

    NSLog(@"保存");
    NSString *str=@"YES";
    [USER_DEFAULT setObject:str forKey:@"userLogo"];
    [self.view addSubview:userInfoActivityView];
    [userInfoActivityView startAnimating];
    
    [self QuesstionButFunc];
    
    
}

-(void)QuesstionButFunc{

    NSDictionary *parameters = @{@"user_id":[USER_DEFAULT valueForKey:@"user_id"]};
    NSString *saveQuesstionUrl = service_header_save;
    //  NSString *saveQuesstionUrl = @"http://10.0.0.249:8080/o2o/service_wenwen_save.do";
    NSString *strurlQuesstion = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],saveQuesstionUrl];
    
    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    UIImage *imagedatalogo = saveimage;
    
    
    [manager POST:strurlQuesstion parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = nil;
        NSString *fileName = nil;
        
        if (imagedatalogo==nil) {
            
            NSLog(@"没有图片");
            
            
        }else{
            
            imageData = UIImageJPEGRepresentation(imagedatalogo, 0.2);
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:imageData name:@"filename" fileName:fileName mimeType:@"image/png"];
            
        }
        
        // 上传图片，以文件流的格式
        // [formData appendPartWithFormData:imageData name:@"filename"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"成功%@",responseObject);
        [userInfoActivityView stopAnimating];
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"发布成功！" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败%@",error);
        
    }];
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
        
        [USER_DEFAULT setObject:headimgurl forKey:@"headimgurl"];
        
        
    //    [self.TableViews reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

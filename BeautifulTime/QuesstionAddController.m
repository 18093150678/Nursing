//
//  QuesstionAddController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/17.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "QuesstionAddController.h"



@interface QuesstionAddController ()

@end

@implementation QuesstionAddController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    selectstatus = @"close";
    doctid= nil;
    doctname = @"";
    labelID= @"";
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"提问";
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = ConTitleView;
    
    
    UIButton *LeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LeftBack.frame =CGRectMake(0, 0, 30, 30);
    [LeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    LeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [LeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [LeftBack addTarget:self action:@selector(BackConFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc]initWithCustomView:LeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftBarButton;
    
    UIButton *RightBack = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBack.backgroundColor = [UIColor clearColor];
    RightBack.titleLabel.font = [UIFont systemFontOfSize:12.0];
    RightBack.frame = CGRectMake(0, 0,70, 30);
    [RightBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    RightBack.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [RightBack setTitle:@"选择医生" forState:UIControlStateNormal];
    [RightBack addTarget:self action:@selector(dorctConFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBack];
    
    self.navigationItem.rightBarButtonItem = RightButtonItem;

    
    quessactivityIndicatorView = [ [ UIActivityIndicatorView alloc ]
                             initWithFrame:CGRectMake((SIZE_WIDTH-120)/2,220.0,120.0,120.0)];

    UILabel *quesswirteAcivity = [[UILabel alloc]initWithFrame:CGRectMake(0,10, quessactivityIndicatorView.frame.size.width,20)];
    quesswirteAcivity.text =@"问题上传中...";
    quesswirteAcivity.font = [UIFont systemFontOfSize:12.0];
    quesswirteAcivity.textColor = [UIColor whiteColor];
    quesswirteAcivity.backgroundColor = [UIColor blackColor];
    quesswirteAcivity.textAlignment = NSTextAlignmentCenter;
    
    [quessactivityIndicatorView addSubview:quesswirteAcivity];
    
    quessactivityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleWhiteLarge;
    
    quessactivityIndicatorView.backgroundColor = [UIColor blackColor];//155
    [quessactivityIndicatorView.layer setMasksToBounds:YES];
    [quessactivityIndicatorView.layer setCornerRadius:5.0];

    
    [self GetHttpsDataDoctor];
    
    [self GetquesstionLabel];
   

    
}

#pragma mark -界面内容方法
-(void)ControllerFunc{
    
    QuesstionView = [[UIView alloc]initWithFrame:CGRectMake(0, 26, SIZE_WIDTH, SIZE_HEIGHT)];
    QuesstionView.backgroundColor =  [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    QuesstionView.userInteractionEnabled = YES;
    
    
    [self.view addSubview:QuesstionView];
   

    UILabel *PushTitle = [[UILabel alloc]initWithFrame:CGRectMake(15,39,SIZE_WIDTH-20,40)];
    PushTitle.text = @"发布问问信息";
    PushTitle.font = [UIFont systemFontOfSize:14.0];
    PushTitle.textColor = [UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:0.8];
    
    [QuesstionView addSubview:PushTitle];
    

   
    quesstionView = [[UITextView alloc]initWithFrame:CGRectMake(0, PushTitle.frame.size.height+ 40,SIZE_WIDTH, 140)];
    quesstionView.font = [UIFont systemFontOfSize:14.0];
    quesstionView.textColor = [UIColor blackColor];
    quesstionView.userInteractionEnabled = YES;
    quesstionView.editable = YES;
    //键盘弹出类型
    quesstionView.keyboardType = UIKeyboardTypeDefault;
    //设置键盘上returen键的类型
    quesstionView.returnKeyType = UIReturnKeyDone;
    quesstionView.scrollEnabled = YES;
    quesstionView.backgroundColor = [UIColor colorWithRed:250/255.0 green:248/255.0 blue:239/255.0 alpha:0.8];
    quesstionView.layer.borderColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:0.8].CGColor;
    [QuesstionView addSubview:quesstionView];
    
    
    UIView *addimageViews = [[UIView alloc]initWithFrame:CGRectMake(0, PushTitle.frame.size.height+ 40+140,SIZE_WIDTH, 60)];
    addimageViews.backgroundColor = [UIColor colorWithRed:250/255.0 green:248/255.0 blue:239/255.0 alpha:0.8];
    
    [QuesstionView addSubview:addimageViews];
    
    addImage = [[UIImageView alloc]initWithFrame:CGRectMake(80, 0, 60,60)];
    addImage.userInteractionEnabled = YES;

    [addimageViews addSubview:addImage];
    
    UIButton *addBut = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 60,60)];
    [addBut setBackgroundImage:[UIImage imageNamed:@"ios_add.png"] forState:UIControlStateNormal];
    [addBut addTarget:self action:@selector(addImageTapFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [addimageViews addSubview:addBut];
    
    
    
    douctrlable = [[UILabel alloc]initWithFrame:CGRectMake(20, PushTitle.frame.size.height+ 40+140+70, SIZE_WIDTH,30)];
    if (doctid == nil) {
        
        douctrlable.text = @"还没有选择医生";
    }else{
    
        douctrlable.text = doctname;
    
    }
    douctrlable.textColor= [UIColor blackColor];
    douctrlable.font = [UIFont systemFontOfSize:14.0];
    [QuesstionView addSubview:douctrlable];
    
    
    UIView *labelview = [[UIView alloc]initWithFrame:CGRectMake(10, PushTitle.frame.size.height+ 40+140+110, SIZE_WIDTH-20, 200)];
    float countwidth = 0.0;
    float countheigth = 0.0;
    
    //标签展示
    for (int x =0; x<labelArray.count; x++) {
        
        NSString *labeltitle = [[labelArray objectAtIndex:x] valueForKey:@"name"];
        
        float labelwidth = labeltitle.length*20.00;
        UIButton *labelbut = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (labelwidth+countwidth > SIZE_WIDTH-20) {

            countheigth = countheigth +40;
            countwidth=0.0;
        }
        
        labelbut.frame = CGRectMake(countwidth,countheigth,labelwidth+10, 30);
        [labelbut setTitle:labeltitle forState:UIControlStateNormal];
        [labelbut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [labelbut setBackgroundColor:[UIColor whiteColor]];
        labelbut.layer.cornerRadius = 8;
        labelbut.layer.masksToBounds = true;
//        labelbut.layer.borderColor = [[UIColor redColor]CGColor];
//        labelbut.layer.borderWidth = 1;
        labelbut.tag = x;
        labelbut.selected = NO;
        labelbut.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [labelbut addTarget:self action:@selector(selectedfunc:) forControlEvents:UIControlEventTouchUpInside];
        [labelview addSubview:labelbut];
        
        countwidth=countwidth+labelbut.frame.size.width;
        countwidth=countwidth +5;
    }
    
     [QuesstionView addSubview:labelview];
    
//    UITapGestureRecognizer *addImageTap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImageTapFunc:)];
//    [addImage addGestureRecognizer:addImageTap];
//    [QuesstionView addSubview:addImage];
//    [QuesstionView addSubview:addBut];
    
    
    [self QusstionFunc];
    [self doctviewfunc];
    
 //   [self SaveImageFilejia];
    
    UITapGestureRecognizer *touchCloseKey = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchCloseFunc:)];
    [QuesstionView addGestureRecognizer:touchCloseKey];
 

}

#pragma mark -textview协议
#pragma mark - 将要开始编辑
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    return true;
}




#pragma mark -添加附件
-(void)addImageTapFunc:(id)sender{
    
    
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
    imagePathUrl = filePath;
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
    NSString *fullpath = [self saveImage:image witchName:@"avatar.png"];
    
  //  NSString *fullpath = [[NSHomeDirectory() stringByAppendingString:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    
    UIImage *saveimage = [[UIImage alloc]initWithContentsOfFile:fullpath];
    
    addImage.image =saveimage;
    

}



#pragma mark -返回按钮
-(void)BackConFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -提交问问按钮
-(void)QusstionFunc{
    
    UIButton *_QuesstionBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _QuesstionBut.frame = CGRectMake(0, SIZE_HEIGHT-49-17, SIZE_WIDTH, 40);
    [_QuesstionBut setTitle:@" 提交问题" forState:UIControlStateNormal];
    _QuesstionBut.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_QuesstionBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_QuesstionBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateNormal];
    [_QuesstionBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateHighlighted];
    [_QuesstionBut addTarget:self action:@selector(QuesstionButFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [QuesstionView addSubview:_QuesstionBut];
    
}

#pragma mark - 提交问问按钮事件方法
#pragma mark -发送问问内容附件接口方法
-(void)QuesstionButFunc:(id)sender{
    
    
    
    if (quesstionView.text.length<=0){
    
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请不要提交空内容！" preferredStyle:UIAlertControllerStyleAlert];
      
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        [self presentViewController:alertCon animated:YES completion:nil];

        return;
    
    }

    if (doctid==nil){
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择医生！" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
        
    }

    
    [QuesstionView addSubview:quessactivityIndicatorView];
    [quessactivityIndicatorView startAnimating];
    NSDictionary *parameters = @{@"content":quesstionView.text,@"user_id":[USER_DEFAULT valueForKey:@"UserName"],@"doctor_id":doctid,@"sid":labelID};
    
    
    NSString *saveQuesstionUrl = service_wenwen_save;
  //  NSString *saveQuesstionUrl = @"http://10.0.0.249:8080/o2o/service_wenwen_save.do";
    NSString *strurlQuesstion = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],saveQuesstionUrl];
    
   
    //创建请求
    manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];

    UIImage *imagedatalogo = addImage.image;
    
    
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
        [quessactivityIndicatorView stopAnimating];
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"发布成功！" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败%@",error);
        [quessactivityIndicatorView stopAnimating];
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"失败" message:@"网络连接中断" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
           // [self.navigationController popViewControllerAnimated:YES];
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
       
    }];
}



#pragma mark -按取消按钮调用方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [self doctanimation];
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma -mark -关闭键盘
-(void)touchCloseFunc:(id)sender{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

#pragma mark -医生列表View
-(void)doctviewfunc{
    
    doctview = [[UIView alloc]initWithFrame:CGRectMake(0, -SIZE_HEIGHT, SIZE_WIDTH, SIZE_HEIGHT-70)];
    doctview.alpha = 1.0;
    doctview.backgroundColor = [UIColor whiteColor];
    doctview.clipsToBounds = YES;
    doctview.layer.cornerRadius = 8;
    doctview.layer.masksToBounds = true;
    doctview.userInteractionEnabled = YES;
   
    [self.view addSubview:doctview];
    
    [doctview addSubview:self.tableview];
    
    

}


#pragma mark -选择医生
-(void)dorctConFunc:(id)sender{

    NSLog(@"-----yisheng-----");

    if ([selectstatus isEqualToString:@"close"]) {

        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        //改变它的frame的x,y的值
        doctview.frame=CGRectMake(0,70,SIZE_WIDTH, SIZE_HEIGHT-70);
        [UIView commitAnimations];
        
        selectstatus = @"open";
        
    }else {

        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        //改变它的frame的x,y的值
        doctview.frame=CGRectMake(0,-SIZE_HEIGHT,SIZE_WIDTH, SIZE_HEIGHT-70);
        [UIView commitAnimations];
        
        selectstatus = @"close";
        
    }
    
}

//医生表视图懒加载
-(UITableView *)tableview{

    if (!_tableview) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, doctview.frame.size.width, doctview.frame.size.height-10) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.userInteractionEnabled = YES;
        _tableview.showsVerticalScrollIndicator = NO;

        
        //多余的cell线不现实
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        //定义表视图分界线颜色透明度
        [_tableview setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                          green:145/255.0
                                                           blue:145/255.0
                                                          alpha:0.8]];
        if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableview setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableview setLayoutMargins:UIEdgeInsetsZero];
        }

        
        
    }

    return _tableview;

}


//表示图协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return doctArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellidentifier = @"dataanaysis";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    
    while (cell.contentView.subviews.count>0) {
        
        [[[cell.contentView subviews] objectAtIndex:0] removeFromSuperview];
        
    }
    //定义字符大小
    
    UILabel *doctorName=[[UILabel alloc]initWithFrame:CGRectMake(20,5, 90, 25)];
    doctorName.text=[NSString stringWithFormat:@"%@",[[doctArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
    [doctorName setFont:[UIFont fontWithName:@"Arial" size:14.0]];
    [cell.contentView addSubview:doctorName];
    
    UILabel *doctorTitle=[[UILabel alloc]initWithFrame:CGRectMake(110,5, 120, 25)];
    doctorTitle.text=[NSString stringWithFormat:@"%@",[[doctArray objectAtIndex:indexPath.row] valueForKey:@"post"]];
    [doctorTitle setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    doctorTitle.textColor = [UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1.0];
    [cell.contentView addSubview:doctorTitle];
    
    UILabel *doctorbrief = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, SIZE_WIDTH-40, 50)];
    doctorbrief.text=[NSString stringWithFormat:@"%@",[[doctArray objectAtIndex:indexPath.row] valueForKey:@"shanchang"]];
    [doctorbrief setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    doctorbrief.textColor = [UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1.0];
    doctorbrief.numberOfLines = 3;
    [cell.contentView addSubview:doctorbrief];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self doctanimation];
    
    doctid = [[doctArray objectAtIndex:indexPath.row] valueForKey:@"id"];
    doctname =  [[doctArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    douctrlable.text = [NSString stringWithFormat:@"%@   %@",doctname,[[doctArray objectAtIndex:indexPath.row] valueForKey:@"post"]];
}

//返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
       return 85;
    
}


#pragma mark -获取医生列表
-(void)GetHttpsDataDoctor{
    
    NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
    NSString *Urladress = ios_doctor_list;
    NSString *strUrl =[NSString stringWithFormat:@"%@%@",URL,Urladress];
    //创建链接
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    [manager GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        doctArray  = responseObject;
        NSLog(@"responseObject----%@",doctArray);
        [_tableview reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //    [activityIndicatorView stopAnimating];
        
    }];
}

#pragma mark -医生列表关闭动画方法
-(void)doctanimation{

    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    //改变它的frame的x,y的值
    doctview.frame=CGRectMake(0,-SIZE_HEIGHT,SIZE_WIDTH, SIZE_HEIGHT-70);
    [UIView commitAnimations];
    
    selectstatus = @"close";

}

#pragma mark- 获取问问标签列表
-(void)GetquesstionLabel{

        //定义请求路径
    
        NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
        NSString *Urladress = service_section_list;
        NSString *strUrl =[NSString stringWithFormat:@"%@%@",URL,Urladress];
        //创建链接
        manager = [AFHTTPSessionManager manager];
        
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        //发送请求
        
        [manager GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            labelArray  = responseObject;
            NSLog(@"menuArray%@----",labelArray);
            [self ControllerFunc];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];


}

-(void)selectedfunc:(UIButton *)sender{

    UIButton *but = (UIButton *)sender;
    if ([but isEqual:selectButsss]) {
        
        NSLog(@"同一个");
        if (but.selected == YES) {
            
            but.backgroundColor = [UIColor whiteColor];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            but.selected = NO;
            labelID = @"";
            
        }else{
        
            but.backgroundColor = [UIColor redColor];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            but.selected = YES;
            labelID = [[labelArray objectAtIndex:but.tag] valueForKey:@"id"];
        
        }

    }else{
    
        NSLog(@"不是同一个");
        but.backgroundColor = [UIColor redColor];
        but.selected = YES;
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        selectButsss.backgroundColor = [UIColor whiteColor];
        [selectButsss setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        labelID = [[labelArray objectAtIndex:but.tag] valueForKey:@"id"];
       
    
    }

    
    selectButsss = but;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}


@end

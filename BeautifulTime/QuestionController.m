//
//  QuestionController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "QuestionController.h"

@interface QuestionController (){

    UIView *background;
    float cellHeight;
    float contentHeight;
    float imageHeight;
    float recontenttitleheight;
    float recontengheight;

}

@end

@implementation QuestionController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"远程问诊";
    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *RightBack = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBack.titleLabel.font = [UIFont systemFontOfSize:12.0];
    RightBack.frame = CGRectMake(0, 0, 30, 30);
    [RightBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    RightBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [RightBack setTitle:@"\U0000e61d" forState:UIControlStateNormal];
    [RightBack addTarget:self action:@selector(QuesstionConFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBack];
    
    self.navigationItem.rightBarButtonItem = RightButtonItem;
 //   UIBarButtonSystemItemRefresh
    
    UIButton *LeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LeftBack.frame =CGRectMake(0, 0,22, 22);
    [LeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [LeftBack setBackgroundImage:[UIImage imageNamed:@"button-synchronize.png"] forState:UIControlStateNormal];
    
    [LeftBack addTarget:self action:@selector(mySelectorshuxin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc]initWithCustomView:LeftBack];

    

    self.navigationItem.leftBarButtonItem = LeftBarButton;
  
   // [self GetTaBleViewFunc];
  //  [self WebGetDataProductInfo];

    
}

-(void)viewWillAppear:(BOOL)animated{

    
  //  [self GetQuesstionListFunc];
    [self webquesstionfunc];
    [self WebGetDataProductInfo];

}

#pragma mark -数据列表
-(void)GetTaBleViewFunc{
    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:CGRectMake(9,0, SIZE_WIDTH, SIZE_HEIGHT)];
    imageTableView.image = [UIImage imageNamed:@"timelogo.png"];

    TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT-114)];
    TableView.delegate = self;
    TableView.dataSource  = self;
    TableView.backgroundView = imageTableView;
    TableView.showsVerticalScrollIndicator = NO;
    [TableView setSeparatorColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.4]];
    
    if ([TableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [TableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([TableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [TableView setLayoutMargins:UIEdgeInsetsZero];
    }

    
    [self.view addSubview:TableView];

}

#pragma mark -web
-(void)webquesstionfunc{

    webView = [[UIWebView alloc]initWithFrame:CGRectMake(5,64, SIZE_WIDTH-10,SIZE_HEIGHT-65)];
    webView.delegate = self ;
    webView.scrollView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    //是否支持互动
    [webView setUserInteractionEnabled:YES];
    //是否适应屏幕
    [webView setScalesPageToFit:YES];
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:webView];


}

#pragma mark -返回每组有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return quesstionArray.count;
}

#pragma mark -返回有几组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}
#pragma mark -返回每个cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellName = @"idfentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    

    while ([[cell.contentView subviews] count]>0) {
        
        [[[cell.contentView subviews] objectAtIndex:0] removeFromSuperview];
    }

    NSInteger cellheight=[self resultheight:indexPath.row];
    
    NSLog(@"cellheight ----%ld",(long)cellheight);
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(10,0,70, cellheight-10)];
    
//    UIImageView *quessTionImagelogo = [[UIImageView alloc]initWithFrame:CGRectMake(5,10, 55, 55)];
//    quessTionImagelogo.image = [UIImage imageNamed:@"userinfo_logoYes.png"];
//    [leftView addSubview:quessTionImagelogo];
    
    NSString *headimgurl= [NSString stringWithFormat:@"%@",[[quesstionArray objectAtIndex:indexPath.row] valueForKey:@"headimgurl"]];

    if([headimgurl isEqual:[NSNull null]])
    {
        
        headimgurl = @"y";
        
    }else if([headimgurl isEqualToString:@"<null>"]){
        
        headimgurl = @"y";
        
    }else if(headimgurl == nil){
      
        headimgurl = @"y";
    }
   
    
    if([headimgurl isEqualToString:@"y"])
    {
 
        UIImageView *quessTionImagelogo = [[UIImageView alloc]initWithFrame:CGRectMake(5,10, 55, 55)];
        quessTionImagelogo.image = [UIImage imageNamed:@"userinfo_logoYes.png"];
        [leftView addSubview:quessTionImagelogo];
        
        
    }else{

    NSString *urlStr = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],headimgurl];
    NSLog(@"urlStr---%@",urlStr);
    AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(5,10, 55, 55)];
    asynImageView.placeholderImage=[UIImage imageNamed:@"userinfo_logoYes.png"];
    asynImageView.imageURL = [NSString stringWithFormat:@"%@",urlStr];
    asynImageView.layer.cornerRadius = asynImageView.frame.size.width/2;
    asynImageView.layer.masksToBounds = true;
    asynImageView.layer.borderColor = [[UIColor whiteColor]CGColor];
    asynImageView.layer.borderWidth = 2 ;
    [leftView addSubview:asynImageView];

    }
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(80, 0, SIZE_WIDTH-80, cellheight-10)];
    
    NSString *usrName= [NSString stringWithFormat:@"%@",[[quesstionArray objectAtIndex:indexPath.row] valueForKey:@"nickname"]];
    NSString *suerName=@"";
    
    if([usrName isEqual:[NSNull null]])
    {
        
        suerName= [NSString stringWithFormat:@"%@",[[quesstionArray objectAtIndex:indexPath.row] valueForKey:@"create_user"]];
        suerName = [self substrfunc:suerName];
        
    }else if([usrName isEqualToString:@"<null>"]){
    
        suerName= [NSString stringWithFormat:@"%@",[[quesstionArray objectAtIndex:indexPath.row] valueForKey:@"create_user"]];
        suerName = [self substrfunc:suerName];
    
    }else if(usrName == nil){
        
        suerName= [NSString stringWithFormat:@"%@",[[quesstionArray objectAtIndex:indexPath.row] valueForKey:@"create_user"]];
        suerName = [self substrfunc:suerName];
    }
    else{
    
        suerName = usrName;
    
    }
 
    UILabel *QuesstionMan = [[UILabel alloc]initWithFrame:CGRectMake(0,0,rightView.frame.size.width/2, 40)];
    QuesstionMan.textAlignment = NSTextAlignmentLeft;
    QuesstionMan.text = suerName;
    QuesstionMan.textColor = [UIColor colorWithRed:218/255.0 green:92/255.0 blue:92/255.0 alpha:0.8];
    QuesstionMan.font = [UIFont systemFontOfSize:14.0];
    [rightView addSubview:QuesstionMan];
    
        //时间
    UILabel *QuesstionTime = [[UILabel alloc]initWithFrame:CGRectMake(rightView.frame.size.width/2,0, rightView.frame.size.width/2, 40)];
    QuesstionTime.textAlignment = NSTextAlignmentCenter;
    QuesstionTime.text = [[quesstionArray objectAtIndex:indexPath.row] valueForKey:@"create_time"];
    QuesstionTime.textColor = [UIColor colorWithRed:218/255.0 green:92/255.0 blue:92/255.0 alpha:0.8];
    QuesstionTime.font = [UIFont systemFontOfSize:12.0];
    [rightView addSubview:QuesstionTime];

    
    UIView *QuesstionManlineView  = [[UIView alloc]initWithFrame:CGRectMake(0,40, rightView.frame.size.width, 1)];
    QuesstionManlineView.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.8];
    
    [rightView addSubview:QuesstionManlineView];
    
    
    NSString *Content  = [[quesstionArray objectAtIndex:indexPath.row] valueForKey:@"content"];
    UILabel *QuesstionContent = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, rightView.frame.size.width-10,contentHeight)];
    QuesstionContent.text = Content;
    QuesstionContent.font = [UIFont systemFontOfSize:14.0];
    QuesstionContent.numberOfLines = 0;
    QuesstionContent.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1.0];

    [rightView addSubview:QuesstionContent];
    
    //图片
    
    
    NSString *strimg_url = [[quesstionArray objectAtIndex:indexPath.row] valueForKey:@"img_url"];
    
    if([strimg_url isEqual:[NSNull null]])
    {
        
        NSLog(@"kong");
        
        
    }else{
        
        AsynImageView *QuesstionasynImageView=[[AsynImageView alloc]init];
        QuesstionasynImageView.frame = CGRectMake(0,contentHeight+40,imageHeight,imageHeight);
        QuesstionasynImageView.placeholderImage=[UIImage imageNamed:@"product_M.png"];
        QuesstionasynImageView.userInteractionEnabled = YES;
        QuesstionasynImageView.tag = indexPath.row;
        QuesstionasynImageView.imageURL = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],strimg_url];
        QuesstionasynImageView.contentMode=UIViewContentModeScaleAspectFit;
        QuesstionasynImageView.clipsToBounds=YES;
        
        [rightView addSubview:QuesstionasynImageView];
        
        UITapGestureRecognizer *addImageTap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImageTapFunc:)];
        addImageTap.view.tag = QuesstionasynImageView.tag;
        [QuesstionasynImageView addGestureRecognizer:addImageTap];
        
    }

    UILabel *Quesstionrecontent = [[UILabel alloc]initWithFrame:CGRectMake(0,contentHeight+40+imageHeight+recontenttitleheight,rightView.frame.size.width-20,recontengheight+20)];
    Quesstionrecontent.numberOfLines = 0;
    Quesstionrecontent.font = [UIFont systemFontOfSize:14.0];
    Quesstionrecontent.textColor = [UIColor colorWithRed:218/255.0 green:92/255.0 blue:92/255.0 alpha:0.8];
    

    //计算恢复内容高度
    NSString *recontent = [[quesstionArray objectAtIndex:indexPath.row] valueForKey:@"recontent"];
    if (![recontent isEqual:[NSNull null]]) {
        
        UIView *QuesstionKfAnwslineView  = [[UIView alloc]initWithFrame:CGRectMake(0,contentHeight+40+imageHeight+5, rightView.frame.size.width, 1)];
        QuesstionKfAnwslineView.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.8];
        [rightView addSubview:QuesstionKfAnwslineView];
        //客服回答
        
        UILabel *QuesstionKfAnws = [[UILabel alloc]initWithFrame:CGRectMake(0,contentHeight+40+imageHeight+10,rightView.frame.size.width,recontenttitleheight)];
        QuesstionKfAnws.text =  [NSString stringWithFormat:@"%@:",[[quesstionArray objectAtIndex:indexPath.row] valueForKey:@"reply_user"]];
        QuesstionKfAnws.font = [UIFont systemFontOfSize:14.0];
        QuesstionKfAnws.textColor = [UIColor colorWithRed:218/255.0 green:92/255.0 blue:92/255.0 alpha:0.8];
        
        [rightView addSubview:QuesstionKfAnws];


        Quesstionrecontent.text = recontent;
        
        [rightView addSubview:Quesstionrecontent];
    }

    UIView *lineView  = [[UIView alloc]initWithFrame:CGRectMake(0,cellheight-10, SIZE_WIDTH, 10)];
    lineView.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.4];
    [cell.contentView addSubview:lineView];
    
    
    [cell.contentView addSubview:leftView];
    [cell.contentView addSubview:rightView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -cell每行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //默认高度计算字符串高度
    NSInteger reslut = [self resultheight:indexPath.row];
    return reslut;
  
}

#pragma mark -获取问问问题列表
-(void)GetQuesstionListFunc{

    NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
    NSString *strUrlss = QuesttionUrl;
    NSString *strphone = [USER_DEFAULT valueForKey:@"UserName"];
    NSString *strUrl =[NSString stringWithFormat:@"%@%@?user_id=%@",URL,strUrlss,strphone];

    //创建链接
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    
    
    
    [manager GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject %@",responseObject);
        quesstionArray  = responseObject;
        
        
        
        //   [self ImageFunc];
        [TableView reloadData];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark -图片处理
-(void)ImageFunc{

    quesstionArrayImage = [[NSMutableArray alloc]init];
    
    for (int i =0 ; i< quesstionArray.count; i++) {
        
        AsynImageView *asynImageView=[[AsynImageView alloc]init];
        asynImageView.placeholderImage=[UIImage imageNamed:@"logoblack.png"];
        asynImageView.imageURL=[NSString stringWithFormat:@"%@",[[quesstionArray objectAtIndex:i] valueForKey:@""]];
        asynImageView.contentMode=UIViewContentModeScaleToFill;
        [quesstionArrayImage addObject:asynImageView];

    }
    
    NSLog(@"quesstionArrayImage---%@",quesstionArrayImage);


}

#pragma mark -提问
-(void)QuesstionConFunc:(id)sender{

    
    if ([USER_DEFAULT valueForKey:@"user_id"] == NULL) {
    
        [self loginController];
        return;
        
    }

    QuesstionAddController *quesstionCon = [[QuesstionAddController alloc]init];
    quesstionCon.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:quesstionCon animated:YES];
    

}
#pragma mark -图片大小
-(void)tapImageFunc:(id)sender{

    NSLog(@"----s----");

}

#pragma mark -登陆
#pragma mark -调用登陆Controller
-(void)loginController{
    
    loginCon=[[LoginController alloc]init];
    loginNav=[[UINavigationController alloc]initWithRootViewController:loginCon];
    [self presentViewController:loginNav animated:YES completion:^{
        
    }];
    
}


-(float)resultheight:(NSInteger)indexpathRow{

    cellHeight=40;
    contentHeight = 40;
    imageHeight =20;
    recontenttitleheight=20;
    recontengheight =40;
    NSString *strContent = [[quesstionArray objectAtIndex:indexpathRow] valueForKey:@"content"];
    NSInteger strintcontent = strContent.length*14;
    NSInteger strcontentnum = strintcontent/(SIZE_WIDTH-100);
    
    //计算问题内容高度
    if (strcontentnum>1) {
        
        contentHeight=contentHeight*strcontentnum;
        
    }
    
    //计算图片高度
    NSString *strimg_url = [[quesstionArray objectAtIndex:indexpathRow] valueForKey:@"img_url"];
    
    if([strimg_url isEqual:[NSNull null]])
    {
        
        NSLog(@"kong");
        
        
    }else{
    
        imageHeight=160;
        
    }
    
    //计算回复内容高度
    NSString *recontent = [[quesstionArray objectAtIndex:indexpathRow] valueForKey:@"recontent"];
    
    if (![recontent isEqual:[NSNull null]]) {
        
        float recontengnum=recontent.length*14;
        float num = recontengnum/(SIZE_WIDTH-120);
        
        if (num>1) {
            
            recontengheight = num*22;
        }

        NSLog(@"recontengheight---%f",recontengheight);

    }
    
    cellHeight =cellHeight+contentHeight+imageHeight+recontenttitleheight+recontengheight;
    
    //加入间距
    cellHeight=cellHeight+20;
    
    return cellHeight;
}

//图片变大
-(void)addImageTapFunc:(id)sender{


    @try {
        
        UITapGestureRecognizer *tap =(UITapGestureRecognizer *)sender;
        NSInteger index=tap.view.tag;
        AsynImageView *asynImageView=[[AsynImageView alloc]init];
        asynImageView.placeholderImage=[UIImage imageNamed:@"product_M.png"];
        asynImageView.imageURL=[NSString stringWithFormat:@"%@",[[quesstionArray objectAtIndex:index] valueForKey:@"img_url"]];
        
        NSLog(@"asynImageView.image%@",[[quesstionArray objectAtIndex:index] valueForKey:@"img_url"]);
        NSLog(@"asynImageView.image%@",asynImageView.image);
        if (asynImageView.image == nil) {
            
            NSLog(@"kongyyay");
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"大肚婆" message:@"图片不存在" preferredStyle:UIAlertControllerStyleAlert];
            
            
            [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }]];

            return ;
        }else{
        
            quesstionmodelController *modelCon = [[quesstionmodelController alloc]init];
            modelCon.image = asynImageView.image.copy;
            [self presentViewController:modelCon animated:NO completion:^{
                
            }];
        }
       
        
    } @catch (NSException *exception) {
        
    }

}

//字符串截取封装方法
-(NSString *)substrfunc:(NSString *)str{


    NSString *str1 = [str substringToIndex:4];
    NSString *str2 = [str substringFromIndex:8];
    NSString *resultstr=[NSString stringWithFormat:@"%@****%@",str1,str2];
    
    return resultstr;

}


-(void)WebGetDataProductInfo{
    
    
    NSString *StrUrl = [NSString stringWithFormat:@"%@/%@",newurl,@"wenwen.htm"];
    StrUrl = [NSString stringWithFormat:@"%@?user_id=%@&ios=1",StrUrl,[USER_DEFAULT valueForKey:@"UserName"]];
    NSLog(@"StrUrl--%@",StrUrl);
    NSURL *url= [NSURL URLWithString:StrUrl];
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}





-(void)mySelectorshuxin:(id)sender{

    [self webquesstionfunc];
    [self WebGetDataProductInfo];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end

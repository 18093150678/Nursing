//
//  AppointmentController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/13.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#define cell_Height 190

#import "AppointmentController.h"
#import "Pretreatment.h"
#import "UserInfoController.h"
#import "TeYueDoctorWebController.h"

@interface AppointmentController ()

@end

@implementation AppointmentController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"我的预约";
    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrews" size:14.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *LeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LeftBack.frame =CGRectMake(0, 0, 30, 30);
    [LeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    LeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:14];
    [LeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    
    [LeftBack addTarget:self action:@selector(aBackConFunc:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc]initWithCustomView:LeftBack];
    self.navigationItem.leftBarButtonItem = LeftBarButton;
  
    UIButton *RightBack = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBack.titleLabel.font = [UIFont systemFontOfSize:12.0];
    RightBack.frame = CGRectMake(0, 0, 30, 30);
    [RightBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    RightBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:14];
    [RightBack setTitle:@"\U0000e60a" forState:UIControlStateNormal];
    [RightBack addTarget:self action:@selector(appUsertellConFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBack];
    self.navigationItem.rightBarButtonItem = RightButtonItem;
    self.navigationController.navigationBar.translucent = YES;
    
    
    [self Apptreatmentlist];
    [self segmentViewaddFunc];
    [self addViewFunc];
    [self indexViewControllerFunc];


}

-(void)aBackConFunc:(id)sender{
    
    UserInfoController *useCon=[[UserInfoController alloc]init];
    

    for (UIViewController *temp in self.navigationController.viewControllers) {
        
        
        if ([temp isKindOfClass:useCon.class]) {
            
            [self.navigationController popToViewController:temp animated:YES];
        }
        
    }
    
    if ([_jionClass isEqualToString:@"algin"]) {
        
        FindDoctorController *FindCon = [[FindDoctorController alloc]init];
        
        for (UIViewController *temp in self.navigationController.viewControllers) {
            
            
            if ([temp isKindOfClass:FindCon.class]) {
                
                [self.navigationController popToViewController:temp animated:YES];
            }
            
        }

    }
    
    

    
}

#pragma mark -拨打电话方法
-(void)appUsertellConFunc:(id)sender{
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    NSString *tel = [NSString stringWithFormat:@"tel:%@",[USER_DEFAULT valueForKey:@"phone"]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tel]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}

#pragma mark -选择按钮
-(void)segmentViewaddFunc{
    
    NSArray *items = @[@"待就诊",@"已取消"];
    UISegmentedControl *sc = [[UISegmentedControl alloc]initWithItems:items]; //用文字数组初始化
    sc.frame = CGRectMake(0, 64, SIZE_WIDTH, 40);
    sc.selectedSegmentIndex = 0;
    
    [sc addTarget:self action:@selector(appSeqmentedChange:) forControlEvents:UIControlEventValueChanged];
    
    sc.tintColor = [UIColor clearColor];//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0],
                                             NSForegroundColorAttributeName: [UIColor redColor]};
    [sc setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0],
                                               NSForegroundColorAttributeName: [UIColor blackColor]};
    [sc setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    [self.view addSubview:sc];
    
}

#pragma mark -分类选择按钮事件
-(void)appSeqmentedChange:(UISegmentedControl *)sender{


    datelist=[[NSArray alloc]init];
    switch (sender.selectedSegmentIndex) {
        case 0:
            //待就诊
            NSLog(@"0");
            
            [self Apptreatmentlist];
            break;
        case 1:
            //已取消
            NSLog(@"1");
            [self Apptreatmentlistceanl];
            
        default:
            break;
    }
    
}

#pragma mark -分割条
-(void)addViewFunc{

    UIView *line_view=[[UIView alloc]initWithFrame:CGRectMake(0, 94, SIZE_WIDTH, 10)];
    line_view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
    [self.view addSubview:line_view];
}

-(void)indexViewControllerFunc{
    
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0,104, SIZE_WIDTH, SIZE_HEIGHT)];
    backgroundView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:backgroundView];
    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:backgroundView.bounds];
    imageTableView.image = [UIImage imageNamed:@"timelogo.png"];
    
    //定义表示图 表示图的样式为分组视图
    appTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH,SIZE_HEIGHT-108) style:UITableViewStylePlain];
    appTableView.delegate = self;
    appTableView.dataSource = self;
    appTableView.backgroundView = imageTableView;
    appTableView.showsVerticalScrollIndicator = NO;
    [appTableView setSeparatorColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.4]];
    
    if ([appTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [appTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([appTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [appTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(apprefreshView:)
              forControlEvents:UIControlEventValueChanged];
    [_refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
    [appTableView addSubview:_refreshControl];
    
    
    [backgroundView addSubview:appTableView];
    
    [self.view addSubview:backgroundView];
    
    
}


#pragma mark 第section组一共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return datelist.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //定义cell名称 用于重用
    static NSString *cellname=@"BeautifulTimeCell";
    UITableViewCell *cell  =  [tableView dequeueReusableCellWithIdentifier:cellname];
    
    if (cell==nil) {
        //不存在的cell
        //创建新的cel
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellname];

    }
    
    while ([cell.contentView.subviews lastObject] != nil)
    {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    
    UIView *cellBackGroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, cell_Height)];
    cellBackGroundView.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
    
    
    UIView *cellContentView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, cell_Height-10)];
    cellContentView.backgroundColor=[UIColor whiteColor];
    
    UIView *yuyueTime=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 30)];
    UILabel *yyID=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-20, 30)];
    yyID.backgroundColor=[UIColor whiteColor];
    yyID.textAlignment = NSTextAlignmentRight;
    yyID.font=[UIFont systemFontOfSize:12.0];
    yyID.textColor=[UIColor blackColor];
    yyID.text=[NSString stringWithFormat:@"预约编号:%@",[[datelist objectAtIndex:indexPath.row] valueForKey:@"id"]];
    [yuyueTime addSubview:yyID];
    
    [cellContentView addSubview:yuyueTime];
    
    
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, SIZE_WIDTH, 1)];
    lineLabel.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
    [cellContentView addSubview:lineLabel];
    
    UIView *conetentView = [[UIView alloc]initWithFrame:CGRectMake(0, 31, SIZE_WIDTH, 109)];
    conetentView.backgroundColor=[UIColor whiteColor];
    //产品图片
    AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(10,10, SIZE_WIDTH*0.4, 80)];
    asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
    asynImageView.imageURL=[NSString stringWithFormat:@"%@",[[datelist objectAtIndex:indexPath.row] valueForKey:@"photo"]];
    asynImageView.imageURL = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],asynImageView.imageURL];
    asynImageView.contentMode=UIViewContentModeScaleToFill;
    
    [conetentView addSubview:asynImageView];

    UILabel *proName=[[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width+20, 10,SIZE_WIDTH-100, 20)];
    proName.textColor=[UIColor blackColor];
    [proName setFont:[UIFont fontWithName:@"ArialHebrew" size:14.0]];
    proName.text=[[datelist objectAtIndex:indexPath.row] valueForKey:@"name"];
    [conetentView addSubview:proName];
    
    
    UILabel *className=[[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width+20, 50,SIZE_WIDTH-100, 20)];
    className.textColor=[UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:0.8];
    [className setFont:[UIFont fontWithName:@"ArialHebrew" size:14.0]];
    className.text=[[datelist objectAtIndex:indexPath.row] valueForKey:@"sname"];
    [conetentView addSubview:className];
    
    NSString *apTime=@"";
    if ([[[datelist objectAtIndex:indexPath.row] valueForKey:@"ampm"] isEqualToString:@"p"]) {
        apTime=@"下午";
    }
    if([[[datelist objectAtIndex:indexPath.row] valueForKey:@"ampm"] isEqualToString:@"a"]){
    
        apTime=@"上午";
    }
    
    UILabel *yyTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width+20, 70,SIZE_WIDTH-100, 20)];
    yyTimeLabel.textColor=[UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:0.8];
    yyTimeLabel.font=[UIFont systemFontOfSize:14.0];
    yyTimeLabel.text=[NSString stringWithFormat:@"就诊时间:%@ %@",[[datelist objectAtIndex:indexPath.row] valueForKey:@"yy_time"],apTime];
    [conetentView addSubview:yyTimeLabel];
    
    [cellContentView addSubview:conetentView];
 
    
    UIView *ceanlButView=[[UIView alloc]initWithFrame:CGRectMake(0, 140, SIZE_WIDTH, 40)];
    
    if ([intemStrStatus isEqualToString:@"treatment"]) {
        
        UIButton *ceanlBut=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        ceanlBut.frame=CGRectMake(SIZE_WIDTH-140,0, 90, 30);
        [ceanlBut setTitle:@"取消预约" forState:UIControlStateNormal];
        [ceanlBut setTintColor:[UIColor blackColor]];
        ceanlBut.titleLabel.font = [UIFont fontWithName:@"ArialHebrew" size:14.0];
        [ceanlBut.layer setMasksToBounds:YES];
        [ceanlBut.layer setCornerRadius:12.0]; //设置矩形四个圆角半径
        //边框宽度
        [ceanlBut.layer setBorderWidth:1.0];
        ceanlBut.layer.borderColor = [[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:0.8] CGColor];
        [ceanlBut addTarget:self action:@selector(ceanlFunc:) forControlEvents:UIControlEventTouchUpInside];
        ceanlBut.tag = indexPath.row;
        [ceanlButView addSubview:ceanlBut];
        
        [cellContentView addSubview:ceanlButView];
        
    }else if([intemStrStatus isEqualToString:@"ceanl"]){
    
    
        UIButton *ceanlBut=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        ceanlBut.frame=CGRectMake(SIZE_WIDTH-140,0, 110, 35);
        [ceanlBut setTitle:@"在次预约" forState:UIControlStateNormal];
        [ceanlBut setTintColor:[UIColor blackColor]];
        ceanlBut.titleLabel.font = [UIFont fontWithName:@"ArialHebrew" size:14.0];
        [ceanlBut.layer setMasksToBounds:YES];
        ceanlBut.tag = indexPath.row;
        [ceanlBut.layer setCornerRadius:12.0]; //设置矩形四个圆角半径
        //边框宽度
        [ceanlBut.layer setBorderWidth:1.0];
        ceanlBut.layer.borderColor = [[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:0.8] CGColor];
        [ceanlBut addTarget:self action:@selector(agceanlFunc:) forControlEvents:UIControlEventTouchUpInside];
        ceanlBut.tag = indexPath.row;
        [ceanlButView addSubview:ceanlBut];
        
        [cellContentView addSubview:ceanlButView];

    }
    
    [cellBackGroundView addSubview:cellContentView];
    [cell.contentView addSubview:cellBackGroundView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;


}
#pragma mark -下拉刷新
-(void)apprefreshView:(UIRefreshControl *)sender{

    [self Apptreatmentlist];
    [sender endRefreshing];

}

#pragma mark-取消预约按钮事件
-(void)ceanlFunc:(id)sender{

    
    UIButton *but=(UIButton *)sender;
    NSInteger butindex=but.tag;
    NSString *oryyid=[[datelist objectAtIndex:butindex] valueForKey:@"id"];
    NSLog(@"ceanl");
    NSDictionary *parameters=[[NSDictionary alloc]init];
    
    parameters  =@{@"user_id":[USER_DEFAULT valueForKey:@"user_id"],@"id":oryyid};
    
    NSLog(@"parameters---%@",parameters);
    //创建字典参数列表
    NSLog(@"user_id%@",[USER_DEFAULT valueForKey:@"user_id"]);
    
    //拼接地址
    NSString *strUlr = service_Cancelfunc;
    NSString *strurlchange=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],strUlr];
    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求
    
    [manager POST:strurlchange parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         
         
     }progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         datelist = responseObject;
         
         NSLog(@"datelist%@",datelist);
         //       [activityIndicatorView stopAnimating];
         
      //   [appTableView reloadData];
         [self Apptreatmentlist];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         //   [activityIndicatorView stopAnimating];
     }];
}

-(void)agceanlFunc:(id)sender{

    NSLog(@"---在次预约---");
    
    UIButton *ceanlBut =(UIButton *)sender;
  
    if ([_jionClass isEqualToString:@"userClass"]) {
        
        TeYueDoctorWebController *teyueDoctCon = [[TeYueDoctorWebController alloc]init];
        teyueDoctCon.doctorID = [[datelist objectAtIndex:ceanlBut.tag] valueForKey:@"doctor_id"];
        teyueDoctCon.teyuejonClass = @"userClass";
        [self.navigationController pushViewController:teyueDoctCon animated:YES];
        
    }else{
    TeYueDoctorWebController *teyueCon = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];

    //发送消息传递参数过去
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:[[datelist objectAtIndex:ceanlBut.tag] valueForKey:@"doctor_id"]
                                                         forKey:@"doctorID"];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"RegisterCompletionNotification"
     object:nil
     userInfo:dataDict];
  
    
    for (UIViewController *temp in self.navigationController.viewControllers) {
        
        
        if ([temp isKindOfClass:teyueCon.class]) {
            
            
            [self.navigationController popToViewController:temp animated:YES];
        }
        
    }
    }
    
}
#pragma mark -读取订单信息列表
-(void)Apptreatmentlist{
    
    NSDictionary *parameters=[[NSDictionary alloc]init];
   
    parameters  =@{@"user_id":[USER_DEFAULT valueForKey:@"user_id"]};
   
    //创建字典参数列表
    NSLog(@"user_id%@",[USER_DEFAULT valueForKey:@"user_id"]);
    
    //拼接地址
    NSString *strUlr = service_Waitingtreatment;
    NSString *strurlchange=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],strUlr];
    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求
    
    [manager POST:strurlchange parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         
         
     }progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         datelist=nil;
         datelist = responseObject;
         intemStrStatus=@"treatment";
         
         NSLog(@"Apptreatmentlist%@",datelist);
  //       [activityIndicatorView stopAnimating];
         
         [appTableView reloadData];
         
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
      //   [activityIndicatorView stopAnimating];
     }];
}

#pragma mark -读取取消预约信息列表
-(void)Apptreatmentlistceanl{
    
    NSDictionary *parameters=[[NSDictionary alloc]init];
    
    parameters  =@{@"user_id":[USER_DEFAULT valueForKey:@"user_id"]};
    
    //创建字典参数列表
    NSLog(@"user_id%@",[USER_DEFAULT valueForKey:@"user_id"]);
    
    //拼接地址
    NSString *strUlr = service_Canceltreatment;
    NSString *strurlchange=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],strUlr];
    NSLog(@"strurlchange%@",strurlchange);
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求
    
    [manager POST:strurlchange parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         
         
     }progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         datelist=nil;
         datelist = responseObject;
         intemStrStatus=@"ceanl";
         NSLog(@"Apptreatmentlistceanl%@",datelist);
         //       [activityIndicatorView stopAnimating];
         
         [appTableView reloadData];
         
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         //   [activityIndicatorView stopAnimating];
     }];
}

#pragma mark-取消就诊 service_Canceltreatment
-(void)CancelFunc{

    

}


#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return cell_Height;
    
}
-(NSArray *)loaddatelist{

    if (!datelist) {
        datelist=[[NSArray alloc]init];
    }

    return datelist;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

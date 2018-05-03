//
//  OrderInfoController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//
#define cell_Height 150
#import "OrderInfoController.h"

@interface OrderInfoController ()

@end

@implementation OrderInfoController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"订单";
    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *RightBackProorder = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBackProorder.titleLabel.font = [UIFont systemFontOfSize:12.0];
    RightBackProorder.frame = CGRectMake(0, 0, 30, 30);
    [RightBackProorder setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    RightBackProorder.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [RightBackProorder setTitle:@"\U0000e60a" forState:UIControlStateNormal];
    [RightBackProorder addTarget:self action:@selector(OrdertellConFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBackProorder];
    
    self.navigationItem.rightBarButtonItem = RightButtonItem;
    
    [self LoginFunc];
    
    
    if ([TableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [TableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([TableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [TableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    

    netStatus = @"YesNet";
    
    activityIndicatorView = [ [ UIActivityIndicatorView alloc ]
                             initWithFrame:CGRectMake((SIZE_WIDTH-120)/2,220.0,120.0,120.0)];
    
    UILabel *wirteAcivity = [[UILabel alloc]initWithFrame:CGRectMake(0,10, activityIndicatorView.frame.size.width,20)];
    wirteAcivity.text =@"等待加载";
    wirteAcivity.font = [UIFont systemFontOfSize:10.0];
    wirteAcivity.textColor = [UIColor whiteColor];
    wirteAcivity.textAlignment = NSTextAlignmentCenter;
    
    [activityIndicatorView addSubview:wirteAcivity];
    
    activityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleWhiteLarge;
    
    activityIndicatorView.backgroundColor = [UIColor colorWithRed:155/255.0
                                                            green:155/255.0
                                                             blue:155/255.0
                                                            alpha:0.8];;//155
    [activityIndicatorView.layer setMasksToBounds:YES];
    [activityIndicatorView.layer setCornerRadius:5.0];
    
    [self segmentViewFunc];
    [self indexViewControllerFunc];

}


-(void)segmentViewFunc{

    NSArray *items = @[@"全部",@"未支付",@"已支付",@"已完成"];
    sc = [[UISegmentedControl alloc]initWithItems:items]; //用文字数组初始化
    sc.frame = CGRectMake(0, 64, SIZE_WIDTH, 30);
    sc.selectedSegmentIndex = 0;
    
    [sc addTarget:self action:@selector(SeqmentedChange:) forControlEvents:UIControlEventValueChanged];
    
    sc.tintColor = [UIColor clearColor];//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0],
                                             NSForegroundColorAttributeName: [UIColor redColor]};
    [sc setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0],
                                               NSForegroundColorAttributeName: [UIColor blackColor]};
    [sc setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];

    [self.view addSubview:sc];

}


-(void)indexViewControllerFunc{
  
    
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0,94, SIZE_WIDTH, SIZE_HEIGHT)];
    backgroundView.backgroundColor = [UIColor clearColor];
    
   [self.view addSubview:backgroundView];
    
    
    
    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:backgroundView.bounds];
    imageTableView.image = [UIImage imageNamed:@"timelogo.png"];
    
    //定义表示图 表示图的样式为分组视图
    TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH,SIZE_HEIGHT-142) style:UITableViewStylePlain];
    TableView.delegate = self;
    TableView.dataSource = self;
    TableView.backgroundView = imageTableView;
    TableView.showsVerticalScrollIndicator = NO;
    [TableView setSeparatorColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.4]];
    
    if ([TableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [TableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([TableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [TableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(refreshView:)
              forControlEvents:UIControlEventValueChanged];
    [_refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
    [TableView addSubview:_refreshControl];

    
    [backgroundView addSubview:TableView];


}


#pragma mark 第section组一共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return cellArray.count;
    
    
}

#pragma mark -下拉刷新

-(void)refreshView:(UIRefreshControl *)sender{

  
    [self readyOrderlist:type];
    [sender endRefreshing];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *IdentifierCell = @"BeautifulTimeCell";
    
    UITableViewCell *cell  =  [tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    
    if (cell == nil) {
        //不存在的cell
        //创建新的cel
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IdentifierCell];
        
    }
    
    while ([cell.contentView.subviews lastObject] != nil)
    {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
   // NSLog(@"cellArray---%@",cellArray);
 
    if (cellArray==nil) {
        
        NSLog(@"sno");
    
    }else{
  
    //订单状态表示
    NSInteger or_status = [[[cellArray objectAtIndex:indexPath.row] valueForKey:@"status"] intValue];
    NSInteger or_guoqi = [[[cellArray objectAtIndex:indexPath.row] valueForKey:@"guoqi"] intValue];

    
    UIView *cellBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, cell_Height)];
    
    UIView *lineBackfroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 10)];
    lineBackfroundView.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.4];
    
    [cellBackgroundView addSubview:lineBackfroundView];
    
    
    //订单时间
    UILabel *OrderTime = [[UILabel alloc]initWithFrame:CGRectMake(10,10, (SIZE_WIDTH-20)/2, 25)];
    OrderTime.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    OrderTime.font = [UIFont systemFontOfSize:12.0];
    OrderTime.text= [[cellArray objectAtIndex:indexPath.row] valueForKey:@"order_time"];
    
    [cellBackgroundView addSubview:OrderTime];
    
    //订单状态
    NSString *or_StatusStr = [self OrderStatusFunc:or_status guoqi:or_guoqi];

    UILabel *orderStatus = [[UILabel alloc]initWithFrame:CGRectMake((SIZE_WIDTH-20)/2+10, 10,(SIZE_WIDTH-20)/2, 25)];
    orderStatus.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:0.6];
    orderStatus.font = [UIFont systemFontOfSize:12.0];
    orderStatus.textAlignment = NSTextAlignmentRight;
    orderStatus.text= [NSString stringWithFormat:@"%@",or_StatusStr];
   
    [cellBackgroundView addSubview:orderStatus];
    
    //分割线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 35, SIZE_WIDTH, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.4];
    [cellBackgroundView addSubview:lineView];
    
    //产品图片
    AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(10,45, 60, 60)];
    asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
    asynImageView.imageURL=[NSString stringWithFormat:@"%@",[[cellArray objectAtIndex:indexPath.row] valueForKey:@"main_img"]];
    asynImageView.imageURL = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],asynImageView.imageURL];
    asynImageView.contentMode=UIViewContentModeScaleToFill;

    [cellBackgroundView addSubview:asynImageView];
        
    //产品名称
    UILabel *ProductName = [[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width+25,40, SIZE_WIDTH-asynImageView.frame.size.width-10-25, 20)];
    ProductName.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
    ProductName.font = [UIFont systemFontOfSize:14.0];
    ProductName.text= [[cellArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    [cellBackgroundView addSubview:ProductName];
    
    //订单号
    UILabel *OrderNum = [[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width+25,60, SIZE_WIDTH-asynImageView.frame.size.width-10-25, 20)];
    OrderNum.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.6];
    OrderNum.font = [UIFont systemFontOfSize:12.0];
    OrderNum.text = [NSString stringWithFormat:@"订单编号:%@",[[cellArray objectAtIndex:indexPath.row] valueForKey:@"oid"]];
    
    [cellBackgroundView addSubview:OrderNum];
    
    //服务时间
    UILabel *OrderServerTime = [[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width+25,75, SIZE_WIDTH-asynImageView.frame.size.width-10-25, 20)];
    OrderServerTime.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.6];
    OrderServerTime.font = [UIFont systemFontOfSize:12.0];
    OrderServerTime.text = [NSString stringWithFormat:@"服务时间:%@",[[cellArray objectAtIndex:indexPath.row] valueForKey:@"bespoke_time"]];
    
    [cellBackgroundView addSubview:OrderServerTime];
    
    //数量
    UILabel *Orderpro_color = [[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width+25,90, SIZE_WIDTH-asynImageView.frame.size.width-10-25, 20)];
    Orderpro_color.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.6];
    Orderpro_color.font = [UIFont systemFontOfSize:12.0];
    Orderpro_color.text = [NSString stringWithFormat:@"%@",[[cellArray objectAtIndex:indexPath.row] valueForKey:@"product_number"]];
    
    [cellBackgroundView addSubview:Orderpro_color];
    
    //分割线
    UIView *lineView_2 = [[UIView alloc]initWithFrame:CGRectMake(0, 115, SIZE_WIDTH, 1)];
    lineView_2.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.4];
    [cellBackgroundView addSubview:lineView_2];

    
    //订单价格
    UILabel *OrderPrice = [[UILabel alloc]initWithFrame:CGRectMake(10,120, (SIZE_WIDTH-20)/2, 25)];
    OrderPrice.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.6];
    OrderPrice.font = [UIFont systemFontOfSize:12.0];
    OrderPrice.textColor = [UIColor colorWithRed:246/255.0 green:129/255.0 blue:43/255.0 alpha:0.8];
    OrderPrice.text= [NSString stringWithFormat:@"共 %@ 件产品 合计¥ %@元",[[cellArray objectAtIndex:indexPath.row] valueForKey:@"product_number"],[[cellArray objectAtIndex:indexPath.row] valueForKey:@"totalprice"]];
    
    [cellBackgroundView addSubview:OrderPrice];

    //再次订购按钮
    
    NSArray *arrayButStatus = [self OrderStatusButFunc:or_status guoqi:or_guoqi];
    
  //  NSLog(@"dictButStatus%@",arrayButStatus);
 
    NSInteger but_Status = [[arrayButStatus objectAtIndex:1] intValue];

    if(but_Status==1){
        
        UIButton *alignbut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        alignbut.frame = CGRectMake(SIZE_WIDTH-80,122, 70, 22);
        [alignbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        alignbut.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [alignbut setTitle:[arrayButStatus objectAtIndex:0] forState:UIControlStateNormal];
        alignbut.backgroundColor = [UIColor colorWithRed:218/255.0 green:92/255.0 blue:92/255.0 alpha:0.9];
         alignbut.tag = indexPath.row;
        [alignbut addTarget:self action:@selector(GoToButtonConFunc:) forControlEvents:UIControlEventTouchUpInside];
        [cellBackgroundView addSubview:alignbut];
        
        
        [cell.contentView addSubview:cellBackgroundView];
        
    }

    if(but_Status==2){
        
        UIButton *alignbut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        alignbut.frame = CGRectMake(SIZE_WIDTH-80,122, 70, 22);
        [alignbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        alignbut.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [alignbut setTitle:[arrayButStatus objectAtIndex:0] forState:UIControlStateNormal];
        alignbut.backgroundColor = [UIColor colorWithRed:218/255.0 green:92/255.0 blue:92/255.0 alpha:0.9];
        alignbut.tag = indexPath.row;

        [cellBackgroundView addSubview:alignbut];

        [alignbut addTarget:self action:@selector(PayButtonFunc:) forControlEvents:UIControlEventTouchUpInside];
            
     }
        if(but_Status==3){
            
            UIButton *alignbut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            alignbut.frame = CGRectMake(SIZE_WIDTH-80,122, 70, 22);
            [alignbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            alignbut.titleLabel.font = [UIFont systemFontOfSize:12.0];
            [alignbut setTitle:[arrayButStatus objectAtIndex:0] forState:UIControlStateNormal];
            alignbut.backgroundColor = [UIColor colorWithRed:218/255.0 green:92/255.0 blue:92/255.0 alpha:0.9];
            alignbut.tag = indexPath.row;
            
            [cellBackgroundView addSubview:alignbut];
            
       //     [alignbut addTarget:self action:@selector(WIthsButtonFunc:) forControlEvents:UIControlEventTouchUpInside];
            
        }

   [cell.contentView addSubview:cellBackgroundView];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return cell_Height;

}

-(void)viewWillAppear:(BOOL)animated{

     //判断用户是否登陆 没有登陆 显示提示登录界面
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderInternetResult:) name:@"interNet" object:nil];
    
    //登陆成功发送通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginOrderJT:) name:@"LoginOrderJT" object:nil];
    
    NSLog(@"----%@",[USER_DEFAULT valueForKey:@"UserName"]);


    if ([USER_DEFAULT valueForKey:@"UserName"]== NULL) {
     
        NSLog(@"没有登陆");
        loginImageView.hidden = NO;
        sc.hidden=YES;
        backgroundView.hidden=YES;
        
    }else{
    
        NSLog(@"已经登陆");
        loginImageView.hidden = YES;
        sc.hidden=NO;
        backgroundView.hidden=NO;
        
        NSLog(@"[USER_DEFAULT]%@",[USER_DEFAULT valueForKey:@"user_id"]);
     
        [self.view addSubview:activityIndicatorView ];

        

            //删除子视图
      //      [[self.view.subviews objectAtIndex:0] removeFromSuperview];
        
        
        [activityIndicatorView startAnimating];
        
        [self readyOrderlist:@"null"];
        //停止
        
    }
}

-(void)LoginFunc{

    loginImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT)];
    loginImageView.tag = 1;
    loginImageView.userInteractionEnabled = YES ;
    loginImageView.image = [UIImage imageNamed:@"timelogo.png"];
    
    
    UIImageView *headerImagelogo=[[UIImageView alloc]init];
    
    headerImagelogo.frame = CGRectMake((SIZE_WIDTH-120)/2,140,120, 120);
        
    headerImagelogo.image=[UIImage imageNamed:@"userinfo_logoYes.png"];
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake((SIZE_WIDTH-120)/2,260, 120, 30)];
    headerImagelogo.userInteractionEnabled = YES;
    userName.textColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:0.9];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.text = @"请点击头像登陆";
    userName.font = [UIFont systemFontOfSize:12.0];
    
    [loginImageView addSubview:userName];
    
    [loginImageView addSubview:headerImagelogo];

    UITapGestureRecognizer *logintap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginCon:)];
    [headerImagelogo addGestureRecognizer:logintap];
    
    [self.view addSubview:loginImageView];

}


#pragma mark -调出登陆界面
-(void)loginCon:(id)sender{

    loginCon=[[LoginController alloc]init];
    loginNav=[[UINavigationController alloc]initWithRootViewController:loginCon];
    loginNav.hidesBottomBarWhenPushed = YES;
    [self presentViewController:loginNav animated:YES completion:^{
        
    }];

}

#pragma mark -订单状态对比
#pragma mark -订单列表  0-未支付 1-已支付 3-已完成  过期参数 guoqi 0-未过期 1-已过期  product_number参数含义-购买数量
-(NSString *)OrderStatusFunc:(NSInteger)status guoqi:(NSInteger)guoqi{
    
    //使用前先初始化
    NSString *resultStr = @"";
    
    if(status == 0){
        
        if (guoqi == 0) {
            
            //已经过期
            resultStr = @"已过期";
            
        }else{
        
            //没有过期
            resultStr = @"等待付款";
        
        }
        
    }else if(status == 1){
        
        resultStr = @"已支付";
        
    }else if (status == 3){
        
        resultStr = @"已完成";
    
    }else{
    
        resultStr = @"";
    
    }

    return resultStr;
}

#pragma mark -按钮文字状态和事件方法
#pragma mark -订单列表  0-未支付 1-已支付 3-已完成  过期参数 guoqi 0-未过期 1-已过期  product_number参数含义-购买数量

#pragma mark -自定义按钮事件标示 1 -再次购买(去下单页面) 2 -去支付(去支付页面) 3 －等待服务(不加按钮事件)
-(NSArray *)OrderStatusButFunc:(NSInteger)status guoqi:(NSInteger)guoqi{
    
    //使用前先初始化
    NSArray *OrderButStatus = [[NSArray alloc]init];
    NSString *ButTitle =@"";
    NSString *ButStatus =@"" ;
    if(status == 0){
        
        if (guoqi == 0) {
            
            //已经过期
            ButTitle = @"再次购买";
            ButStatus = @"1";
            
        }else{
            
            //没有过期

            ButTitle = @"去支付";
            ButStatus = @"2";
            
        }
        
    }else if(status == 1){
        
        ButTitle = @"等待服务";
        ButStatus = @"3";
        
    }else if (status == 3){
        
        ButTitle = @"再次购买";
        ButStatus = @"1";
        
    }else{
        
        ButTitle = NULL;
        ButStatus = @"5";
        
    }
    
    OrderButStatus =@[ButTitle,ButStatus];
    
    return OrderButStatus;
}

#pragma mark -分段按钮事件
-(void)SeqmentedChange:(UISegmentedControl *)sender{


    type =@"null";
    switch (sender.selectedSegmentIndex) {
        case 0:
            

            break;

        case 1:
            
            type =@"0";
            break;

        case 2:
            
            type =@"1";

            break;

        case 3:
            
            type =@"3";

            break;

        default:
            break;
    }
    [activityIndicatorView startAnimating];
    [self readyOrderlist:type];

}


#pragma mark -读取订单信息列表
-(void)readyOrderlist:(NSString *)types{

    NSDictionary *parameters=[[NSDictionary alloc]init];
    
    if ([types isEqualToString:@"null"]) {
        
        parameters  =@{@"user_id":[USER_DEFAULT valueForKey:@"user_id"]};
    
    }else if([types isEqualToString:@"0"]){
    
    
        parameters  =@{@"user_id":[USER_DEFAULT valueForKey:@"user_id"],@"type":type};

    }else if([types isEqualToString:@"1"]){
    
        parameters  =@{@"user_id":[USER_DEFAULT valueForKey:@"user_id"],@"type":type};
    
    }else if([types isEqualToString:@"3"]){
    
        
         parameters  =@{@"user_id":[USER_DEFAULT valueForKey:@"user_id"],@"type":type};
    
    }else{

         parameters  =@{@"user_id":[USER_DEFAULT valueForKey:@"user_id"]};
    
    }

    //创建字典参数列表
  //  NSLog(@"user_id%@",[USER_DEFAULT valueForKey:@"user_id"]);
    
    //拼接地址
    NSString *strUlr = service_order_list;
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
        
        cellArray = responseObject;
        
        [activityIndicatorView stopAnimating];
        
        [TableView reloadData];
 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [activityIndicatorView stopAnimating];
    }];
}


#pragma mark -订单栏中按钮的跳转方法
-(void)GoToButtonConFunc:(UIButton *)sender{


    UIButton *butTap = sender;
    
    ProductInfoController *productCon = [[ProductInfoController alloc]init];
    
    productCon.Product_id =  [[cellArray objectAtIndex:butTap.tag] valueForKey:@"product_id"];
    
    productCon.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:productCon animated:YES];

}

#pragma mark-在次支付

-(void)PayButtonFunc:(UIButton *)sender{

    UIButton *butTap = sender;

    NewPayProController *AignPaytCon = [[NewPayProController alloc]init];
    
    AignPaytCon.Pro_id =  [[cellArray objectAtIndex:butTap.tag] valueForKey:@"product_id"];
    AignPaytCon.orderProDictInfo = [cellArray objectAtIndex:butTap.tag];
    AignPaytCon.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:AignPaytCon animated:YES];

}

#pragma mark -拨打电话方法
-(void)OrdertellConFunc:(id)sender{
    
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    NSString *tel = [NSString stringWithFormat:@"tel:%@",[USER_DEFAULT valueForKey:@"phone"]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tel]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}

#pragma mark -网络监听方法
-(void)orderInternetResult:(NSNotification *)sender{
   
    NSMutableDictionary *objarray =(NSMutableDictionary *)[sender userInfo];
    
    NSLog(@"objarray%@",[objarray valueForKey:@"notNet"]);
    NSString *NetStatys = [objarray valueForKey:@"notNet"];
    netStatus = NetStatys;
  
    if ([NetStatys isEqualToString:@"notNet"]) {
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络异常!请检查您的网络" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
       
        [self presentViewController:alertCon animated:YES completion:nil];
      
    }else{
    
        if ([USER_DEFAULT valueForKey:@"UserName"]== NULL) {
            
            NSLog(@"没有登陆");
            loginImageView.hidden =NO;
            
        }else{
            
            loginImageView.hidden = YES;
            
                //删除子视图
                //      [[self.view.subviews objectAtIndex:0] removeFromSuperview];
       
            [activityIndicatorView startAnimating];
            [self readyOrderlist:@"null"];
        }
 
    }
    
}

#pragma mark -登陆监听
-(void)LoginOrderJT:(NSNotification *)nsnotification{

    NSLog(@"登陆了");
    
        loginImageView.hidden = YES;
        
        
        
        //删除子视图
        //      [[self.view.subviews objectAtIndex:0] removeFromSuperview];
        
  
    
    [self readyOrderlist:@"null"];



}


@end

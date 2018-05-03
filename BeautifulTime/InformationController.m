//
//  InformationController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/11.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "InformationController.h"

@interface InformationController ()

@end

@implementation InformationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"资讯";
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = ConTitleView;
    
    
    UIButton *LeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LeftBack.frame =CGRectMake(0, 0, 30, 30);
    [LeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    LeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [LeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];

    [LeftBack addTarget:self action:@selector(BackConFuncinfo:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc]initWithCustomView:LeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftBarButton;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    
    tff = [[TFFDictClass alloc]init];
    
    [self ShowTabViewDataFunc];
    
    
    sid = NULL;
//    NSArray* fontArrays = [[NSArray alloc] initWithArray:[UIFont familyNames]];
//    for(NSString* temp in fontArrays) {
//        NSLog(@"Font name  = %@", temp);
//    }
    
    fontArray = @[@"\U0000e612",@"\U0000e602",@"\U0000e615",@"\U0000e69c",@"\U0000e60a",@"\U0000e60d"];

//

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
//    [self getinformationListFunc];
//    [self  getinfoListfunc:sid];

}

-(void)ShowTabViewDataFunc{
    
    cellArray  = [[NSMutableArray alloc]init];

    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    imageTableView.image = [UIImage imageNamed:@"timelogo.png"];
    
    TabView = [[UITableView alloc]initWithFrame:CGRectMake(0,64,SIZE_WIDTH, SIZE_HEIGHT-64-49) style:UITableViewStylePlain];
    TabView.backgroundView = imageTableView;
    TabView.dataSource = self;
    TabView.delegate   = self;
    TabView.showsHorizontalScrollIndicator = NO;
    TabView.showsVerticalScrollIndicator = NO;
    TabView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //定义 TableView 分割线颜色
    [TabView setSeparatorColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.4]];
    
    if ([TabView respondsToSelector:@selector(setSeparatorInset:)]) {
        [TabView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([TabView respondsToSelector:@selector(setLayoutMargins:)]) {
        [TabView setLayoutMargins:UIEdgeInsetsZero];

    }
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(refreshView:)
              forControlEvents:UIControlEventValueChanged];
    [_refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
    [TabView addSubview:_refreshControl];
    
    [self.view addSubview:TabView];

}

#pragma mark -下拉刷新方法 
-(void)refreshView:(id)sender{

    NSLog(@"下拉刷新");
    
  //  [self getinformationListFunc];
    [sender endRefreshing];

}

#pragma mark -tabview协议方法
#pragma mark -返回有个section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}

#pragma mark  -返回每块一共有多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;

}

#pragma mark -返回每个cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //定义静态cell的静态名称
    
    static NSString *cellname = @"idefentCell";
    //判断该cell是否存在
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellname];
    
    if(cell == nil){
    
    
        //如果不存在就创建一个新的cell 并且新的cell的名称是重用机制中cell 的静态名称
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellname];
        
    }
    
    //如果重用了cell 把cell里面的contengView的内容清空
    while ([[cell.contentView subviews] count]>0) {
        
        //如果contentView中的子视图数量不是0 就说明有子视图
        [[[cell.contentView subviews] objectAtIndex:0]
         removeFromSuperview];
        
    }
    
    if (indexPath.row == 0) {


        UIImageView *zixun_oneImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 200)];
        zixun_oneImage.image = [UIImage imageNamed:@"zixun.png"];
        [cell.contentView addSubview:zixun_oneImage];
        
    }else if(indexPath.row ==1){

        UIImageView *zixun_oneImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 140)];
        zixun_oneImage.image = [UIImage imageNamed:@"zixun_1.png"];
        [cell.contentView addSubview:zixun_oneImage];
        
    
    }else if(indexPath.row == 2){
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 5)];
        view.backgroundColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:0.2];
        [cell.contentView addSubview:view];
        
    }else{
    
        //产品图片
//        AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(10, 8, 60, 65)];
//        asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
//        asynImageView.imageURL=[NSString stringWithFormat:@"%@",[[newlist objectAtIndex:indexPath.row-2] valueForKey:@"url"]];
//        asynImageView.imageURL = [NSString stringWithFormat:@"%@%@",@"http://fx.lzspa.com:8088",asynImageView.imageURL];
//        asynImageView.contentMode=UIViewContentModeScaleToFill;
        UIImageView *asynImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
        asynImageView.image = [UIImage imageNamed:@"zixun_img.png"];
        asynImageView.layer.cornerRadius = 10;
        asynImageView.layer.masksToBounds = true;
        asynImageView.layer.borderColor = [[UIColor whiteColor]CGColor];
        asynImageView.layer.borderWidth = 1;

        [cell.contentView addSubview:asynImageView];
        
        //资讯标题
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width + 20, 10, SIZE_WIDTH-asynImageView.frame.size.width-10-25,30)];
        titleLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        //titleLabel.text= [[newlist objectAtIndex:indexPath.row-2] valueForKey:@"NAME"];
        titleLabel.text= @"时光月子中心,打造后产科时代";
        
        //资讯内容
        UILabel *ProductinfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width + 20, 5+titleLabel.frame.size.height, SIZE_WIDTH-asynImageView.frame.size.width-10-25,50)];
        ProductinfoLabel.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.6];
        ProductinfoLabel.font = [UIFont systemFontOfSize:14.0];
        ProductinfoLabel.numberOfLines=0;
       // ProductinfoLabel.text= [[newlist objectAtIndex:indexPath.row-2] valueForKey:@"summary"];
        ProductinfoLabel.text= @"有首英文歌女生唱的。MV里是有洗车场,最后发现她喜欢的那个男... 39 2015-09-25 女主角喜欢一个帅气的男人 结果到后面发现他是同性恋 这是哪.";
        
        
        //发布时间
        
//        UILabel *ProductPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width + 25, 2+titleLabel.frame.size.height+ProductinfoLabel.frame.size.height, SIZE_WIDTH-asynImageView.frame.size.width-10-25, 25)];
//        ProductPriceLabel.textColor = [UIColor colorWithRed:200/255.0 green:13/255.0 blue:52/255.0 alpha:0.6];
//        ProductPriceLabel.font = [UIFont systemFontOfSize:14.0];
//        ProductPriceLabel.text= [[newlist objectAtIndex:indexPath.row-2] valueForKey:@"create_time"];
        
        
        [cell.contentView addSubview:asynImageView];
        [cell.contentView addSubview:titleLabel];
        [cell.contentView addSubview:ProductinfoLabel];
       // [cell.contentView addSubview:ProductPriceLabel];

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;


}

#pragma mark -返回每一行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
        return 200;
        
    }
    if (indexPath.row == 1) {
        
        return 140;
        
    }
    if (indexPath.row == 2) {
        
        return 5;
    }
    return 100;

}

#pragma mark -导航栏自定返回按钮返回事件

-(void)BackConFuncinfo:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];

}


//实现代理类
#pragma mark -返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

#pragma mark -返回每个分区中cell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return infoArray.count;
    
}

#pragma mark -返回每个collectionCell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];

    //如果重用了cell 把cell里面的contengView的内容清空
    while ([[cell.contentView subviews] count]>0) {
        
        //如果contentView中的子视图数量不是0 就说明有子视图
        [[[cell.contentView subviews] objectAtIndex:0]
         removeFromSuperview];
        
    }

     cell.backgroundColor = [UIColor whiteColor];

    UILabel *imageCell = [[UILabel alloc]initWithFrame:CGRectMake((SIZE_WIDTH/3 - 50)/2, 5, 50, 50)];
    imageCell.textColor = [UIColor redColor];
    imageCell.font = [UIFont fontWithName:@"iconfont" size:30.0];
    imageCell.textAlignment = NSTextAlignmentCenter;
    imageCell.text = [tff getDictFont:[[infoArray objectAtIndex:indexPath.row] valueForKey:@"img_url"]];

    
    UILabel *TitleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, imageCell.frame.size.height+5,cell.frame.size.width, 20)];
    TitleLable.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
    TitleLable.textAlignment = NSTextAlignmentCenter;
    TitleLable.font = [UIFont systemFontOfSize:14.0];
    TitleLable.text = [[infoArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    
    [cell.contentView addSubview:imageCell];
    [cell.contentView addSubview:TitleLable];

    
    return cell;
    
}

#pragma mark -TableView选择事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0 || indexPath.row == 1) {
        return;
    }
    InfoMessageController *infoCon = [[InfoMessageController alloc]init];
    infoCon.infomentID = [[newlist objectAtIndex:indexPath.row-2] valueForKey:@"id"];
    [self.navigationController pushViewController:infoCon animated:YES];
    NSLog(@"xy");

}

#pragma mark -UICollectionView选择事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"indexColl%ld",(long)indexPath.row);
    sid = [[infoArray objectAtIndex:indexPath.row] valueForKey:@"id"];
  //  [self getinfoListfunc:sid];

}


#pragma mark - 获取资讯分类列表

-(void)getinformationListFunc{

//    //添加参数
//    
////    NSDictionary *parameters=@{@"user_id":[USER_DEFAULT objectForKey:@"user_id"]};
//    NSString *service_news = service_news_type;
//    NSString *strurGetAddressUrl=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],service_news];
//    
//    //创建请求
//    manager = [AFHTTPSessionManager manager];
//    
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
//    
//    //发送POST请求
//    
//    [manager POST:strurGetAddressUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        infoArray = [[NSMutableArray alloc]initWithArray:responseObject];
//        
//        NSLog(@"responseObject%@",infoArray);
//        
//       // [collection reloadData];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
}

#pragma mark -获取资讯列表
-(void)getinfoListfunc:(NSString *)ssid{
    
//    NSDictionary *parameters = nil;
//    NSString *service_news = service_news_list;
//    NSString *service_new_url = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],service_news];
//    if (ssid != NULL) {
//        
//        NSLog(@"ssid%@",ssid);
//        parameters=@{@"type":ssid};
//       
//      
//    }
//
//    
//      //发送POST请求
//    [manager POST:service_new_url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        newlist = [[NSMutableArray alloc]initWithArray:responseObject];
//        NSLog(@"newlist------%@",newlist);
//        [TabView reloadData];
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"失败");
//    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

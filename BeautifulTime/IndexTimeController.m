//
//  IndexTimeController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#define cell_height 60.0;

#import "IndexTimeController.h"
#import "ScrollView.h"
#import "ProductInfoController.h"
#import "InformationController.h"
#import "indexScrollerController.h"
#import "CorporateController.h"
#import "BookingController.h"
#import "CollectionView.h"
#import "CollectionOneController.h"
#import "ShareController.h"


@interface IndexTimeController ()<PagedFlowViewDelegate,PageCollectionDelegate>{

    dispatch_source_t _timer;

}

@end

@implementation IndexTimeController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
//    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
//    indexLabel.text = @"大肚婆";
//    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
//    indexLabel.textColor = [UIColor blackColor];
//    indexLabel.textAlignment = NSTextAlignmentCenter;
    
    CGRect mainViewBounds = self.navigationController.view.bounds;
    customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+22, CGRectGetWidth(mainViewBounds)-120, 40)];
   // customSearchBar.text=;
    customSearchBar.placeholder = @"搜索项目,专家,资讯";
    UITextField * searchField = [customSearchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    customSearchBar.delegate = self;
    customSearchBar.showsCancelButton = NO;
    customSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    self.navigationItem.titleView = customSearchBar;

    UIButton *LeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    LeftBack.frame =CGRectMake(0, 0,60, 30);
    [LeftBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    LeftBack.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [LeftBack setTitle:@"大肚婆" forState:UIControlStateNormal];
    
 //   [LeftBack addTarget:self action:@selector(aBackConFunc:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc]initWithCustomView:LeftBack];
    self.navigationItem.leftBarButtonItem = LeftBarButton;

    
    UIButton *RightBack = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBack.titleLabel.font = [UIFont systemFontOfSize:12.0];
    RightBack.frame = CGRectMake(0, 0, 30, 30);
    [RightBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    RightBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:14];
    [RightBack setTitle:@"\U0000e60a" forState:UIControlStateNormal];
    [RightBack addTarget:self action:@selector(tellConFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBack];
    
    self.navigationItem.rightBarButtonItem = RightButtonItem;

    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
 
    isHot = @"rq";
   
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


    @try {
        //加载方法
        [self indexViewControllerFunc];
        [self datafunc];
         
    } @catch (NSException *exception) {
       
    }
   
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InternetResult:) name:@"interNet" object:nil];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)datafunc{

    @try {
        
        //启动
//        [self.view addSubview:activityIndicatorView ];
//        
//        [activityIndicatorView startAnimating];
        
        [self GetHttpsDataFunManager];
        [self GetHttpsMenuDataFunManager];
        [self GetHttpsDataProductslist];
   
    }
    @catch (NSException *exception) {
        
        NSLog(@"异常处理");
    }
    @finally {
        
        NSLog(@"一定要执行");
        
    }

}

-(void)indexViewControllerFunc{
    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:CGRectMake(9, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    imageTableView.image = [UIImage imageNamed:@"timelogo.png"];

    //定义表示图 表示图的样式为分组视图
    TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT-64-50) style:UITableViewStylePlain];
    TableView.delegate = self;
    TableView.dataSource = self;
    TableView.backgroundView = imageTableView;
    TableView.showsVerticalScrollIndicator = NO;
    [TableView setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                  green:145/255.0
                                                   blue:145/255.0
                                                  alpha:0.2]];

    if ([TableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [TableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([TableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [TableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(refreshViewindex:)
              forControlEvents:UIControlEventValueChanged];
    [_refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
    [TableView addSubview:_refreshControl];

    
    [self.view addSubview:TableView];
}

-(void)refreshViewindex:(UIRefreshControl *)sender{

    NSLog(@"la");
    [self  GetHttpsDataProductslist];
    [self GetHttpsMenuDataFunManager];
    [self GetHttpsDataFunManager];
    [sender endRefreshing];

}

#pragma mark 第section组一共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return cellArray.count+4;

   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
//    CGFloat meunLogosize = 55.0;
//    CGFloat LabelLogosize = 65.0;

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
    
    if (indexPath.row == 0) {
        
        UIView *cellView = [[UIView alloc]init];
        cellView.frame=CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT*0.26);
        scro = [[ScrollView alloc]initWithFrame:cellView.frame imageViewArray:scroArray];
        scro.delegates = self;
        [cellView addSubview:scro];
        [cell.contentView addSubview:cellView];
        
    }else if (indexPath.row == 1) {

        CollectionView *conView=[[CollectionView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 136)];
        conView.delegates=self;
        [cell.contentView addSubview:conView];
        
    }else if (indexPath.row == 2) {
        
        UIView *LeftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH*0.5, 170)];
        LeftView.backgroundColor=[UIColor colorWithRed:147/255.0
                                                 green:145/255.0
                                                  blue:145/255.0
                                                 alpha:0.1];
        
//        UIImageView *leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LeftView.frame.size.width-1, LeftView.frame.size.height)];
//        leftImageView.image=[UIImage imageNamed:@"dd_1.png"];
        
        AsynImageView *leftImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(0, 0, LeftView.frame.size.width-1, LeftView.frame.size.height)];
        NSString *imageUrl_0 = [NSString stringWithFormat:@"%@%@small.jpg",@"http://ddp.lzsg120.com",[[menuArray objectAtIndex:0] valueForKey:@"img"]];
        leftImageView.placeholderImage=[UIImage imageNamed:@"product_M.png"];
        leftImageView.imageURL = [NSString stringWithFormat:@"%@",imageUrl_0];
        leftImageView.layer.cornerRadius = 8;
        leftImageView.layer.masksToBounds = true;
        leftImageView.contentMode=UIViewContentModeScaleToFill;
        leftImageView.userInteractionEnabled=YES;
        leftImageView.tag=1;
        [LeftView addSubview:leftImageView];
        
        NSString *statuss=[NSString stringWithFormat:@"%@",[[menuArray objectAtIndex:0] valueForKey:@"STATUS"]];
        
        if ([statuss isEqualToString:@"1"]) {
  
            UIView *leftview =[self outtimefunc];
            [leftImageView addSubview:leftview];
        }
        
        UITapGestureRecognizer *tap_1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ZiXunControllerFunc:)];
        tap_1.view.tag = leftImageView.tag;
        [leftImageView addGestureRecognizer:tap_1];
        
        UIView *RightView=[[UIView alloc]initWithFrame:CGRectMake(SIZE_WIDTH*0.5, 0, SIZE_WIDTH*0.5, 170)];
        RightView.backgroundColor=[UIColor colorWithRed:147/255.0
                                                  green:145/255.0
                                                   blue:145/255.0
                                                  alpha:0.1];
        
        AsynImageView *RightmageTopView=[[AsynImageView alloc]initWithFrame:CGRectMake(0, 0, RightView.frame.size.width, RightView.frame.size.height/2-1)];
        
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@small.jpg",newurl,[[menuArray objectAtIndex:1] valueForKey:@"img"]];
        RightmageTopView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
        RightmageTopView.imageURL = [NSString stringWithFormat:@"%@",imageUrl];
        RightmageTopView.tag=2;
        RightmageTopView.layer.cornerRadius = 8;
        RightmageTopView.layer.masksToBounds = true;
        RightmageTopView.contentMode=UIViewContentModeScaleToFill;
        RightmageTopView.userInteractionEnabled=YES;
        [RightView addSubview:RightmageTopView];
        
        UITapGestureRecognizer *tap_2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ZiXunControllerFunc:)];
        tap_2.view.tag = 2;
        [RightmageTopView addGestureRecognizer:tap_2];
        
        AsynImageView *RightmageBottomView=[[AsynImageView alloc]initWithFrame:CGRectMake(0,RightView.frame.size.height/2, RightView.frame.size.width, RightView.frame.size.height/2)];
        NSString *imageUrl_2 = [NSString stringWithFormat:@"%@%@small.jpg",newurl,[[menuArray objectAtIndex:2] valueForKey:@"img"]];
        RightmageBottomView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
        RightmageBottomView.imageURL = [NSString stringWithFormat:@"%@",imageUrl_2];
        RightmageBottomView.tag=3;
        RightmageBottomView.layer.cornerRadius = 8;
        RightmageBottomView.layer.masksToBounds = true;
        RightmageBottomView.contentMode=UIViewContentModeScaleToFill;
        RightmageBottomView.userInteractionEnabled=YES;
        [RightView addSubview:RightmageBottomView];
        
        UITapGestureRecognizer *tap_3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ZiXunControllerFunc:)];
        tap_3.view.tag = RightmageBottomView.tag;
        [RightmageBottomView addGestureRecognizer:tap_3];
        
        [cell.contentView addSubview:LeftView];
        [cell.contentView addSubview:RightView];
        
    }

    else if (indexPath.row == 3) {
      
      
        UILabel *backGroundLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 5)];
        backGroundLable.backgroundColor =  [UIColor colorWithRed:147/255.0
                                                         green:145/255.0
                                                          blue:145/255.0
                                                         alpha:0.1];
       [cell.contentView addSubview:backGroundLable];
      
        UIView *MuneView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, SIZE_WIDTH, 40)];
        MuneView.backgroundColor = [UIColor whiteColor];
      
        selectBut_1 = [[UIButton alloc]init];
        [selectBut_1 setTitle:@"爆品抢购区" forState:UIControlStateNormal];
        selectBut_1.titleLabel.font = [UIFont systemFontOfSize:14.0];
      
      if ([isHot isEqualToString:@"rq"]) {
          
          [selectBut_1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
          
      }else{
      
          [selectBut_1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      
      }
      
        selectBut_1.frame=CGRectMake(0, MuneView.frame.size.height/2-10, MuneView.frame.size.width/2, 20);
        selectBut_1.tag = 1;
        [selectBut_1 addTarget:self action:@selector(selectButFunc:) forControlEvents:UIControlEventTouchUpInside];
        [MuneView addSubview:selectBut_1];
      
      //分割线
      
        selectBut_2 = [[UIButton alloc]init];
        [selectBut_2 setTitle:@"新品推荐区" forState:UIControlStateNormal];
      
         NSLog(@"isHot%@",isHot);
      
      if ([isHot isEqualToString:@"hot"]) {
          
          [selectBut_2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
          
      }else{
          
          [selectBut_2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          
      }

        selectBut_2.tag = 2;
        selectBut_2.titleLabel.font = [UIFont systemFontOfSize:14.0];
              selectBut_2.frame=CGRectMake(MuneView.frame.size.width/2, MuneView.frame.size.height/2-10, MuneView.frame.size.width/2, 20);
        [selectBut_2 addTarget:self action:@selector(selectButFunc:) forControlEvents:UIControlEventTouchUpInside];
        [MuneView addSubview:selectBut_2];

        [cell.contentView addSubview:MuneView];
      
    }
    
  else{
       //产品图片
      
//      UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, SIZE_WIDTH-10, 130)];
//      imageView.image=[UIImage imageNamed:@"pro_logo.png"];
//      imageView.layer.cornerRadius = 8;
//      imageView.layer.masksToBounds = true;
        NSString *proImageUrl = [NSString stringWithFormat:@"%@%@small.jpg",[USER_DEFAULT objectForKey:@"SERVERIP"],[[cellArray objectAtIndex:indexPath.row-4] valueForKey:@"main_img"]];
    AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(5, 5, SIZE_WIDTH-10, SIZE_WIDTH*0.5)];
    asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
    asynImageView.imageURL = [NSString stringWithFormat:@"%@",proImageUrl];
    asynImageView.clipsToBounds = YES;
    asynImageView.layer.cornerRadius = 8;
    asynImageView.layer.masksToBounds = true;;
    asynImageView.contentMode = UIViewContentModeScaleAspectFit;
    asynImageView.clipsToBounds=YES;
      
    float imageheight=asynImageView.frame.size.height;
    
      //产品名称
      //    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width + 25, 10, SIZE_WIDTH-asynImageView.frame.size.width-10-25, 25)];
      UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, imageheight+15, SIZE_WIDTH-20, 20)];
         titleLabel.textColor = [UIColor blackColor];
     //    titleLabel.font = [UIFont systemFontOfSize:14.0];
         [titleLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:14.0]];
         titleLabel.text= [[cellArray objectAtIndex:indexPath.row-4] valueForKey:@"title"];
      //产品介绍
//      NSString *strSummary=[NSString stringWithFormat:@"%@",[[cellArray objectAtIndex:indexPath.row-4] valueForKey:@"summary"]];
//      if ([strSummary isEqualToString:@"<null>"]) {
//          strSummary=@"";
//      }
//
//      UILabel *ProductinfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, imageheight+35, SIZE_WIDTH-20, 40)];
//      ProductinfoLabel.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:0.6];
//       [titleLabel setFont:[UIFont fontWithName:@"Arial" size:16.0]];
//      ProductinfoLabel.numberOfLines=0;
//      ProductinfoLabel.text= strSummary;
      
      
      //产品现价
      
      UILabel *ProductPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,imageheight+45, SIZE_WIDTH/4+10, 30)];
      ProductPriceLabel.textColor = [UIColor colorWithRed:252/255.0 green:94/255.0 blue:97/255.0 alpha:1.0];
      [ProductPriceLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16.0]];
      ProductPriceLabel.text= [NSString stringWithFormat:@"¥ %@.00",[[cellArray objectAtIndex:indexPath.row-4] valueForKey:@"price"]];
      
      //产品原价
      NSString *y_pricestr=[NSString stringWithFormat:@"%@",[[cellArray objectAtIndex:indexPath.row-4] valueForKey:@"y_price"]];
      if ([y_pricestr isEqualToString:@"<null>"]) {
          y_pricestr=@"";
      }else{
          y_pricestr = [NSString stringWithFormat:@"¥ %@.00",y_pricestr];
      }
      
      UILabel *FuProductPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4+20,imageheight+49, SIZE_WIDTH/4, 26)];
      FuProductPriceLabel.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
      [FuProductPriceLabel setFont:[UIFont fontWithName:@"Arial" size:14.0]];
      FuProductPriceLabel.text= y_pricestr;
      NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",FuProductPriceLabel.text]];
      [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
      
      FuProductPriceLabel.attributedText = newPrice;

      
//      //订购按钮
//      UIButton *paybut=[[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4*2.5, 210, SIZE_WIDTH/4, 25)];
//      [paybut setTitle:@"立即预订" forState:UIControlStateNormal];
//      paybut.titleLabel.font = [UIFont systemFontOfSize:14.0];
//      [paybut setBackgroundColor:[UIColor colorWithRed:255/255.0 green:42/255.0 blue:2/255.0 alpha:0.6]];
//      paybut.layer.cornerRadius = 8;
//      paybut.layer.masksToBounds = true;
      
      //订购按钮

      [cell.contentView addSubview:asynImageView];
      [cell.contentView addSubview:titleLabel];
    //  [cell.contentView addSubview:ProductinfoLabel];
      [cell.contentView addSubview:ProductPriceLabel];
      [cell.contentView addSubview:FuProductPriceLabel];
      NSLog(@"s------%@",[[cellArray objectAtIndex:indexPath.row-4] valueForKey:@"service_type"] );
      NSString *service_type = [NSString stringWithFormat:@"%@",[[cellArray objectAtIndex:indexPath.row-4] valueForKey:@"service_type"]];
      
      if ([service_type isEqualToString:@"1"]) {
          UIButton *paybut=[[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4*2.5+60, imageheight+50,65, 20)];
          [paybut setTitle:@"上门医疗" forState:UIControlStateNormal];
          paybut.titleLabel.font = [UIFont systemFontOfSize:12.0];
          [paybut setBackgroundColor:[UIColor colorWithRed:254/255.0 green:198/255.0 blue:115/255.0 alpha:1.0]];
          paybut.layer.cornerRadius = 4;
          paybut.layer.masksToBounds = true;
          [cell.contentView addSubview:paybut];
      }
      if ([service_type isEqualToString:@"2"]) {
          
          UIButton *daodianbut=[[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4*2.5+60, imageheight+50,65, 20)];
          [daodianbut setTitle:@"到院医疗" forState:UIControlStateNormal];
          daodianbut.titleLabel.font = [UIFont systemFontOfSize:12.0];
          [daodianbut setBackgroundColor:[UIColor colorWithRed:255/255.0 green:139/255.0 blue:148/255.0 alpha:1.0]];
          daodianbut.layer.cornerRadius = 4;
          daodianbut.layer.masksToBounds = true;
          [cell.contentView addSubview:daodianbut];
      }
      if ([service_type isEqualToString:@"3"]) {
          
          UIButton *paybut=[[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4*2.4, imageheight+50,65, 20)];
          [paybut setTitle:@"上门医疗" forState:UIControlStateNormal];
          paybut.titleLabel.font = [UIFont systemFontOfSize:12.0];
          [paybut setBackgroundColor:[UIColor colorWithRed:254/255.0 green:198/255.0 blue:115/255.0 alpha:1.0]];
          paybut.layer.cornerRadius = 4;
          paybut.layer.masksToBounds = true;

          [cell.contentView addSubview:paybut];
          
          UIButton *daodianbut=[[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4*2.4+75, imageheight+50,65, 20)];
          [daodianbut setTitle:@"到院医疗" forState:UIControlStateNormal];
          daodianbut.titleLabel.font = [UIFont systemFontOfSize:12.0];
          [daodianbut setBackgroundColor:[UIColor colorWithRed:255/255.0 green:139/255.0 blue:148/255.0 alpha:1.0]];
          daodianbut.layer.cornerRadius = 4;
          daodianbut.layer.masksToBounds = true;
          [cell.contentView addSubview:daodianbut];
          [cell.contentView addSubview:daodianbut];
      }  
  
  }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 选中cell的操作
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat rowHeight = SIZE_WIDTH*0.5+95 ;
    
    if (indexPath.row == 0) {
        
        rowHeight = SIZE_HEIGHT*0.26;
    }
    if (indexPath.row == 1) {
        
        rowHeight = 150;
    }
    if (indexPath.row==2) {
        
        rowHeight=170;
    }
    if (indexPath.row == 3) {
        
        rowHeight = 45;
    }
    
    return rowHeight;

}



#pragma mark -tableViewSelect选择事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   
    if (indexPath.row == 1) {
        
        return ;
    }
    if (indexPath.row == 2) {
        
        return ;
    }
    
    NSLog(@"netStatus%@",netStatus);
    
    if ([netStatus isEqualToString:@"notNet"]) {
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络异常!请检查您的网络" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
    }
    
    NSLog(@"cellArray%@",cellArray);
    if (cellArray==nil) {
        
        return;
    }
    
    
    ProductInfoController *productCon = [[ProductInfoController alloc]init];
    
    @try {
        
        productCon.Product_id =[[cellArray objectAtIndex:indexPath.row-4] valueForKey:@"id"];
        productCon.pric = [[cellArray objectAtIndex:indexPath.row-4] valueForKey:@"price"];
        productCon.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productCon animated:YES];

    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    

}

#pragma mark -列表选择按钮事件
-(void)ZiXunControllerFunc:(id)sender{

    
    UITapGestureRecognizer *tap=(UITapGestureRecognizer *)sender;
    NSInteger tapindex=tap.view.tag;
    NSLog(@"----tapindex--%ld",(long)tapindex);
//    NSString *url=NULL;
    NSString *strName;
    NSString *prostatus;
//    InformationController *informatCon = NULL;
    CollectionTowController *collTow=NULL;
    ProductInfoController *productCon = NULL;
//    CorporateController *CorporateCon =NULL;
//    BookingController *bookingCon=NULL;
    switch (tapindex) {
        case 1:

//            informatCon = [[InformationController alloc]init];
//            informatCon.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:informatCon animated:YES];
            prostatus=[NSString stringWithFormat:@"%@",[[menuArray objectAtIndex:0] valueForKey:@"STATUS"]];
            if ([prostatus isEqualToString:@"1"]) {
                
//                NSString *strUrl = [NSString stringWithFormat:@"%@",[[menuArray objectAtIndex:1] valueForKey:@"url"]];
               
                productCon = [[ProductInfoController alloc]init];
                productCon.Product_id =@"id";
                productCon.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:productCon animated:YES];
                
            }
            if ([prostatus isEqualToString:@"2"]) {
                
                strName=[NSString stringWithFormat:@"%@",[[menuArray objectAtIndex:0] valueForKey:@"NAME"]];
                collTow = [[CollectionTowController alloc]init];
                collTow.hidesBottomBarWhenPushed = YES;
                collTow.WebUrl = @"topic.htm?id=1&ios=1";
                collTow.titleName = strName;
                [self.navigationController pushViewController:collTow animated:YES];
                
            }
            
            break;
        case 2:
            
//            if ([USER_DEFAULT objectForKey:@"user_id"] != NULL){
                
//            url= [NSString stringWithFormat:@"%@%@?ios=1&user_id=%@",[USER_DEFAULT valueForKey:@"SERVERIP"],@"yuyue/yuyue.htm",[USER_DEFAULT valueForKey:@"user_id"]];
//            NSLog(@"url-----%@",url);
//            bookingCon = [[BookingController alloc]init];
//            bookingCon.hidesBottomBarWhenPushed = YES;
//            bookingCon.infomentID=url;
//            [self.navigationController pushViewController:bookingCon animated:YES];
//                
//            }else{
//            
//                 [self loginController];
//                
//            }
            strName=[NSString stringWithFormat:@"%@",[[menuArray objectAtIndex:1] valueForKey:@"NAME"]];
            collTow = [[CollectionTowController alloc]init];
            collTow.hidesBottomBarWhenPushed = YES;
            collTow.WebUrl = @"topic.htm?id=2&ios=1";
            collTow.titleName = strName;
            [self.navigationController pushViewController:collTow animated:YES];
            
            break;
        case 3:
            
//            url= [NSString stringWithFormat:@"%@%@?ios=1",[USER_DEFAULT valueForKey:@"SERVERIP"],@"qywh.htm"];
//           NSLog(@"url-----%@",url);
//            CorporateCon = [[CorporateController alloc]init];
//            CorporateCon.hidesBottomBarWhenPushed = YES;
//            CorporateCon.infomentID=url;
//            [self.navigationController pushViewController:CorporateCon animated:YES];

            strName=[NSString stringWithFormat:@"%@",[[menuArray objectAtIndex:2] valueForKey:@"NAME"]];
            collTow = [[CollectionTowController alloc]init];
            collTow.hidesBottomBarWhenPushed = YES;
            collTow.WebUrl = @"topic.htm?id=3&ios=1";
            collTow.titleName = strName;
            [self.navigationController pushViewController:collTow animated:YES];
            
            break;
        default:
            break;
    }

}

#pragma mark -调用登陆Controller
-(void)loginController{
    
    indexloginCon=[[LoginController alloc]init];
    indexloginNav=[[UINavigationController alloc]initWithRootViewController:indexloginCon];
    [self presentViewController:indexloginNav animated:YES completion:^{
        
    }];
    
}


#pragma mark -人气最热选择按钮事件
-(void)selectButFunc:(UIButton *)sender{

    UIButton *selectbut = sender;
    if (selectbut.tag == 1) {
        
        //人气
        isHot = @"rq";
        [self  GetHttpsDataProductslist];
        
        
   
    }else{
    
        //最热
        isHot = @"hot";
        [self  GetHttpsDataProductslist];
    }

}

#pragma mark -拨打电话方法
-(void)tellConFunc:(id)sender{


    UIWebView * callWebview = [[UIWebView alloc] init];
    NSString *tel = [NSString stringWithFormat:@"tel:%@",[USER_DEFAULT valueForKey:@"phone"]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tel]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];

}

#pragma mark -网络监听方法
-(void)InternetResult:(NSNotification *)sender{
    
    
    NSMutableDictionary *objarray =(NSMutableDictionary *)[sender userInfo];
    
    NSLog(@"objarray%@",[objarray valueForKey:@"interNet"]);
    NSString *NetStatys = [objarray valueForKey:@"interNet"];
    netStatus = NetStatys;

    if ([NetStatys isEqualToString:@"notNet"]) {
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络异常!请检查您的网络" preferredStyle:UIAlertControllerStyleAlert];
      
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];

    }else{
    
        
        if ([NetStatys isEqualToString:@"YesNet"]) {
            
            [self GetHttpsDataFunManager];
            [self GetHttpsMenuDataFunManager];
            [self GetHttpsDataProductslist];
        
        }

    }
}

-(void)didSelectItemAtIndex:(NSString *)indexUrl{

   // NSLog(@"---%@%@&ios=1",[USER_DEFAULT valueForKey:@"SERVERIP"],indexUrl);
    indexScrollerController *indexScro = [[indexScrollerController alloc]init];
    indexScro.hidesBottomBarWhenPushed = YES;
    indexScro.infomentID=[NSString stringWithFormat:@"%@&ios=1",indexUrl];
    [self.navigationController pushViewController:indexScro animated:YES];
    
}

#pragma mark -menujson数据解析
-(void)GetHttpsMenuDataFunManager{
    
    //定义请求路径
    
    NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
    if (URL == NULL) {
        
        URL = newurl;
    }
    
    NSString *Urladress = service_index_diy;
    NSString *strUrl =[NSString stringWithFormat:@"%@%@",URL,Urladress];
    //创建链接
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    
    [manager GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        menuArray  = responseObject;
        NSLog(@"menuArray%@----",menuArray);
        [TableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
    
}

#pragma mark -首页滚动图片JSON数据解析
-(void)GetHttpsDataFunManager{
    
    //定义请求路径
    
    NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
    if (URL == NULL) {
        
        URL = newurl;
    }
    
    NSString *Urladress = Index_SrcoImageUrl;
    NSString *strUrl =[NSString stringWithFormat:@"%@%@",URL,Urladress];
    //创建链接
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    [manager GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        scroArray = [[responseObject valueForKey:@"result"] objectAtIndex:0];
        [TableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark -产品数据json解析
-(void)GetHttpsDataProductslist{

    NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
    if (URL == NULL) {
        
        URL = newurl;
    }
    
    NSString *Urladress = Index_ProductList;
    NSString *strUrl =@"";
    
    NSLog(@"");
    
    if ([isHot isEqualToString:@"rq"]) {
        
        strUrl =[NSString stringWithFormat:@"%@%@",URL,Urladress];
        
    }else{
        
        strUrl =[NSString stringWithFormat:@"%@%@?%@",URL,Urladress,@"view_type=hot"];
        
    }
    //创建链接
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    [manager GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        cellArray  = responseObject;
        [TableView reloadData];
        
        //   [activityIndicatorView stopAnimating];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //    [activityIndicatorView stopAnimating];
        
    }];
}

-(void)CollectiondidSelectItemAtIndex:(NSInteger)indexInt{

    CollectionOneController *collOne=NULL;
    CollectionTowController *collTow=NULL;
    FindDoctorController *findDoctorCon=NULL;
    inspectController *inspectCon = NULL;
    ShareController *shareCon=NULL;

    switch (indexInt) {
        case 0:
            
            collOne = [[CollectionOneController alloc]init];
            collOne.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:collOne animated:YES];
            
            break;
        case 1:
            
            collTow = [[CollectionTowController alloc]init];
            collTow.hidesBottomBarWhenPushed = YES;
            collTow.WebUrl = @"/mycenter/news_list.htm?sid=11&ios=1";
            collTow.titleName = @"舌尖孕味";
            [self.navigationController pushViewController:collTow animated:YES];
            
            break;
        case 2:
            
            findDoctorCon =[[FindDoctorController alloc]init];
            findDoctorCon.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:findDoctorCon animated:YES];
    
            break;
        case 3:
            
            inspectCon=[[inspectController alloc]init];
            inspectCon.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:inspectCon animated:YES];
        
            break;
        case 4:
            
            collTow = [[CollectionTowController alloc]init];
            collTow.hidesBottomBarWhenPushed = YES;
            collTow.WebUrl = @"topic.htm?id=4&ios=1";
            collTow.titleName = @"月子公寓";
            [self.navigationController pushViewController:collTow animated:YES];
            
            break;
        case 5:
            
            collTow = [[CollectionTowController alloc]init];
            collTow.hidesBottomBarWhenPushed = YES;
            collTow.WebUrl = @"/mycenter/news_list.htm?sid=12&ios=1";
            collTow.titleName = @"好孕心情";
            [self.navigationController pushViewController:collTow animated:YES];

            break;
        case 6:
            
            collTow = [[CollectionTowController alloc]init];
            collTow.hidesBottomBarWhenPushed = YES;
            collTow.WebUrl = @"topic.htm?id=5&ios=1";
            collTow.titleName = @"产后恢复";
            [self.navigationController pushViewController:collTow animated:YES];
            
            break;
        case 7:
            
            shareCon = [[ShareController alloc]init];
            shareCon.hidesBottomBarWhenPushed = YES;
    //        shareCon.WebUrl = @"mycenter/share.htm?ios=1";
            shareCon.titleName = @"分享有礼";
            [self.navigationController pushViewController:shareCon animated:YES];
            
            break;
        default:
            break;
    }

}

-(UIView *)outtimefunc{

    UIView *timeOutView=[[UIView alloc]initWithFrame:CGRectMake(15,50, 200, 40)];

    dayLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 25, 20)];
    dayLabel.backgroundColor = [UIColor redColor];
    dayLabel.textColor = [UIColor whiteColor];
    dayLabel.textAlignment=NSTextAlignmentLeft;
    dayLabel.font=[UIFont systemFontOfSize:12.0];
    
    hourLabel =[[UILabel alloc]initWithFrame:CGRectMake(20,10,25, 20)];
    hourLabel.backgroundColor = [UIColor redColor];
    hourLabel.textColor = [UIColor whiteColor];
    hourLabel.textAlignment=NSTextAlignmentCenter;
    hourLabel.font=[UIFont systemFontOfSize:14.0];
    
    
    jiange_1 =[[UILabel alloc]initWithFrame:CGRectMake(45, 10,6, 20)];
    jiange_1.backgroundColor = [UIColor clearColor];
    jiange_1.textColor = [UIColor redColor];
    jiange_1.textAlignment=NSTextAlignmentCenter;
    jiange_1.text =@":";
    jiange_1.font=[UIFont systemFontOfSize:14.0];
    
    minuteLabel =[[UILabel alloc]initWithFrame:CGRectMake(51, 10, 25, 20)];
    minuteLabel.backgroundColor = [UIColor redColor];
    minuteLabel.textColor = [UIColor whiteColor];
    minuteLabel.textAlignment=NSTextAlignmentCenter;
    minuteLabel.font=[UIFont systemFontOfSize:14.0];
    
    jiange_2 =[[UILabel alloc]initWithFrame:CGRectMake(76, 10,6, 20)];
    jiange_2.backgroundColor = [UIColor clearColor];
    jiange_2.textColor = [UIColor redColor];
    jiange_2.textAlignment=NSTextAlignmentCenter;
    jiange_2.text =@":";
    jiange_2.font=[UIFont systemFontOfSize:14.0];

    
    secondLabel =[[UILabel alloc]initWithFrame:CGRectMake(82,10,25,20)];
    secondLabel.backgroundColor = [UIColor redColor];
    secondLabel.textColor = [UIColor whiteColor];
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.font=[UIFont systemFontOfSize:14.0];
    
  //  [timeOutView addSubview:dayLabel];
    [timeOutView addSubview:hourLabel];
    [timeOutView addSubview:jiange_1];
    [timeOutView addSubview:minuteLabel];
    [timeOutView addSubview:jiange_2];
    [timeOutView addSubview:secondLabel];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *endDate = [dateFormatter dateFromString:[[menuArray objectAtIndex:0] valueForKey:@"t_time"]];
    //2017-04-11 20:37:00
   // NSDate *endDate = [dateFormatter dateFromString:@"2017-04-12 20:37:00"];
    NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate])];

    NSDate *startDate = [NSDate date];
    NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
    
    if (_timer==nil) {
        __block int timeout = timeInterval; //倒计时时间

        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        dayLabel.text = @"00天";
                        hourLabel.text = @"00";
                        minuteLabel.text = @":00";
                        secondLabel.text = @":00";
                        
                    });
                }else{
                   
                    int days = (int)(timeout/(3600*24));
                    
                    int nowhours = timeout/3600;
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        if (days==0) {
                            
                         //   dayLabel.text = [NSString stringWithFormat:@"0%d天",days];
                            
                        }else{
                        
                         //   dayLabel.text = [NSString stringWithFormat:@"%d天",days];
                        }
                        if (hours<10) {
                            hourLabel.text = [NSString stringWithFormat:@"0%d",nowhours];
                        }else{
                            hourLabel.text = [NSString stringWithFormat:@"%d",nowhours];
                        }
                        if (minute<10) {
                            minuteLabel.text = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            minuteLabel.text = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            secondLabel.text = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            secondLabel.text = [NSString stringWithFormat:@"%d",second];
                        }
                        
                
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
    
    return timeOutView;
}

-(NSString *)getyyyymmdd:(NSString *)thisTime{
    
    NSDateFormatter *dateFormattertime = [[NSDateFormatter alloc] init];
    [dateFormattertime setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *timedate = [dateFormattertime dateFromString:thisTime];
    
    NSString *strDate = [dateFormattertime stringFromDate:timedate];
    
    return strDate;
    
}

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//
//    NSLog(@"sousuo%@",customSearchBar.text);
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//    SearchController *sreachCon = [[SearchController alloc]init];
//    sreachCon.hidesBottomBarWhenPushed = YES;
//    sreachCon.searchTitle =customSearchBar.text;
//    [self.navigationController pushViewController:sreachCon animated:YES];
//
//}


//不能编辑
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{

    [self loginSearcController];
    return NO;
}

#pragma mark -调用登陆Controller
-(void)loginSearcController{
    
    SearchController *sreachCon = [[SearchController alloc]init];
    SearchNav=[[UINavigationController alloc]initWithRootViewController:sreachCon];
    [self presentViewController:SearchNav animated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

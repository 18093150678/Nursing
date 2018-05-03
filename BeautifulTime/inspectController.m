//
//  inspectController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/5.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "inspectController.h"
#import "Pretreatment.h"


@interface inspectController ()

@end

@implementation inspectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"上门产检";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [userAddressLeftBack addTarget:self action:@selector(inspectFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self GetHttpsDataProductslist];
    [self ContentView];

}

-(void)ContentView{

    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:CGRectMake(9, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    imageTableView.image = [UIImage imageNamed:@"timelogo.png"];
    
    //定义表示图 表示图的样式为分组视图
    insectTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT-64) style:UITableViewStylePlain];
    insectTableView.delegate = self;
    insectTableView.dataSource = self;
    insectTableView.backgroundView = imageTableView;
    insectTableView.showsVerticalScrollIndicator = NO;
    [insectTableView setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                 green:145/255.0
                                                  blue:145/255.0
                                                 alpha:0.2]];
    
    if ([insectTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [insectTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([insectTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [insectTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    insectTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(refreshViewindex:)
              forControlEvents:UIControlEventValueChanged];
    [_refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
    [insectTableView addSubview:_refreshControl];
    
    
    [self.view addSubview:insectTableView];
    

}

#pragma mark 第section组一共有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return cellArray.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //    CGFloat meunLogosize = 55.0;
    //    CGFloat LabelLogosize = 65.0;
    NSLog(@"indexPath%ld",(long)indexPath.row);
    
    
    static NSString *IdentifierCellsss = @"BeautifulTimeCell";
    
    UITableViewCell *cell  =  [tableView dequeueReusableCellWithIdentifier:IdentifierCellsss];
    
    if (cell == nil) {
        //不存在的cell
        //创建新的cel
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IdentifierCellsss];
        
    }
    
    while ([cell.contentView.subviews lastObject] != nil)
    {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    
    
        //产品图片
        
//        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, SIZE_WIDTH-10, 130)];
//        imageView.image=[UIImage imageNamed:@"pro_logo.png"];
//        imageView.layer.cornerRadius = 8;
//        imageView.layer.masksToBounds = true;
    AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(5, 5, SIZE_WIDTH-10, 180)];
    asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
    asynImageView.imageURL=[NSString stringWithFormat:@"%@",[[cellArray objectAtIndex:indexPath.row] valueForKey:@"main_img"]];
    asynImageView.imageURL = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],asynImageView.imageURL];
    asynImageView.contentMode=UIViewContentModeScaleToFill;
    asynImageView.tag = indexPath.row;
    asynImageView.layer.cornerRadius = 8;
    asynImageView.layer.masksToBounds = true;
    asynImageView.userInteractionEnabled = YES;
    
    float imageheight=asynImageView.frame.size.height;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(inserControllerFunc:)];
    tap.view.tag = asynImageView.tag;
    [asynImageView addGestureRecognizer:tap];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SIZE_WIDTH-20, 20)];
    titleLabel.textColor = [UIColor blackColor];
    [titleLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:18.0]];
    titleLabel.text= [[cellArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    //产品介绍
    
    NSString *strSummary=[NSString stringWithFormat:@"%@",[[cellArray objectAtIndex:indexPath.row] valueForKey:@"summary"]];
    if ([strSummary isEqualToString:@"<null>"]) {
        strSummary=@"";
    }
    UILabel *ProductinfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 215, SIZE_WIDTH-20, 40)];
    ProductinfoLabel.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:0.8];
    ProductinfoLabel.font = [UIFont systemFontOfSize:12.0];
    ProductinfoLabel.numberOfLines=0;
    ProductinfoLabel.text= strSummary;


       //产品价格
    
  
    UILabel *ProductPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,255, SIZE_WIDTH/4, 30)];
    ProductPriceLabel.textColor = [UIColor colorWithRed:200/255.0 green:13/255.0 blue:52/255.0 alpha:0.6];
    [ProductPriceLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20.0]];
    ProductPriceLabel.text= [NSString stringWithFormat:@"¥ %@",[[cellArray objectAtIndex:indexPath.row] valueForKey:@"price"]];
        
    //副产品价格
  
    //当标签为空时
    NSString *y_pricestr=[NSString stringWithFormat:@"%@",[[cellArray objectAtIndex:indexPath.row] valueForKey:@"y_price"]];
    if ([y_pricestr isEqualToString:@"<null>"]) {
        y_pricestr=@"";
    }else{
        y_pricestr = [NSString stringWithFormat:@"¥ %@",y_pricestr];
    }
    UILabel *FuProductPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4+10,255, SIZE_WIDTH/4, 30)];
    FuProductPriceLabel.textColor = [UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:0.6];
    [FuProductPriceLabel setFont:[UIFont fontWithName:@"Arial" size:14.0]];
    FuProductPriceLabel.text= y_pricestr;
    NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",FuProductPriceLabel.text]];
    [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
    
    FuProductPriceLabel.attributedText = newPrice;
    [cell.contentView addSubview:FuProductPriceLabel];
        
    //订购按钮
    UIButton *paybut=[[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4*2.5, 260,50, 20)];
    [paybut setTitle:@"上门医疗" forState:UIControlStateNormal];
    paybut.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [paybut setBackgroundColor:[UIColor colorWithRed:254/255.0 green:198/255.0 blue:115/255.0 alpha:1.0]];
    paybut.layer.cornerRadius = 4;
    paybut.layer.masksToBounds = true;
    
    //订购按钮
    UIButton *daodianbut=[[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4*2.5+60, 260,50, 20)];
    [daodianbut setTitle:@"到院医疗" forState:UIControlStateNormal];
    daodianbut.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [daodianbut setBackgroundColor:[UIColor colorWithRed:255/255.0 green:139/255.0 blue:148/255.0 alpha:1.0]];
    daodianbut.layer.cornerRadius = 4;
    daodianbut.layer.masksToBounds = true;
    
    
    
    [cell.contentView addSubview:asynImageView];
    [cell.contentView addSubview:titleLabel];
    [cell.contentView addSubview:ProductinfoLabel];
    [cell.contentView addSubview:ProductPriceLabel];

    NSString *service_type = [NSString stringWithFormat:@"%@",[[cellArray objectAtIndex:indexPath.row] valueForKey:@"service_type"]];
    
    if ([service_type isEqualToString:@"1"]) {
        UIButton *paybut=[[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4*2.5+60, imageheight+80,65, 20)];
        [paybut setTitle:@"上门医疗" forState:UIControlStateNormal];
        paybut.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [paybut setBackgroundColor:[UIColor colorWithRed:254/255.0 green:198/255.0 blue:115/255.0 alpha:1.0]];
        paybut.layer.cornerRadius = 4;
        paybut.layer.masksToBounds = true;
        [cell.contentView addSubview:paybut];
    }
    if ([service_type isEqualToString:@"2"]) {
        
        UIButton *daodianbut=[[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4*2.5+60, imageheight+80,65, 20)];
        [daodianbut setTitle:@"到院医疗" forState:UIControlStateNormal];
        daodianbut.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [daodianbut setBackgroundColor:[UIColor colorWithRed:255/255.0 green:139/255.0 blue:148/255.0 alpha:1.0]];
        daodianbut.layer.cornerRadius = 4;
        daodianbut.layer.masksToBounds = true;
        [cell.contentView addSubview:daodianbut];
    }
    if ([service_type isEqualToString:@"3"]) {
        
        UIButton *paybut=[[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4*2.4, imageheight+80,65, 20)];
        [paybut setTitle:@"上门医疗" forState:UIControlStateNormal];
        paybut.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [paybut setBackgroundColor:[UIColor colorWithRed:254/255.0 green:198/255.0 blue:115/255.0 alpha:1.0]];
        paybut.layer.cornerRadius = 4;
        paybut.layer.masksToBounds = true;
        
        [cell.contentView addSubview:paybut];
        
        UIButton *daodianbut=[[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH/4*2.4+75, imageheight+80,65, 20)];
        [daodianbut setTitle:@"到院医疗" forState:UIControlStateNormal];
        daodianbut.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [daodianbut setBackgroundColor:[UIColor colorWithRed:255/255.0 green:139/255.0 blue:148/255.0 alpha:1.0]];
        daodianbut.layer.cornerRadius = 4;
        daodianbut.layer.masksToBounds = true;
        [cell.contentView addSubview:daodianbut];
        [cell.contentView addSubview:daodianbut];
    }
    
    
    //华丽的分割view
    UIView *LineView = [[UIView alloc]initWithFrame:CGRectMake(0, 290, SIZE_WIDTH, 10)];
    LineView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    [cell.contentView addSubview:LineView];

  
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 选中cell的操作
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"---s----%ld",(long)indexPath.row);
//    
//    ProductInfoController *productCon = [[ProductInfoController alloc]init];
//    productCon.Product_id = [[cellArray objectAtIndex:indexPath.row] valueForKey:@"id"];
//    productCon.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:productCon animated:YES];
    
}

-(void)inserControllerFunc:(id)sender{
    
    
    UITapGestureRecognizer *tap=(UITapGestureRecognizer *)sender;
    NSInteger tapindex=tap.view.tag;
    ProductInfoController *productCon = [[ProductInfoController alloc]init];
    productCon.Product_id = [[cellArray objectAtIndex:tapindex] valueForKey:@"id"];
    productCon.pric = [[cellArray objectAtIndex:tapindex] valueForKey:@"price"];
    productCon.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productCon animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowHeight = 300 ;
    
    return rowHeight;
    
}

-(void)inspectFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)refreshViewindex:(UIRefreshControl *)sender{
    
    [self GetHttpsDataProductslist];
    [sender endRefreshing];

}


//产品数据json
#pragma mark -产品数据json解析
-(void)GetHttpsDataProductslist{
    
    NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
    if (URL == NULL) {
        
        URL = newurl;
    }
    
    NSString *Urladress = service_yjc;
    NSString *strUrl =@"";
    
    NSLog(@"");

        
    strUrl =[NSString stringWithFormat:@"%@%@",URL,Urladress];
    
    NSLog(@"strUrl=%@",strUrl);
        
       //创建链接
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    [manager GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        cellArray  = responseObject;
        [insectTableView reloadData];
        
        //   [activityIndicatorView stopAnimating];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //    [activityIndicatorView stopAnimating];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

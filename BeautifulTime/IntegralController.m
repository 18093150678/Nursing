//
//  IntegralController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/19.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#define cell_Height 80

#import "IntegralController.h"
#import "Pretreatment.h"
@interface IntegralController ()

@end

@implementation IntegralController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"我的积分";
    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrews" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *IntegralLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    IntegralLeftBack.frame =CGRectMake(0, 0, 30, 30);
    [IntegralLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    IntegralLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [IntegralLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    
    [IntegralLeftBack addTarget:self action:@selector(IntegralBackConFunc:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc]initWithCustomView:IntegralLeftBack];
    self.navigationItem.leftBarButtonItem = LeftBarButton;
    
    self.navigationController.navigationBar.translucent = YES;
    
    [self Integrallistceanl];
    [self IntegralFunc];
    

}

-(void)IntegralBackConFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)IntegralFunc{
    
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0,64, SIZE_WIDTH, SIZE_HEIGHT)];
    backgroundView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:backgroundView];
    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:backgroundView.bounds];
    imageTableView.image = [UIImage imageNamed:@"timelogo.png"];
    
    //定义表示图 表示图的样式为分组视图
    appTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH,SIZE_HEIGHT-64) style:UITableViewStylePlain];
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
                        action:@selector(IntegralrefreshView:)
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
    
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, cell_Height)];
    cellView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
    
    
    UIView *ContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 70)];
    ContentView.backgroundColor = [UIColor whiteColor];
    
    
    NSString *strsCore=[[datelist objectAtIndex:indexPath.row] valueForKey:@"score"];
    NSString *strsFront_type=[[datelist objectAtIndex:indexPath.row] valueForKey:@"front_type"];

    NSLog(@"strsCore%@",strsCore);

    UILabel *IntegraLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
    IntegraLabel.text=[NSString stringWithFormat:@"+%@",strsCore];
    IntegraLabel.textColor=[UIColor redColor];
    [IntegraLabel setFont:[UIFont systemFontOfSize:14.0]];
    [ContentView addSubview:IntegraLabel];
    

    UILabel *LaiziLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 5,SIZE_WIDTH-110, 30)];
    LaiziLabel.text=[NSString stringWithFormat:@"来自：%@",strsFront_type];
    LaiziLabel.textColor=[UIColor blackColor];
    [LaiziLabel setFont:[UIFont systemFontOfSize:14.0]];
    [ContentView addSubview:LaiziLabel];
    

    

    UILabel *integraTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, SIZE_WIDTH, 30)];
    integraTimeLabel.text=[NSString stringWithFormat:@"%@",[[datelist objectAtIndex:indexPath.row] valueForKey:@"create_time"]];
    integraTimeLabel.textColor=[UIColor blackColor];
    [integraTimeLabel setFont:[UIFont systemFontOfSize:14.0]];
    [ContentView addSubview:integraTimeLabel];
    
    
    [cellView addSubview:ContentView];
    [cell.contentView addSubview:cellView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return cell_Height;
    
}

#pragma mark -下拉刷新
-(void)IntegralrefreshView:(UIRefreshControl *)sender{
    
    NSLog(@"la");
    
}


#pragma mark -读取取消预约信息列表
-(void)Integrallistceanl{
    
    NSDictionary *parameters=[[NSDictionary alloc]init];
    
    parameters  =@{@"user_id":[USER_DEFAULT valueForKey:@"user_id"]};
    
    //创建字典参数列表
    NSLog(@"user_id%@",[USER_DEFAULT valueForKey:@"user_id"]);
    
    //拼接地址
    NSString *strUlr = service_integral;
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
 
         datelist = responseObject;
    
         NSLog(@"IntegralController%@",datelist);
         //       [activityIndicatorView stopAnimating];
         
         [appTableView reloadData];
         
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         //   [activityIndicatorView stopAnimating];
     }];
}

- (NSMutableAttributedString *)ResultStrColor:(NSString *)codeStr sLength:(NSUInteger)Strlength{
    
    
    NSMutableAttributedString *str =[[NSMutableAttributedString alloc]initWithString:codeStr];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor ] range:NSMakeRange(0, Strlength+1)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, Strlength+1)];
    
    return  str;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

//
//  CouponController.m
//  BeautifulTime
//
//  Created by lee on 2017/7/19.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "CouponController.h"

@interface CouponController ()

@end

@implementation CouponController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"优惠券";
    [indexLabel setFont:[UIFont fontWithName:@"BanglaSangamMN-Bold" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    UIButton *leftBack = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBack.frame = CGRectMake(0, 0, 30, 30);
    [leftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    leftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [leftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [leftBack addTarget:self action:@selector(coupincloseFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBack];
    
    
    self.navigationItem.leftBarButtonItem = LeftButtonItem;
    
    [self getUserCouponFunc];
    
    [self.view addSubview:self.tableView];


}

//懒加载
-(UITableView *)tableView{

    if(!_tableView){
   
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,SIZE_WIDTH,SIZE_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        [_tableView setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                      green:145/255.0
                                                       blue:145/255.0
                                                      alpha:0.5]];
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }

    
    }


    return _tableView;
}

#pragma mark -返回有几块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

#pragma mark -返回每块有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _couponArray.count;
    
}

#pragma mark -返回每一行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}

#pragma mark -返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName = @"orderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell== nil) {
        
        //如果cell不存在 创建一个新的 否则去缓存池中去重用
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        
    }
    
    while ([[cell.contentView subviews] count] > 0) {
        
        [[[cell.contentView subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 100)];
    cellView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:cellView];
    
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 100)];
    leftView.backgroundColor = [UIColor redColor];
    
    [cellView addSubview:leftView];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"index%ld",(long)indexPath.row);
    
//    if ([_delegate respondsToSelector:@selector(OrderTableViewFunc:orderArrray:)]) {
//        
//        [_delegate OrderTableViewFunc:indexPath.row orderArrray:[showArray objectAtIndex:indexPath.row]];
//        
//    }
    
}

#pragma mark - 用户优惠券获取
-(void)getUserCouponFunc{
    
    
    NSDictionary *parameters=@{@"user_id":[USER_DEFAULT objectForKey:@"user_id"],@"pid":_pro_id};
    NSString *orderstatusUrlList = ios_my_coupon;
    NSString *orderurl=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],orderstatusUrlList];
    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求
    
    [manager POST:orderurl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _couponArray = [[NSArray alloc]initWithArray:responseObject];

        NSLog(@"优惠券-----------%@",_couponArray);

        [_tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}


-(void)coupincloseFunc:(id)sender{

    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

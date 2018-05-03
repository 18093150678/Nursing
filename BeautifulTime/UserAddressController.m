//
//  UserAddressController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/17.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "UserAddressController.h"

@interface UserAddressController ()

@end

@implementation UserAddressController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"我的地址";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    [userAddressLeftBack addTarget:self action:@selector(userAddresBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    [self TabelViewFunc];
    [self AddAdressSaveFunc];


}

#pragma mark -每次进来都调用一次的view的协议方法
-(void)viewWillAppear:(BOOL)animated{

    NSLog(@"----GetAdressListFunc----");
    [self GetAdressListFunc];

}

#pragma mark -地址列表
-(void)TabelViewFunc{
    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, SIZE_WIDTH, SIZE_HEIGHT)];
    imageTableView.image = [UIImage imageNamed:@"timelogo.png"];
    
    TabLeView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SIZE_WIDTH, SIZE_HEIGHT-64) style:UITableViewStylePlain];
    TabLeView.delegate = self;
    TabLeView.dataSource = self;
    TabLeView.backgroundView = imageTableView;
    TabLeView.showsVerticalScrollIndicator = NO;
    [TabLeView setSeparatorColor:[UIColor colorWithRed:225/255.0
                                                 green:225/255.0
                                                  blue:225/255.0
                                                 alpha:0.2]];
    
    if ([TabLeView respondsToSelector:@selector(setSeparatorInset:)]) {
        [TabLeView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([TabLeView respondsToSelector:@selector(setLayoutMargins:)]) {
        [TabLeView setLayoutMargins:UIEdgeInsetsZero];
    }

    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(refreshView:)
              forControlEvents:UIControlEventValueChanged];
    [_refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
    [TabLeView addSubview:_refreshControl];
    [self.view addSubview:TabLeView];
    
}

#pragma mark -下拉刷新
-(void)refreshView:(UIRefreshControl *)sender{
    
    NSLog(@"la");
    [self  GetAdressListFunc];
    [sender endRefreshing];
    
}

#pragma mark -返回有几块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}

#pragma mark -返回每块有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return AddressArray.count*2;

}

#pragma mark -返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellName = @"BeautifulTimeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        
    }
    while ([[cell.contentView subviews] count] > 0) {
        
        [[[cell.contentView subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    if (indexPath.row%2 ==1) {
        
        UIView *backgroundiew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 10)];
        backgroundiew.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
        
        [cell.contentView addSubview:backgroundiew];
    }
    else{

    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,10,150, 20)];
    userNameLabel.text =[[AddressArray objectAtIndex:indexPath.row/2] valueForKey:@"user_name"];
    userNameLabel.textColor = [UIColor blackColor];
    userNameLabel.font = [UIFont systemFontOfSize:14.0];
    userNameLabel.backgroundColor = [UIColor clearColor];
    
    [cell.contentView addSubview:userNameLabel];
    
    UILabel *userTelLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIZE_WIDTH-(SIZE_WIDTH/2)-20,10,SIZE_WIDTH-(SIZE_WIDTH/2)-30, 20)];
    userTelLabel.text = [[AddressArray objectAtIndex:indexPath.row/2] valueForKey:@"mobile"];
    userTelLabel.textColor = [UIColor blackColor];
    userTelLabel.font = [UIFont systemFontOfSize:13.0];
    userTelLabel.textAlignment = NSTextAlignmentRight;
    userTelLabel.backgroundColor = [UIColor clearColor];
    
    [cell.contentView addSubview:userTelLabel];
    
    NSString *m = @"[默认] ";
    NSString *d = @"[地址] ";
    NSString *StrAddress = @"";
        NSString *def = [NSString stringWithFormat:@"%@",[[AddressArray objectAtIndex:indexPath.row/2] valueForKey:@"def"]];
    if ([def isEqualToString:@"1"]) {
            
       StrAddress =  [m stringByAppendingString:[[AddressArray objectAtIndex:indexPath.row/2] valueForKey:@"address"]];
    
    }else{
       
       StrAddress =  [d stringByAppendingString:[[AddressArray objectAtIndex:indexPath.row/2] valueForKey:@"address"]];
    
    }
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:StrAddress];
    NSInteger c_length = StrAddress.length;
    
        if (c_length < 5) {
            
            c_length = 5;
        }
        
    //设置：在0-3个单位长度内的内容显示成红色
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor colorWithRed:232/255.0 green:98/255.0 blue:0/255.0 alpha:1.0]
     
                          range:NSMakeRange(0, 4)];
    
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.6]
         
                              range:NSMakeRange(5, c_length-5)];
        

    //   NSString *d = @"地址";
    
    UILabel *userAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40,SIZE_WIDTH-80, 30)];
    userAddressLabel.attributedText = AttributedStr;
    userAddressLabel.font = [UIFont systemFontOfSize:14.0];
    userAddressLabel.backgroundColor = [UIColor clearColor];
    userAddressLabel.numberOfLines = 0;

    [cell.contentView addSubview:userAddressLabel];
    
    UIImageView *changeImage = [[UIImageView alloc]initWithFrame:CGRectMake(SIZE_WIDTH-40, 40, 30, 30)];
    changeImage.image = [UIImage imageNamed:@"Menuuserlogo_5.png"];
    changeImage.tag = indexPath.row;
    changeImage.userInteractionEnabled = YES;
        
    UITapGestureRecognizer *tapChangeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ChangeAddressControllerFunc:)];
        [changeImage addGestureRecognizer:tapChangeTap];

    [cell.contentView addSubview:changeImage];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;

}

#pragma mark -划动cell是否出现del按钮
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

#pragma mark -删除按钮式样
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark -删除按钮事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"delete");
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"您确定要删除这个地址嘛" message:@"地址" preferredStyle:UIAlertControllerStyleAlert];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        //点击取消调用的方法
        
    }]];

    [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //点击确认调用的方法
        
        [self DeleteAddressFunc:indexPath.row];
        
    }]];

    // 由于它是一个控制器 直接modal出来就好了
    
    [self presentViewController:alertCon animated:YES completion:nil];
    
    
}

#pragma mark -修改移动删除按钮上的文字
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath{

    NSString *strDelete = @"删除";
    return strDelete;

}

#pragma mark -返回每一行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row%2 == 1 ) {
        
        return 10;
    }
    return 85;
    
}

#pragma mark -返回按钮方法
-(void)userAddresBackFunc:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark -添加新地址按钮
-(void)AddAdressSaveFunc{
    
    UIButton *_OrderBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _OrderBut.frame = CGRectMake(0, SIZE_HEIGHT-40, SIZE_WIDTH, 40);
    [_OrderBut setTitle:@" 添加地址 " forState:UIControlStateNormal];
    _OrderBut.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_OrderBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_OrderBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateNormal];
    [_OrderBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateHighlighted];
    [_OrderBut addTarget:self action:@selector(UserAddAdressSaveFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_OrderBut];
    
}

-(void)UserAddAdressSaveFunc:(id)sender{

    AddUserAdressController *addUser = [[AddUserAdressController alloc]init];
    [self.navigationController pushViewController:addUser animated:YES];

}

#pragma mark -请求地址列表
-(void)GetAdressListFunc{
    
    //添加参数

    NSDictionary *parameters=@{@"user_id":[USER_DEFAULT objectForKey:@"user_id"]};
    NSString *AdressUrlList = service_address_list;
    NSString *strurGetAddressUrl=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],AdressUrlList];
    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求
    
    [manager POST:strurGetAddressUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        AddressArray = [[NSMutableArray alloc]initWithArray:responseObject];
        
        NSLog(@"responseObject%@",AddressArray);
        [TabLeView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

#pragma mark -删除地址列表
-(void)DeleteAddressFunc:(NSInteger)indexPathRow{

    //post发送请求 参数列表 字典形式 key - value
    
    NSString *Address_ID = [NSString stringWithFormat:@"%@",[[AddressArray objectAtIndex:indexPathRow/2] valueForKey:@"id"]];
    
    NSDictionary *parameters = @{@"id":Address_ID};
    //请求地址
    NSString *AdressUrlDel = service_address_del;
    NSString *strurDELAddressUrl=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],AdressUrlDel];
    
    //创建一个AFHTTPRequestOperationManager的实例
    manager = [AFHTTPSessionManager manager];
    //设置参数
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    //发送post请求
    
    
    
    [manager POST:strurDELAddressUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"responseObject%@",responseObject);
        if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"succ"]) {
            
            [self GetAdressListFunc];
            [TabLeView reloadData];
            
        }else{
            
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除失败！请稍候再试!" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            }]];
            [self presentViewController:alertCon animated:YES completion:nil];

        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

#pragma mark -编辑地址
-(void)ChangeAddressControllerFunc:(id)sender{

    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    
    ChangeAddressController *changeCon = [[ChangeAddressController alloc]init];
    changeCon.addressArrayDict = [AddressArray objectAtIndex:tap.view.tag/2];
    
    [self.navigationController pushViewController:changeCon animated:YES];
    
}





#pragma mark -收获地址列表
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

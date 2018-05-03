//
//  OrderMessageController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/12/16.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "OrderMessageController.h"

@implementation OrderMessageController

-(void)viewDidLoad{

    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.font = [UIFont systemFontOfSize:14.0];
    ConTitleView.text = @"支付";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = ConTitleView;
    
    
    UIButton *OrderMessageLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    OrderMessageLeftBack.frame =CGRectMake(0, 0, 30, 30);
    [OrderMessageLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    OrderMessageLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [OrderMessageLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    
    [OrderMessageLeftBack addTarget:self action:@selector(orderMessageBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *sxLeftBarButton = [[UIBarButtonItem alloc]initWithCustomView:OrderMessageLeftBack];
    
    self.navigationItem.leftBarButtonItem = sxLeftBarButton;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    
    [self PaybutFunc];

}

#pragma mark-支付成功
-(void)PaybutFunc{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,64, SIZE_WIDTH, SIZE_HEIGHT)];
    view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
    
    [self.view addSubview:view];
    
    //消息通知VIEW
    
    UIView *payMessageView = [[UIView alloc]initWithFrame:CGRectMake(15, 30, SIZE_WIDTH-30, 250)];
    payMessageView.backgroundColor = [UIColor whiteColor];
    [payMessageView.layer setMasksToBounds:YES];
    [payMessageView.layer setCornerRadius:5.0];
    
    [view addSubview:payMessageView];
    
    
    UILabel *payTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, payMessageView.frame.size.width-30, 30)];
    payTitle.text = @"支付成功";
    payTitle.textColor = [UIColor colorWithRed:235/255.0 green:101/255.0 blue:49/255.0 alpha:0.8];
    payTitle.textAlignment = NSTextAlignmentCenter;
    payTitle.textColor = [UIColor blackColor];
    payTitle.font = [UIFont systemFontOfSize:18.0];
    
    [payMessageView addSubview:payTitle];
    
    
    //产品图片
    AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(30, 50,payMessageView.frame.size.width-60,80)];
    asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
    asynImageView.imageURL=[NSString stringWithFormat:@"%@",[_dictProduct valueForKey:@"main_img"]];
    asynImageView.imageURL = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],asynImageView.imageURL];
    asynImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [payMessageView addSubview:asynImageView];
    
    NSString *Proprice = [NSString stringWithFormat:@"%@",[_dictProduct valueForKey:@"price"]];
    
    NSString *type = [NSString stringWithFormat:@"%@",[_dictProduct valueForKey:@"type"]];
    
    if ([type isEqualToString:@"2"]) {
        
        NSMutableArray *arrayemap = (NSMutableArray *)[_dictProduct valueForKey:@"emap"];
        
        for (int i=0; i<arrayemap.count; i++) {
            
            if ([[_dictProduct valueForKey:@"eid"] isEqualToString:[[arrayemap objectAtIndex:i] valueForKey:@"id"]]) {
                
                Proprice = [[arrayemap objectAtIndex:i] valueForKey:@"price"];
                
            }
            
        }
        
    }

    UILabel *payPrice = [[UILabel alloc]initWithFrame:CGRectMake(10,140, payMessageView.frame.size.width-60, 30)];
    payPrice.text = [NSString stringWithFormat:@"支付金额:%@",Proprice];
    payPrice.textColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:0.8];
    payPrice.font = [UIFont systemFontOfSize:16.0];
    
    [payMessageView addSubview:payPrice];
    
    
    UILabel *payOrderNum = [[UILabel alloc]initWithFrame:CGRectMake(10,170, payMessageView.frame.size.width-30, 20)];
    payOrderNum.text = [NSString stringWithFormat:@"交易单号:%@",_ordernum];
    payOrderNum.textColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1.0];
    payOrderNum.font = [UIFont systemFontOfSize:14];
    
    [payMessageView addSubview:payOrderNum];
    
    NSString *proName = [NSString stringWithFormat:@"%@",[_dictProduct valueForKey:@"title"]];
    
    
    if ([type isEqualToString:@"2"]) {
        
        NSMutableArray *arrayemap = [_dictProduct valueForKey:@"emap"];
       
        for (int i=0; i<arrayemap.count; i++) {

            if ([[_dictProduct valueForKey:@"eid"] isEqualToString:[[arrayemap objectAtIndex:i] valueForKey:@"id"]]) {

                
                proName = [NSString stringWithFormat:@"%@%@",proName,[[arrayemap objectAtIndex:i] valueForKey:@"pro_color"]];

            }
            
        }
        
    }


    UILabel *payProName = [[UILabel alloc]initWithFrame:CGRectMake(10,190, payMessageView.frame.size.width-30, 20)];
    payProName.text = proName;
    payProName.textColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1.0];
    payProName.font = [UIFont systemFontOfSize:14.0];
    
    [payMessageView addSubview:payProName];
    
    UILabel *BeiZhu = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, payMessageView.frame.size.width-30, 30)];
    BeiZhu.text = @"备注: 您可以在我的里面查看我的订单来看订购的产品";
    BeiZhu.textColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1.0];
    BeiZhu.font = [UIFont systemFontOfSize:14];
    
    [payMessageView addSubview:BeiZhu];
    
    
    UIButton *SuccBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    SuccBut.frame = CGRectMake(20, payMessageView.frame.size.height+64, SIZE_WIDTH-40, 40);
    [SuccBut setTitle:@"查看订单" forState:UIControlStateNormal];
    [SuccBut.layer setMasksToBounds:YES];
    [SuccBut.layer setCornerRadius:5.0];
    SuccBut.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [SuccBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SuccBut setBackgroundColor:[UIColor colorWithRed:59/255.0 green:188/255.0 blue:72/255.0 alpha:0.8]];
    [SuccBut addTarget:self action:@selector(SuccButFunc) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:SuccBut];
    
    UIButton *orderBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    orderBut.frame = CGRectMake(20, payMessageView.frame.size.height+114, SIZE_WIDTH-40, 40);
    [orderBut setTitle:@"返回首页" forState:UIControlStateNormal];
    [orderBut.layer setMasksToBounds:YES];
    [orderBut.layer setCornerRadius:5.0];
    orderBut.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [orderBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orderBut setBackgroundColor:[UIColor colorWithRed:59/255.0 green:188/255.0 blue:72/255.0 alpha:0.8]];
    [orderBut addTarget:self action:@selector(BackIndexButFunc) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:orderBut];

}

#pragma mark -查看订单按钮
-(void)SuccButFunc{

    MyorderController *myorderCon = [[MyorderController alloc]init];
    myorderCon.hidesBottomBarWhenPushed = YES ;
    myorderCon.deleClass = self ;
    [self.navigationController pushViewController:myorderCon animated:YES];

}

#pragma mark -返回首页按钮
-(void)BackIndexButFunc{

     [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -4)] animated:YES];

}

-(void)orderMessageBackFunc:(id)sender{
    
 //  [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -4)] animated:YES];
    
}

@end

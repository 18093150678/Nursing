//
//  ProductInfoController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/10.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "ProductInfoController.h"



@interface ProductInfoController (){

    float buttonHeight ;

}

@end

@implementation ProductInfoController

@synthesize Product_id;

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"产品详情";
    [indexLabel setFont:[UIFont fontWithName:@"BanglaSangamMN-Bold" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    UIButton *leftBack = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBack.frame = CGRectMake(0, 0, 30, 30);
    [leftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    leftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [leftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [leftBack addTarget:self action:@selector(BackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBack];
    
    
    self.navigationItem.leftBarButtonItem = LeftButtonItem;
   
    UIButton *RightBackProInfo = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBackProInfo.titleLabel.font = [UIFont systemFontOfSize:12.0];
    RightBackProInfo.frame = CGRectMake(0, 0, 30, 30);
    [RightBackProInfo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    RightBackProInfo.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [RightBackProInfo setTitle:@"\U0000e60a" forState:UIControlStateNormal];
    [RightBackProInfo addTarget:self action:@selector(infotellConFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBackProInfo];
    
    self.navigationItem.rightBarButtonItem = RightButtonItem;
    
    ViewB = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;

    [self.view addSubview:ViewB];
    
    [self WebGetDataProductInfo];
    [self OriderFunc];


}

-(void)WebGetDataProductInfo{

    webView = [[UIWebView alloc]initWithFrame:CGRectMake(5,64, SIZE_WIDTH-10,SIZE_HEIGHT-65)];
    webView.delegate = self ;
    webView.backgroundColor = [UIColor whiteColor];
    //是否支持互动
    [webView setUserInteractionEnabled:YES];
    //是否适应屏幕
    [webView setScalesPageToFit:YES];
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    [ViewB addSubview:webView];
    
    NSString *StrUrl = [NSString stringWithFormat:@"%@ios/product_info.htm?id=%@",[USER_DEFAULT objectForKey:@"SERVERIP"],Product_id];

    NSURL *url= [NSURL URLWithString:StrUrl];
   
    [webView loadRequest:[NSURLRequest requestWithURL:url]];

}

#pragma mark -下单按钮
-(void)OriderFunc{
    
    buttonHeight =50.0;
    
    UIView *_orderView=[[UIView alloc]initWithFrame:CGRectMake(0, SIZE_HEIGHT-buttonHeight, SIZE_WIDTH, buttonHeight)];
    
    UIView *LeftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH*0.3, buttonHeight)];
    LeftView.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];

    PayPrice=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH*0.7-110, buttonHeight)];
    PayPrice.backgroundColor=[UIColor clearColor];
    [PayPrice setFont:[UIFont fontWithName:@"Arial" size:14.0]];
    PayPrice.text=[NSString stringWithFormat:@" ¥ %@.00元",_pric];
    PayPrice.textColor = [UIColor redColor];
    [LeftView addSubview:PayPrice];
    
    [_orderView addSubview:LeftView];
    
    
    UIButton *_CollectionBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _CollectionBut.frame = CGRectMake(SIZE_WIDTH*0.3, 0, SIZE_WIDTH*0.25, buttonHeight);
    [_CollectionBut setTitle:@" 加入收藏 " forState:UIControlStateNormal];
    _CollectionBut.titleLabel.font =[UIFont systemFontOfSize:14.0];
    [_CollectionBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_CollectionBut setBackgroundColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]];
    [_CollectionBut addTarget:self action:@selector(CollectionButFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [_orderView addSubview:_CollectionBut];
    
    UIButton *_CellBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _CellBut.frame = CGRectMake(SIZE_WIDTH*0.55, 0, SIZE_WIDTH*0.25, buttonHeight);
    [_CellBut setTitle:@" 在线咨询 " forState:UIControlStateNormal];
    _CellBut.titleLabel.font =[UIFont systemFontOfSize:14.0];
    [_CellBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_CellBut setBackgroundColor:[UIColor colorWithRed:247/255.0 green:192/255.0 blue:119/255.0 alpha:1.0]];
    [_CellBut addTarget:self action:@selector(CellButFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [_orderView addSubview:_CellBut];

    
    UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake(SIZE_WIDTH*0.8, 0, SIZE_WIDTH*0.2, buttonHeight)];
    
    UIButton *_OrderButPay = [UIButton buttonWithType:UIButtonTypeCustom];
    _OrderButPay.frame = CGRectMake(0, 0, SIZE_WIDTH*0.2, buttonHeight);
    [_OrderButPay setTitle:@" 立即购买 " forState:UIControlStateNormal];
    _OrderButPay.titleLabel.font =[UIFont systemFontOfSize:14.0];
    [_OrderButPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_OrderButPay setBackgroundColor:[UIColor colorWithRed:245/255.0 green:91/255.0 blue:91/255.0 alpha:1.0]];
    [_OrderButPay addTarget:self action:@selector(OrderProductFuncinfo:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [rightView addSubview:_OrderButPay];
    

    
    [_orderView addSubview:rightView];
    
    [ViewB addSubview:_orderView];

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationTyp{
    
    NSString *requestString = [[[request URL] absoluteString]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"requestString : %@",requestString);
    
    
    NSArray *components = [requestString componentsSeparatedByString:@"|"];
    NSLog(@"=components=====%@",components);
    
    
    NSString *str1 = [components objectAtIndex:0];
    NSLog(@"str1:::%@",str1);
    
    
    NSArray *array2 = [str1 componentsSeparatedByString:@"/"];
    NSLog(@"array2:====%@",array2);
    
    
    NSInteger coun = array2.count;
    NSString *method = array2[coun-1];
    NSLog(@"method:===%@",method);
    
    if ([array2 count]>3) {
        
        if ([[array2 objectAtIndex:3] isEqualToString:@"product"]) {
            
            NSArray *proarray = [[array2 objectAtIndex:4] componentsSeparatedByString:@"="]; //从字符A中分隔成2个元素的数组
            NSLog(@"array:%@",[proarray objectAtIndex:1]); //结果是adfsfsfs和dfsdf
            [self GetHttpsDataProductslistss:[proarray objectAtIndex:1]];
            
        }
    }
    
    if ([array2 count]>3) {
        
        if ([[array2 objectAtIndex:3] isEqualToString:@"mycenter"]) {
            
            return YES;
        }
    }
    
    
    if (navigationTyp == UIWebViewNavigationTypeLinkClicked)
    {
        NSURL *url = [request URL];
        NSLog(@"url--%@",url);
        // 这里加入判断语句，判断网页url，是否需要继续跳转，或是使用原生页面
        return NO; // 返回NO，结束网页跳转，如果要继续跳转，需要返回YES
    }
    
    return YES;
}

//跳转到产品
-(void)prodouctFunc:(NSString *)proid prices:(NSString *)price{
    
//    
//    ProductInfoController *productCon = [[ProductInfoController alloc]init];
//    
//    @try {
//        
//        productCon.Product_id =proid;
//        productCon.pric = price;
//        productCon.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:productCon animated:YES];
//        
//    } @catch (NSException *exception) {
//        
//    } @finally {
//        
//    }
//
    NSString *StrUrl = [NSString stringWithFormat:@"%@ios/product_info.htm?id=%@",[USER_DEFAULT objectForKey:@"SERVERIP"],proid];
    
    NSURL *url= [NSURL URLWithString:StrUrl];
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    _pric = price;
    Product_id=proid;
    PayPrice.text=[NSString stringWithFormat:@" ¥ %@.00元",_pric];
    
}

#pragma mark -产品数据json解析
-(void)GetHttpsDataProductslistss:(NSString *)proid{
    
    
    NSString *sUrl = product_urls;
    NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
    NSString *strUrl =[NSString stringWithFormat:@"%@%@",URL,sUrl];
    
    
    NSString *StrUrl = [NSString stringWithFormat:@"%@id=%@",strUrl,proid];
    manager = [AFHTTPSessionManager manager];
    NSString *encoded = [StrUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"encoded%@",encoded);
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    
    [manager GET:encoded parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        productArray  = responseObject;
        
        NSLog(@"arrayMutableProduct%@",productArray);
        if(productArray!=nil){
            
            NSString *strPrice = [[productArray objectAtIndex:0] valueForKey:@"price"];
            [self prodouctFunc:proid prices:strPrice];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


#pragma mark -下单按钮事件
-(void)OrderProductFuncinfo:(id)sender{
    
    
    if ([USER_DEFAULT valueForKey:@"user_id"] == NULL) {

        [self loginController];
        return;
        
    }

    ProductOrderController *proOrederCon = [[ProductOrderController alloc]init];
    proOrederCon.Pro_id = Product_id;

    [self.navigationController pushViewController:proOrederCon animated:YES];
    
}

#pragma mark -登陆
#pragma mark -调用登陆Controller
-(void)loginController{
    
    loginCon=[[LoginController alloc]init];
    loginNav=[[UINavigationController alloc]initWithRootViewController:loginCon];
    [self presentViewController:loginNav animated:YES completion:^{
        
    }];
    
}
#pragma mark - 自定义返回按钮事件
-(void)BackFunc:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark -拨打电话方法
-(void)infotellConFunc:(id)sender{
    
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    NSString *tel = [NSString stringWithFormat:@"tel:%@",[USER_DEFAULT valueForKey:@"phone"]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tel]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}

//加入收藏按钮方法
-(void)CollectionButFunc:(id)sender{

    if ([USER_DEFAULT valueForKey:@"user_id"] == NULL) {
        
        [self loginController];
        return;
        
    }else{
    
        [self CollectionSaveProduct];
    
    }
 
}
//发送收藏请求
-(void)CollectionSaveProduct{

    NSLog(@"---shoucang---");
    //添加参数
    NSDictionary *parameters=@{@"id":[USER_DEFAULT objectForKey:@"user_id"],@"pid":Product_id};
    NSString *telUrl = ios_favorite_add;
    NSString *strurlLogin=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],telUrl];
    
    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求
    [manager POST:strurlLogin parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSString *tishiMessage = @"";
        
        NSLog(@"responseObject%@",responseObject);
        if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"succ"]) {
        
            tishiMessage = @"收藏成功";
            
        }else if([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"already"]){
        
            tishiMessage = @"您已经收藏过该产品了！";
        
        }else{
        
            tishiMessage = @"系统繁忙,请您稍后在试哦!";
        
        }
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"大肚婆" message:tishiMessage preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


}

#pragma mark -在线咨询
-(void)CellButFunc:(id)sender{


    onlineNav = [[UINavigationController alloc]initWithRootViewController:self.onlineCon];
    [self presentViewController:onlineNav animated:YES completion:^{
       
        NSLog(@"回调");
        
    }];

}

-(OnlineController *)onlineCon{

    NSLog(@"懒加载");
    _onlineCon=[[OnlineController alloc]init];
    return _onlineCon;

}


#pragma mark -手机内存报警
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end

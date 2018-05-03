//
//  MysaveController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/9.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "MysaveController.h"

@interface MysaveController ()

@end

@implementation MysaveController

@synthesize Product_id;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"我的收藏";
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
    
    
}

-(void)WebGetDataProductInfo{
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(15,64, SIZE_WIDTH-20,SIZE_HEIGHT-65)];
    webView.delegate = self ;
    webView.backgroundColor = [UIColor whiteColor];
    //是否支持互动
    [webView setUserInteractionEnabled:YES];
    //是否适应屏幕
    [webView setScalesPageToFit:YES];
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    [ViewB addSubview:webView];
    
    NSString *StrUrl = [NSString stringWithFormat:@"http://ddp.lzsg120.com/mycenter/my_favorite.htm?user_id=%@&ios=1",[USER_DEFAULT objectForKey:@"user_id"]];
    NSLog(@"StrUrl------%@",StrUrl);
    NSURL *url= [NSURL URLWithString:StrUrl];
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
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
    
    
        ProductInfoController *productCon = [[ProductInfoController alloc]init];
    
        @try {
    
            productCon.Product_id =proid;
            productCon.pric = price;
            productCon.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:productCon animated:YES];
    
        } @catch (NSException *exception) {
    
        } @finally {
    
        }
    
//    NSString *StrUrl = [NSString stringWithFormat:@"http://fx.lzspa.com:8088/ios/product_info.htm?id=%@",proid];
//    
//    NSURL *url= [NSURL URLWithString:StrUrl];
//    
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
//    
//    _pric = price;
//    Product_id=proid;
//    PayPrice.text=[NSString stringWithFormat:@" ¥ %@.00元",_pric];
    
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



#pragma mark -手机内存报警
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end

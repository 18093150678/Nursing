//
//  findController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/6.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "findController.h"

@interface findController ()

@end

@implementation findController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"发现";
    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.translucent = YES;
    
  


}

-(void)viewWillAppear:(BOOL)animated{

    [self webfunc];

}

-(void)webfunc{

    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT-64)];
    NSString *url=[NSString stringWithFormat:@"%@%@?user_id=%@&ios=1",[USER_DEFAULT objectForKey:@"SERVERIP"],@"/mycenter/find.htm",[USER_DEFAULT objectForKey:@"user_id"]];
    webView.delegate=self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:webView];

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
            return NO;
            
        }
    }
    
    if ([array2 count]>3) {
        
        if ([[array2 objectAtIndex:3] isEqualToString:@"mycenter"]) {
            
            return YES;
        }
    }

    
       
    return YES;
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
        
        findArray  = responseObject;
        
        NSLog(@"arrayMutableProduct%@",findArray);
        if(findArray!=nil){
            
            NSString *strPrice = [[findArray objectAtIndex:0] valueForKey:@"price"];
            [self prodouctFunc:proid prices:strPrice];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
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
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

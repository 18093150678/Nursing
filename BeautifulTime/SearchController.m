//
//  SearchController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/6.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"搜索";
    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *CollLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CollLeftBack.frame =CGRectMake(0, 0, 30, 30);
    [CollLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    CollLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [CollLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [CollLeftBack addTarget:self action:@selector(sreachBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:CollLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    
    CGRect mainViewBounds = self.navigationController.view.bounds;
    mcustomSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+22, CGRectGetWidth(mainViewBounds)-120, 40)];
    // customSearchBar.text=;
    mcustomSearchBar.placeholder = @"搜索项目,专家,资讯";
    UITextField * searchField = [mcustomSearchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    mcustomSearchBar.delegate = self;
    mcustomSearchBar.showsCancelButton = NO;
    mcustomSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    self.navigationItem.titleView = mcustomSearchBar;

    
    self.navigationController.navigationBar.translucent = YES;
    
    
    searchwebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT-64)];
    searchwebView.delegate=self;
    NSString *strSearchTitle = [_searchTitle stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *url=[NSString stringWithFormat:@"%@%@?searchKey=%@&ios=1",[USER_DEFAULT objectForKey:@"SERVERIP"],@"ios_search_list.htm",strSearchTitle];
    NSLog(@"url-----%@",url);
    [searchwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:searchwebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -返回按钮
-(void)sreachBackFunc:(id)sender{
    
 //   [self.navigationController popViewControllerAnimated:YES];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
    }];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"sousuo%@",mcustomSearchBar.text);
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
   
    NSString *strSearchTitle = [mcustomSearchBar.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *url=[NSString stringWithFormat:@"%@%@?searchKey=%@&ios=1",[USER_DEFAULT objectForKey:@"SERVERIP"],@"ios_search_list.htm",strSearchTitle];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    // 3.加载网页
    [searchwebView loadRequest:request];
    
    
  //  [searchwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
 

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
        
        searchProarray  = responseObject;
        
        NSLog(@"arrayMutableProduct%@",searchProarray);
        if(searchProarray!=nil){
        
            NSString *strPrice = [[searchProarray objectAtIndex:0] valueForKey:@"price"];
            [self prodouctFunc:proid prices:strPrice];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


@end

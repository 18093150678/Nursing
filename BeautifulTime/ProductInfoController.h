//
//  ProductInfoController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/10.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "ProductOrderController.h"
#import "LoginController.h"
#import "AFHTTPSessionManager.h"
#import "OnlineController.h"


@interface ProductInfoController : UIViewController<UIWebViewDelegate>{

    UIView *ViewB;
    
    UIWebView *webView;
    NSString *Product_id;
    
    LoginController *loginCon;
    UINavigationController *loginNav;
    
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    
    NSArray *productArray;
    UILabel *PayPrice;
    
    UINavigationController *onlineNav;


}

@property(nonatomic,strong)NSString *Product_id;
@property(nonatomic,strong)NSString *pric;
@property(nonatomic,strong)OnlineController *onlineCon;

@end

//
//  MysaveController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/9.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "ProductOrderController.h"
#import "LoginController.h"
#import "AFHTTPSessionManager.h"

@interface MysaveController : UIViewController<UIWebViewDelegate>{

    UIView *ViewB;
    
    UIWebView *webView;
    NSString *Product_id;
    
    LoginController *loginCon;
    UINavigationController *loginNav;
    
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    
    NSArray *productArray;
    UILabel *PayPrice;


}

@property(nonatomic,strong)NSString *Product_id;
@property(nonatomic,strong)NSString *pric;



@end

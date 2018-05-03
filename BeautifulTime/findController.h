//
//  findController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/6.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "AFHTTPSessionManager.h"
#import "ProductInfoController.h"

@interface findController : UIViewController<UIWebViewDelegate>{

    UIWebView *webView;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSArray *findArray;

}

@end

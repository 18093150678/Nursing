//
//  QuestionController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "AFHTTPSessionManager.h"
#import "Pretreatment.h"
#import "CateGoryClass.h"
#import "AsynImageView.h"
#import "QuesstionAddController.h"
#import "LoginController.h"
#import "quesstionmodelController.h"

@interface QuestionController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,UIScrollViewDelegate>{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    UITableView *TableView;
    NSMutableArray *quesstionArray;
    NSMutableArray *quesstionArrayImage;
    UITapGestureRecognizer *tapGesture;
    
    LoginController *loginCon;
    UINavigationController *loginNav;
    
    UIWebView *webView;


}

@end

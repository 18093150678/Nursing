//
//  OrderInfoController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "Pretreatment.h"
#import "LoginController.h"
#import "AFHTTPSessionManager.h"
#import "JSONKit.h"
#import "AsynImageView.h"
#import "ProductInfoController.h"
#import "NewPayProController.h"

@interface OrderInfoController : UIViewController<UITableViewDataSource,UITableViewDelegate>{


    AFHTTPSessionManager *manager; //创建请求（iOS 6-10.0）
    LoginController *loginCon;
    UINavigationController *loginNav;
    UITableView *TableView;

    UIImageView *loginImageView;
    
    //获取json数据数组字典定义
    NSMutableArray *cellArray;
    NSString *type;
    
    
    //等待加载指示控件
    UIActivityIndicatorView* activityIndicatorView;
    
    //全局网络状态标示符
    NSString *netStatus;
    
    UISegmentedControl *sc;
    UIView *backgroundView;

}

@property (nonatomic, strong) UIRefreshControl* refreshControl;


@end

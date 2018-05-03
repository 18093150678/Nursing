//
//  IntegralController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/19.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"

@interface IntegralController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    UITableView *appTableView;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-10.0）
    NSArray *datelist;

}

@property (nonatomic, strong) UIRefreshControl* refreshControl;

@end

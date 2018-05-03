//
//  MyorderController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/12/9.
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

@interface MyorderController : UIViewController<UITableViewDataSource,UITableViewDelegate>{


    AFHTTPSessionManager *manager; //创建请求（iOS 6-10.0）
    LoginController *loginCon;
    UINavigationController *loginNav;
    UITableView *TableView;
    
    UIImageView *loginImageView;
    
    //获取json数据数组字典定义
    NSMutableArray *cellArray;
    NSString *type;


}


@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (nonatomic, strong) id deleClass;
@end

//
//  inspectController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/5.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "AsynImageView.h"
#import "ProductInfoController.h"

@interface inspectController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    UITableView *insectTableView;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    
    NSMutableArray *cellArray;

}
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@end

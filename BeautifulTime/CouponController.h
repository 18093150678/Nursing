//
//  CouponController.h
//  BeautifulTime
//
//  Created by lee on 2017/7/19.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "AFHTTPSessionManager.h"

@interface CouponController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）

}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *couponArray;
@property (nonatomic,strong)NSString *pro_id;

@end

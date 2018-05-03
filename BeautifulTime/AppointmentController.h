//
//  AppointmentController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/13.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "AsynImageView.h"
#import "FindDoctorController.h"

@interface AppointmentController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    UITableView *appTableView;
    
    AFHTTPSessionManager *manager; //创建请求（iOS 6-10.0）
    
    NSArray *datelist;
    
    NSString *intemStrStatus;


}

@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (nonatomic, strong) NSString *jionClass;

@end

//
//  FindDoctorController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/2.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "DoctorInfoController.h"
#import "AFHTTPSessionManager.h"
#import "AsynImageView.h"

@interface FindDoctorController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    UITableView *FindDoctTableView;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSArray *doctArray;

}

@end

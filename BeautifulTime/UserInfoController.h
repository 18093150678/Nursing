//
//  UserInfoController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"
#import "UserAddressController.h"
#import "MoreController.h"
#import "Pretreatment.h"
#import "MyorderController.h"
#import "FeedbackController.h"
#import "DeleteController.h"
#import "AFHTTPSessionManager.h"
#import "userinfochangeController.h"

@interface UserInfoController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{

    UIImageView *loginImageView;
    
    NSArray *userInfoArray;
    LoginController *loginCon;
    UINavigationController *loginNav;
    UIView *backgroundView;
    
    NSString *userNameFix;
    
    UILabel *jifenLabel;
    
    MyorderController *myorderCon;

    AFHTTPSessionManager *manager;
    
    NSString *week;
    NSString *day;
    UILabel *YunqiName;
    NSString *yunqi;
    
    NSString *imagePathUrl;
    UIImageView *headerImagelogo;
    UIImage *saveimage;
    
    UILabel *userName;
    
    
    
}

@property  (strong,nonatomic) UITableView *TableViews;

@end

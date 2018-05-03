//
//  TeYueDoctorWebController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/8.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "AFHTTPSessionManager.h"
#import "LoginController.h"
#import "AppointmentController.h"

@interface TeYueDoctorWebController : UIViewController<UIWebViewDelegate>{

    UIWebView *searchwebView;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    LoginController *loginCon;
    UINavigationController *loginNav;

}
@property(nonatomic,strong)NSString *doctorID;
@property(nonatomic,strong)NSString *teyuejonClass;
@end

//
//  LoginController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/8.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "JSONKit.h"
#import "Pretreatment.h"
#import "UserMesaageinfoController.h"

@interface LoginController : UIViewController{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSThread *myThreadone;
    NSString *StrCode;
    NSString *resultSMS;
    NSString *user_id;
    NSString *yunqi;
    NSString *jitai;
    NSString *nickname;
    NSString *sex;
    NSString *headimgurl;
    
    UIButton *b_button;
    UILabel *labelBut;

}

@end

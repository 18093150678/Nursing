//
//  ChangeAddressController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/22.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "Pretreatment.h"

@interface ChangeAddressController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-10.0）
    NSThread *myThreadone;
    //姓名
    UITextField *ReserveProes;
    //手机号
    UITextField *ReservetelProes;
    //地址
    UITextField *ReserveAddresProes;
    //默认
    NSString *def;
    //全局背景
    UIView *backGroundView;
    
    
    NSDictionary *addressArrayDict;
    
    UIAlertController *alertCon;
    
    UIView *changebackGroundView;
}

@property(nonatomic,strong)NSDictionary *addressArrayDict;



@end

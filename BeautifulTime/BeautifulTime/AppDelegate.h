//
//  AppDelegate.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertisingScrollController.h"
#import "AFHTTPSessionManager.h"
#import "WXApi.h"
#import "AlipayResponseClass.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate,AdvertisingScrollDelegate,UITabBarControllerDelegate,WXApiDelegate>{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）

}

@property (strong, nonatomic) UIWindow *window;




@end


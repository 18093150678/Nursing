//
//  AppDelegate.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexTimeController.h"
#import "QuestionController.h"
#import "OrderInfoController.h"
#import "UserInfoController.h"
#import "Pretreatment.h"
#import "InformationController.h"
#import "findController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UMSocialCore/UMSocialCore.h>

static NSString* const UMS_WebLink = @"http://ddp.lzsg120.com";


#define USHARE_DEMO_APPKEY @"5925a3931c5dd052f70018dd"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    [[UMSocialManager defaultManager] openLog:YES];
    // 打开图片水印
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];

    [self configUSharePlatforms];
    
    
    
    AFNetworkReachabilityManager *managerNet = [AFNetworkReachabilityManager sharedManager];
    
    [managerNet startMonitoring];
    
    
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [managerNet setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"status");
                switch (status) {
                    case AFNetworkReachabilityStatusUnknown:
                        NSLog(@"未知网络状态");
                    {
                  //      NSNotification *internetnotifications = [NSNotification notificationWithName:@"interNet" object:nil userInfo:@{@"interNet":@"YesNet"}];
                  //      [[NSNotificationCenter defaultCenter] postNotification:internetnotifications];
                        
                    }

                        break;
                    case AFNetworkReachabilityStatusNotReachable:
                        NSLog(@"无网络");
                        //无网络发送通知
                    {
                        NSNotification *internetnotifications = [NSNotification notificationWithName:@"interNet" object:nil userInfo:@{@"interNet":@"notNet"}];
                        [[NSNotificationCenter defaultCenter] postNotification:internetnotifications];
                        
                    }
                        break;
        
                    case AFNetworkReachabilityStatusReachableViaWWAN:
                        NSLog(@"蜂窝数据网");
                    {
                   //     NSNotification *internetnotifications = [NSNotification notificationWithName:@"interNet" object:nil userInfo:@{@"interNet":@"YesNet"}];
                   //     [[NSNotificationCenter defaultCenter] postNotification:internetnotifications];
                        
                    }

                        break;
        
                    case AFNetworkReachabilityStatusReachableViaWiFi:
                        NSLog(@"WiFi网络");
                    {
                    //    NSNotification *internetnotifications = [NSNotification notificationWithName:@"interNet" object:nil userInfo:@{@"interNet":@"YesNet"}];
                   //     [[NSNotificationCenter defaultCenter] postNotification:internetnotifications];
                        
                    }

        
                        break;
                        
                    default:
                        
                        break;
                }
    }];

    //微信注册
    
   [WXApi registerApp:@"wx002c4c8100c6173c"];
    
    
    [self GetHttpUrlFunc];
    
    AdvertisingScrollController *Advertising =[[AdvertisingScrollController alloc]init];
    Advertising.delegate = self;
    
    
    //判断客户端是不是第一次打开
    if ([self isFirstEverUsed]) {


        [USER_DEFAULT setObject:NULL forKey:@"UserName"];
        [USER_DEFAULT setObject:NULL forKey:@"user_id"];
        [USER_DEFAULT setObject:NULL forKey:@"yunqi"];
        [USER_DEFAULT setObject:NULL forKey:@"numtai"];
        [USER_DEFAULT setObject:NULL forKey:@"nicheng"];
        [USER_DEFAULT setObject:NULL forKey:@"sex"];
        [USER_DEFAULT setObject:NULL forKey:@"userLogo"];
        [USER_DEFAULT setObject:NULL forKey:@"headimgurl"];
        
        self.window.rootViewController = Advertising;
        
    }else{
        
       [self goButtonProcessWhat];
    
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)isFirstEverUsed
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"userDefaults%@",userDefaults);
    //第一次启动时，会创建“everUsed”键值，并默认为假
    if (![userDefaults boolForKey:@"isFirstEverUsed"]) {
        [userDefaults setBool:YES forKey:@"isFirstEverUsed"];
        return YES;
    }
    else{
        return NO;
    }
}



-(void)goButtonProcessWhat{

    NSLog(@"收到");
    
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:255/255.0
                                                        green:51/255.0
                                                         blue:84/255.0
                                                        alpha:0.8]];
    
    //设定Tabbar的颜色
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    //定义所有需要加载进标签栏的窗口控制器
    IndexTimeController *indexTimeCon = [[IndexTimeController alloc]init];
//    UITabBarItem *indexTimeTb=[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"index.png"] selectedImage:[UIImage imageNamed:@"index_s.png"]];
//    indexTimeCon.tabBarItem=indexTimeTb;
    UINavigationController *indexTimeNav = [[UINavigationController alloc]initWithRootViewController:indexTimeCon];
    [indexTimeNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    QuestionController  *QuestionCon  = [[QuestionController alloc]init];
   
//    UIImage *musicImage = [UIImage imageNamed:@"chat.png"];
//    UIImage *musicImageSel = [UIImage imageNamed:@"chat_s.png"];
//    UITabBarItem *QuestionConTb=[[UITabBarItem alloc]initWithTitle:@"问问" image:musicImage selectedImage:musicImageSel];


//    QuestionCon.tabBarItem=QuestionConTb;
    UINavigationController *QuestionNav = [[UINavigationController alloc]initWithRootViewController:QuestionCon];
    
    findController *OrderinfoCon= [[findController alloc]init];
//    InformationController *OrderinfoCon = [[InformationController alloc]init];
//    UITabBarItem *OrderinfoConTb=[[UITabBarItem alloc]initWithTitle:@"订单" image:[UIImage imageNamed:@"orderinfo.png"] selectedImage:[UIImage imageNamed:@"orderinf_s.png"]];
//    OrderinfoCon.tabBarItem=OrderinfoConTb;
    UINavigationController *OrderinfoNav = [[UINavigationController alloc]initWithRootViewController:OrderinfoCon];
    
    UserInfoController  *UserInfoCon  = [[UserInfoController alloc]init];
    
//    UITabBarItem *UserInfoConTb=[[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"user.png"] selectedImage:[UIImage imageNamed:@"user_s.png"]];
//    UserInfoCon.tabBarItem=UserInfoConTb;
    UINavigationController *UserInfoNav = [[UINavigationController alloc]initWithRootViewController:UserInfoCon];
    
    UITabBarController *tabBarView = [[UITabBarController alloc]init];
    
    NSArray *controlArray = [[NSArray alloc]initWithObjects:indexTimeNav,QuestionNav,OrderinfoNav,UserInfoNav, nil];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 49)];
    backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbarBack.png"]];

    [tabBarView.tabBar insertSubview:backView atIndex:0];
    tabBarView.tabBar.opaque = YES;

    
    //给tabbarView定义视图控制器组
    tabBarView.viewControllers = controlArray;
    
    //设定默认显示第几个视图 默认为0

    tabBarView.selectedIndex = 0;
    
    tabBarView.delegate = self;
    
    //把tabBarController的view作为子视图添加到window
    
    UITabBar *tabBar = tabBarView.tabBar;
    
    
    [tabBar setTintColor:[UIColor redColor]];
    [tabBar setUnselectedItemTintColor:[UIColor blackColor]];
    
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    
    // 对item设置相应地图片
    item0.title=@"首页";
//    tabBarView.tabBar.tintColor=[UIColor redColor];
    item0.selectedImage = [[UIImage imageNamed:@"index.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.image = [[UIImage imageNamed:@"index_s.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    item1.title=@"远程问诊";
    item1.selectedImage = [[UIImage imageNamed:@"chat.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"chat_s.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item2.title=@"发现";
    item2.selectedImage = [[UIImage imageNamed:@"orderinfo.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"orderinfo_s.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item3.title=@"我的";
    item3.selectedImage = [[UIImage imageNamed:@"user.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item3.image = [[UIImage imageNamed:@"user_s.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    self.window.rootViewController = tabBarView;

}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    NSLog(@"切换");
    return  true;

}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    /*! @brief 处理微信通过URL启动App时传递的数据
     *
     * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
     * @param url 微信启动第三方应用时传递过来的URL
     * @param delegate  WXApiDelegate对象，用来接收微信触发的消息。
     * @return 成功返回YES，失败返回NO。
     */
    
    AlipayResponseClass *alipayRespon= [[AlipayResponseClass alloc]init];
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result  apysdk = %@",resultDic);
            
           
            NSString *resultStatus = resultDic[@"resultStatus"];
            NSString *result = resultDic[@"result"];
//            NSDictionary *str = resultDic[@"alipay_trade_app_pay_response"];
//            NSLog(@"str%@",str);
//            NSLog(@"str%@",[result objectFromJSONString]);
//            NSLog(@"str%@",[[result objectFromJSONString] objectForKey:@"sign"]);
//            NSLog(@"str%@",[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"app_id"]);
            
//            NSDictionary *alipayresponseDict = [[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"];
            
            if ([resultStatus isEqualToString:@"9000"]) {
                
                NSLog(@"支付成功");
                alipayRespon.app_id=[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"app_id"];
                alipayRespon.auth_app_id=[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"auth_app_id"];
                alipayRespon.charset=[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"charset"];
                alipayRespon.code=[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"code"];
                alipayRespon.msg=[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"msg"];
                alipayRespon.out_trade_no=[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"out_trade_no"];
                alipayRespon.seller_id=[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"seller_id"];
                alipayRespon.timestamp=[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"timestamp"];
                alipayRespon.total_amount=[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"total_amount"];
                alipayRespon.sign_type=[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"sign_type"];
                alipayRespon.trade_no=[[[result objectFromJSONString] objectForKey:@"alipay_trade_app_pay_response"] objectForKey:@"trade_no"];
                alipayRespon.sign=resultDic[@"sign"];
                alipayRespon.sign=resultDic[@"resultStatus"];
                
                //支付成功后发送通知给订单页面
                //创建通知实例
                { NSNotification *notification= [NSNotification notificationWithName:@"zfb_pay" object:@"success"];
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                }
                
            }
            
            
        }];
        
    }else{
    
        return  [WXApi handleOpenURL:url delegate:self];
    
    }
    
    
    return YES;
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return result;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        return [WXApi handleOpenURL:url delegate:self];
    }
    return result;
}


- (void)onResp:(BaseResp *)resp
{
    
    NSLog(@"进来了没有呢");
    
    //支付返回结果，实际支付结果需要去微信服务器端查询
    NSString *strMsg = [NSString stringWithFormat:@"支付结果"];
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            //支付成功后发送通知给订单页面
            //创建通知实例
        { NSNotification *notification= [NSNotification notificationWithName:@"wx_pay" object:@"success"];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
            
            break;
        case WXErrCodeUserCancel:
            strMsg = @"支付结果：用户点击取消！";
            
            break;
        case WXErrCodeSentFail:
            strMsg = @"支付结果：发送失败！";
            
            break;
        case WXErrCodeAuthDeny:
            strMsg = @"支付结果：授权失败！";
            
            break;
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            NSNotification *notifications = [NSNotification notificationWithName:@"wx_pay" object:@"fail"];
            [[NSNotificationCenter defaultCenter] postNotification:notifications];
            break;
    }
}

#pragma -mark 获取服务器地址
-(void)GetHttpUrlFunc{
   
    NSString *strUrl = GetServeriPUrl;
    //创建链接
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    
    [manager GET:strUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *ServerIPuRL =[[responseObject objectAtIndex:0] valueForKey:@"url"];
        NSString *ServerIPphone =[[responseObject objectAtIndex:0] valueForKey:@"phone"];
       // NSString *ServerIPuser_id =[[responseObject objectAtIndex:0] valueForKey:@"user_id"];
        
        NSLog(@"ServerIPuRL%@",responseObject);
        
        [USER_DEFAULT setObject:ServerIPuRL forKey:@"SERVERIP"];
        [USER_DEFAULT setObject:ServerIPphone forKey:@"phone"];
     //   [USER_DEFAULT setObject:ServerIPuser_id forKey:@"user_id"];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
  
    
}


- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx002c4c8100c6173c" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:UMS_WebLink];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106187150"/*设置QQ平台的appID*/  appSecret:nil redirectURL:UMS_WebLink];

    
    
    }

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

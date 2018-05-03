//
//  BookingController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/11.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import <WebKit/WebKit.h>

@interface BookingController : UIViewController<UIWebViewDelegate>{

    UIWebView *BookingwebView;

}

@property (nonatomic ,strong)NSString *infomentID;

@end

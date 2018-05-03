//
//  CollectionOneController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/27.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Pretreatment.h"

@interface CollectionOneController : UIViewController{

    WKWebView *webView;

}
@property(nonatomic,retain)NSString *WebUrl;

@end

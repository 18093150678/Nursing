//
//  InfoMessageController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/14.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"

@interface InfoMessageController : UIViewController<UIWebViewDelegate>{

    UIWebView *webView;

}

@property (nonatomic ,strong)NSString *infomentID;
@end

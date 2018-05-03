//
//  indexScrollerController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/3/11.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"

@interface indexScrollerController : UIViewController<UIWebViewDelegate>{

    UIWebView *scrowebView;
    
}

@property (nonatomic ,strong)NSString *infomentID;

@end

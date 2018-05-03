//
//  SearchController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/6.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "ProductInfoController.h"
#import "AFHTTPSessionManager.h"

@interface SearchController : UIViewController<UISearchBarDelegate,UIWebViewDelegate>{

    UIWebView *searchwebView;
    UISearchBar *mcustomSearchBar;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSArray *searchProarray;

}


@property(nonatomic,retain)NSString *searchTitle;


@end

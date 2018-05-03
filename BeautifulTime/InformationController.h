//
//  InformationController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/11.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "AFHTTPSessionManager.h"
#import "JSONKit.h"
#import "CollectionView.h"
#import "InfoMessageController.h"
#import "AsynImageView.h"
#import "TFFDictClass.h"


@interface InformationController : UIViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    UITableView *TabView;
    NSMutableArray *cellArray;
    
    NSArray *fontArray;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    
    NSMutableArray *infoArray;
    NSMutableArray *newlist;
    
    CollectionView *collection;
    
    NSString *sid;
    
    TFFDictClass *tff;

}

@property (nonatomic, strong) UIRefreshControl* refreshControl;

@end

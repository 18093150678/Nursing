//
//  IndexTimeController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "AFHTTPSessionManager.h"
#import "JSONKit.h"
#import "LoginController.h"
#import "BookingController.h"
#import "ScrollView.h"
#import "FindDoctorController.h"
#import "CollectionTowController.h"
#import "inspectController.h"
#import "SearchController.h"


@interface IndexTimeController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{

    UITableView *TableView;
    NSArray *_allProvinces;
    NSMutableArray *imageMutableArray;
    NSArray *ListMenuArray;
    AFHTTPSessionManager *manager; 
    NSArray *arrayMutableArray;
    
    UISearchBar *customSearchBar;
    
    
    //获取json数据数组字典定义
    NSMutableArray *scroArray;
    NSMutableArray *menuArray;
    NSMutableArray *cellArray;

    //人气最热标示符
    NSString *isHot;
    
    //全局网络状态标示符
    NSString *netStatus;
    
    UIActivityIndicatorView* activityIndicatorView;
    
    LoginController *indexloginCon;
    UINavigationController *indexloginNav;
    
    ScrollView *scro;
    
    UIButton *selectBut_1;
    UIButton *selectBut_2;
    
    UILabel *minuteLabel;
    UILabel *hourLabel;
    UILabel *secondLabel;
    UILabel *dayLabel;
    
    UILabel *jiange_1;
    UILabel *jiange_2;
    
    UINavigationController *SearchNav;
}

@property (nonatomic, strong) UIRefreshControl* refreshControl;

@end

//
//  UserAddressController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/17.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddUserAdressController.h"
#import "ChangeAddressController.h"
#import "AFHTTPSessionManager.h"
#import "Pretreatment.h"

@interface UserAddressController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    UITableView *TabLeView;
    UIView *backgroundView;
    
    //地址列表数组 该数组中存放的是字典类型数据
    NSMutableArray *AddressArray;

}

@property (nonatomic, strong) UIRefreshControl* refreshControl;

@end

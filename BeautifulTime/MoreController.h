//
//  MoreController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/19.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "DeleteController.h"

@interface MoreController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    UITableView *TableView;
    NSArray *userInfoArray;

}

@end

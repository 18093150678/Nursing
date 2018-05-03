//
//  QuesstionAddController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/17.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "Pretreatment.h"


@interface QuesstionAddController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    UITextView *quesstionView;
    UIImageView *addImage;
    UIView *QuesstionView;
    NSString *imagePathUrl;
    
    UIActivityIndicatorView* quessactivityIndicatorView;
    
    UIView *doctview;
    
    NSString *selectstatus;
    NSArray *doctArray;
    NSString *doctid;
    NSString *doctname;
    
    UILabel *douctrlable;
    
    NSArray *labelArray;
    UIButton *selectButsss;
    
    NSString *labelID;

}

@property (nonatomic,strong)UITableView *tableview;

@end

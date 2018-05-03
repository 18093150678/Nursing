//
//  userinfochangeController.h
//  BeautifulTime
//
//  Created by lee on 2017/4/25.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "AFHTTPSessionManager.h"
#import "AsynImageView.h"
#import<AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>

#import<CoreLocation/CoreLocation.h>

@interface userinfochangeController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>{

    UITableView *userTable;
    UIView *backgroundView;
    UIImageView *userLogoImage;
    UIImage *saveimage;
    NSString *imageUrl;
    
    AFHTTPSessionManager *manager;
    UIActivityIndicatorView* userInfoActivityView;

}

@end

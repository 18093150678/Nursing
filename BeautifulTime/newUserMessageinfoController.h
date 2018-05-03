//
//  newUserMessageinfoController.h
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/10.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"
#import "AFHTTPSessionManager.h"

@interface newUserMessageinfoController : UIViewController<UITextFieldDelegate>{
    
    
    UIImageView *imageViewWonMan;
    UIImageView *imageViewMan;
    
    UIButton *oneBut;
    UIButton *towBut;
    
    UITextField *userExpected;
    UITextField *userNameField;
    
    UIView *view;
    
    int intstatus;
    
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    
    
}

@property(retain,nonatomic)UIDatePicker *datePicker;

@end

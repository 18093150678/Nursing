//
//  FeedbackController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/12/12.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerTimeView.h"
#import "AFHTTPSessionManager.h"

@interface FeedbackController : UIViewController<UITextViewDelegate>{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    UITextView *feedTextFile;
    UILabel *palaceLabel;

}

@end

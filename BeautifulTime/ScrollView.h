//
//  ScrollView.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/7.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "JSONKit.h"
#import "AsynImageView.h"
#import "Pretreatment.h"

@protocol PagedFlowViewDelegate;

@interface ScrollView : UIView<UIScrollViewDelegate>{

    UIScrollView *scroView;
    NSMutableArray *imageArray;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    id <PagedFlowViewDelegate>  _delegates;
    NSMutableArray *arrayimage;

    UIPageControl *pageControl;
    NSTimer *timer;
    
    
    
}

-(id)initWithFrame:(CGRect)frame imageViewArray:(NSMutableArray *)imagearray;
@property(nonatomic,retain)id<PagedFlowViewDelegate> delegates;

@end

@protocol  PagedFlowViewDelegate<NSObject>

@optional
- (void)didSelectItemAtIndex:(NSString *)indexStr;
@end

//
//  AdvertisingScrollController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>

//委托协议
@protocol AdvertisingScrollDelegate <NSObject>

@optional
//协议方法

-(void)goButtonProcessWhat;

@end



@interface AdvertisingScrollController : UIViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate>{

    
    UIScrollView *AdvertisingScroll;
    UIPageControl *pageControl;

}
@property(nonatomic,strong)id<AdvertisingScrollDelegate> delegate;

@end

//
//  AlipayResponseClass.h
//  BeautifulTime
//
//  Created by lee on 2017/5/31.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlipayResponseClass : NSObject

// NOTE: 订单id
@property (nonatomic,copy)NSString *app_id;

// NOTE: auth_app_id
@property (nonatomic,copy)NSString *auth_app_id;

@property (nonatomic,copy)NSString *charset;

@property (nonatomic,copy)NSString *code;

@property (nonatomic,copy)NSString *msg;

@property (nonatomic,copy)NSString *out_trade_no;

@property (nonatomic,copy)NSString *seller_id;

@property (nonatomic,copy)NSString *timestamp;

@property (nonatomic,copy)NSString *total_amount;

@property (nonatomic,copy)NSString *sign_type;

@property (nonatomic,copy)NSString *trade_no;

@property (nonatomic,copy)NSString *sign;

@property (nonatomic,copy)NSString *resultStatus;



@end

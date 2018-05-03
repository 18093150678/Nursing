//
//  DataMD5.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/12/5.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataMD5 : NSObject

@property (nonatomic,strong) NSString *appid;
@property (nonatomic,strong) NSString *mch_id;
@property (nonatomic,strong) NSString *nonce_str;
@property (nonatomic,strong) NSString *partnerkey;
@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) NSString *out_trade_no;
@property (nonatomic,strong) NSString *total_fee;
@property (nonatomic,strong) NSString *spbill_create_ip;
@property (nonatomic,strong) NSString *notify_url;
@property (nonatomic,strong) NSString *trade_type;
@property (nonatomic,strong) NSMutableDictionary *dic;


-(NSString *) md5:(NSString *)str;
@end

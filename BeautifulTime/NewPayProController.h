//
//  NewPayProController.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/12/14.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "Pretreatment.h"
#import "AsynImageView.h"
#import "PickerTimeView.h"
#import "UserAddressController.h"
#import "DeleteController.h"
#import "OrderMessageController.h"


@interface NewPayProController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{

    UITableView *TabLeView;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSMutableArray *arrayMutableProduct;
    NSString *Pro_id;
    UIButton *SelectButWX;
    UIButton *SelectButZFB;
    
    NSInteger pay_Type;
    
    //预约时间
    UILabel *TimeYYY_title;
    
    //时间
    PickerTimeView *pickerTimeview;
    UIView *backgroundview;
    UIView *baseView;
    
    NSMutableArray  *letter;
    NSMutableArray  *number;
    NSMutableArray  *addressList;
    
    UIActivityIndicatorView *act;
    
    //是否遵循协议的常量
    NSString *deleteButStatus;
    
    //购买数量全局变量
    NSInteger payNum;
    
    UILabel *ProNum;
    UILabel *HJPricNum;
    UILabel *SFPricNum;
    UILabel *ProPrice;
    
    //产品类型标签数组
    NSMutableArray *emapArray;
    
    //标签全局变量
    NSInteger bqNumindex;
    
    
    //存储标签按钮数组
    NSMutableArray *arrayBut;



   
}

@property(nonatomic,strong)NSString *Pro_id;
@property(nonatomic,strong)NSMutableDictionary *orderProDictInfo;


@end




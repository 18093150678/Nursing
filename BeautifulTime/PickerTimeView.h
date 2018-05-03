//
//  PickerTimeView.h
//  BeautifulTime
//
//  Created by gansuhaobai on 16/11/28.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"

@interface PickerTimeView : UIPickerView<UIPickerViewDataSource,UIPickerViewDelegate>
{


    NSString *leftStr;
    NSString *rightStr;


}

@property (nonatomic,strong)NSArray * letter;//保存要展示的字母
@property (nonatomic,strong)NSArray * number;//保存要展示的数字

-(NSString *)getPickerviewValue;

@end

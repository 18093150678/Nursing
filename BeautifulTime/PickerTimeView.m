//
//  PickerTimeView.m
//  BeautifulTime
//
//  Created by gansuhaobai on 16/11/28.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "PickerTimeView.h"

@implementation PickerTimeView
@synthesize letter,number;


-(id)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.delegate =self;
        self.dataSource = self;
        self.showsSelectionIndicator = YES;
        [self selectRow:0 inComponent:0 animated:YES];
    
    }
    
    return self;
    
}

#pragma mark -uipickerView DataSource Method 数据源方法
#pragma mark -指定有几个表盘

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 20;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{

    return 100;
}

#pragma mark 指定表盘上有几行数据


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger reslut = 0;
    NSInteger counts;
    
   // self.number = [self.letter[component] valueForKey:@"hour"];
    
    switch (component) {
        case 0:

            reslut = self.letter.count;
    
            break;
        case 1:

            counts = [self selectedRowInComponent:0];
            reslut = [number[counts] count];
            
            break;
  
    }
    
    return reslut;
    
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    if (component==0) {
//        //o列从区域数组中选择
//        return [letter[row] valueForKey:@"date"];
//    }else{
//        //根据0列中选择的行号
//        NSInteger  currentRow=[self selectedRowInComponent:0];
//        return [[[number objectAtIndex:currentRow] objectAtIndex:row] valueForKey:@"h"];
//    }
//}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
  
    CGFloat width = 125.0f;
    CGFloat height = 20.0f;
    
    
    UIView * myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    myView.backgroundColor = [UIColor clearColor];
    
    UILabel * complateLabel = [[UILabel alloc] init];
    complateLabel.center = myView.center;
    complateLabel.bounds = CGRectMake(0, 0, width, height);
    complateLabel.textColor = [UIColor blackColor];
    complateLabel.textAlignment = NSTextAlignmentCenter;
    complateLabel.font = [UIFont systemFontOfSize:16.0];

        if (component==0) {
            //o列从区域数组中选择
            complateLabel.text = [self.letter[row] valueForKey:@"date"];
        }else{
            //根据0列中选择的行号
            NSInteger  currentRow=[self selectedRowInComponent:0];
            complateLabel.text =  [[[number objectAtIndex:currentRow] objectAtIndex:row] valueForKey:@"h"];
        }
    
    [myView addSubview:complateLabel];
    
    ((UIView *)[self.subviews objectAtIndex:1]).backgroundColor = [UIColor colorWithRed:196/255.0 green:195/255.0 blue:200/255.0 alpha:0.1];
    ((UIView *)[self.subviews objectAtIndex:2]).backgroundColor = [UIColor colorWithRed:196/255.0 green:195/255.0 blue:200/255.0 alpha:0.1];
    return myView;
}

#pragma mark - 选中pickerView的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   
    NSString *strRow;
    NSString *Strcomponent;
    
    
    NSLog(@"row%ld",(long)row);
    NSLog(@"com%ld",(long)component);
 
    NSInteger curr;
    
    switch (component) {
        case 0:
            
            strRow = [self.letter[row] valueForKey:@"date"];
            leftStr = strRow;
            [self reloadComponent:1];
            break;

        case 1:
          
            curr = [self selectedRowInComponent:0];
            Strcomponent = [[[number objectAtIndex:curr] objectAtIndex:row] valueForKey:@"h"];
            rightStr = Strcomponent;
            break;

        default:
            break;
    }

}

#pragma mark -给主视图返回pickerview选择值
-(NSString *)getPickerviewValue{

    
    if (leftStr ==NULL) {
        
        leftStr = [self.letter[0] valueForKey:@"date"];
    }

    if (rightStr ==NULL) {
        
        rightStr = [[[number objectAtIndex:0] objectAtIndex:0] valueForKey:@"h"];
    }

    return [NSString stringWithFormat:@"%@ %@",leftStr,rightStr];

}




@end

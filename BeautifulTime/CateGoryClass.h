//
//  CateGoryClass.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/16.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CateGoryClass : NSObject

#pragma mark -返回高度
+(CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;


#pragma mark -返回宽度
+(CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

#pragma mark -指定宽度按比例缩放


@end

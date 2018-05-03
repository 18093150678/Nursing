//
//  AsynImageView.h
//  TiantMoivesss
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 com.cn.add.apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AsynImageView : UIImageView
{
    
    NSURLConnection *connection;
    NSMutableData *loadData;
    
}

//图片对应的缓存在沙河中的路径
@property (nonatomic,retain)NSString *fileName;

//指定默认未加载时,显示的默认图片
@property (nonatomic,retain)UIImage *placeholderImage;

//请求的网络图片的路径的url
@property(nonatomic,retain)NSString *imageURL;


@end

//
//  AsynImageView.m
//  TiantMoivesss
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 com.cn.add.apple. All rights reserved.
//

#import "AsynImageView.h"
#import <QuartzCore/QuartzCore.h>

@interface AsynImageView ()

@end

@implementation AsynImageView

@synthesize imageURL=_imageURL;
@synthesize fileName=_fileName;
@synthesize placeholderImage=_placeholderImage;


- (id)initWithNibName:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.backgroundColor =[[UIColor whiteColor] CGColor];
        self.layer.borderWidth=2.0;
        self.backgroundColor=[UIColor grayColor];
    }
    return self;
}

//重写placeholderImage的setter方法
-(void)setPlaceholderImage:(UIImage *)placeholderImage{

    if (placeholderImage !=_placeholderImage) {
        
        [_placeholderImage release];
        _placeholderImage =placeholderImage;
        self.image=_placeholderImage; //指定默认图片
    }
}

//重写imageurl的setter方法
-(void)setImageURL:(NSString *)imageURL{

    if (imageURL !=_imageURL) {
        self.image=_placeholderImage;
        [_imageURL release];
        _imageURL = [imageURL retain];
    }
    
    if (self.imageURL) {
        
        //确定图片的缓存地址
        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *docDir=[path objectAtIndex:0];
        NSString *tmpPath=[docDir stringByAppendingPathComponent:@"AsynImage"];
        
        
        NSFileManager *fm=[NSFileManager defaultManager];
        if (![fm fileExistsAtPath:tmpPath]) {
            [fm createDirectoryAtPath:tmpPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSArray *lineArray = [self.imageURL componentsSeparatedByString:@"/"];
        self.fileName=[NSString stringWithFormat:@"%@%@",tmpPath,[lineArray objectAtIndex:[lineArray count]-1]];
        
        //判断图片是否已经加载过,如果已经下载到本地缓存,则不用功重新下在.如果没有,请求网络进行下载.
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:_fileName]) {
            //下载图片,保存到本地缓存中
            [self loadImage];
        }
        else{
            //本地缓存中已经存在,直接指定请求的网络图片
            self.image=[UIImage imageWithContentsOfFile:_fileName];
        }
        
    }
    
}

//网络请求图片,缓存到本地沙河中
-(void)loadImage
{
    
    //对路径进行编码
    @try {
        //请求图片的下载路径
        //定义翼个缓存cache
        NSURLCache *urlcache =[NSURLCache sharedURLCache];
        //设置缓存大小为2M
        [urlcache setMemoryCapacity:2*124*1024];
        //设置请求超时为30S
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.imageURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
        //从请求中获取缓存输出
        NSCachedURLResponse *response=[urlcache cachedResponseForRequest:request];
        
        if (response !=nil) {
            [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
        }
        
        //创建nsurlconnection
        if (!connection) 
            connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
            
            //开启翼个runloop,使它始终处于运行状态
            UIApplication *app=[UIApplication sharedApplication];
            app.networkActivityIndicatorVisible = YES;
            [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//
        
//        NSString *fileName = _fileName;
//       // NSString *urlStr = [NSString stringWithFormat:@"http://img3.douban.com/lpic/s4717862.jpg",fileName];
//       // NSURL *url = [NSURL URLWithString:_imageURL];
//        NSURLCache *urlcache =[NSURLCache sharedURLCache];
//        //2.创建请求
//        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.imageURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
//        //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//        NSCachedURLResponse *response=[urlcache cachedResponseForRequest:request];
//        //创建会话
//        NSURLSession *session = [NSURLSession sharedSession];
//        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            if(!error){
//                //location 是下载后的临时保存路径，需要将它移动到需要保存的位置
//                NSError *saveError = nil;
//                NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
//                NSString *savePath = [cachePath stringByAppendingString:fileName];
//                NSLog(@"%@",savePath);
//                NSURL *url = [NSURL fileURLWithPath:savePath];
//                
//                [[NSFileManager defaultManager]copyItemAtURL:location toURL:url error:&saveError];
//                if (!saveError) {
//                    NSLog(@"save success");
//                }else{
//                    NSLog(@"error is :%@",saveError.localizedDescription);
//                }
//            }else{
//                NSLog(@"error is :%@",error.localizedDescription);
//            }
//        }];
//        //执行任务
//        [downloadTask resume];
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        ;
    }
}

//请求成功,并且接收数据(每次接收一次调用函数)
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    if (loadData ==nil) {
        loadData=[[NSMutableData alloc]initWithCapacity:2048];
    }
    [loadData appendData:data];;

}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{

    return cachedResponse;
}

-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    return request;
}

//下载完成,将文件保存到沙河中

-(void)connectionDidFinishLoading:(NSURLConnection *)theConnection{

    UIApplication *app=[UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    //图片已经成功下载到本地缓存,指定tup
    
    if ([loadData writeToFile:_fileName atomically:YES]) {
        self.image=[UIImage imageWithContentsOfFile:_fileName];
    }
    connection = nil;
    loadData = nil;
}

//网络连接错误或者请求成功但是加载数据异常

-(void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error{


    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    //如果发生错误,则重新加载
    
    connection = nil;
    loadData=nil;
    [self loadImage];
}

-(void)dealloc{
    
    [_fileName release];
    [loadData release];
    [connection release];
    
    [_imageURL release];
    
    [super dealloc];
}
@end

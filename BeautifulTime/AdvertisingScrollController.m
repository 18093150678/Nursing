//
//  AdvertisingScrollController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "AdvertisingScrollController.h"
#import "Pretreatment.h"

@interface AdvertisingScrollController ()

@end

@implementation AdvertisingScrollController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self AdvertisingScrollFunc];
}


-(void)AdvertisingScrollFunc{


    AdvertisingScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    //接收到触摸事件
    AdvertisingScroll.userInteractionEnabled = YES;
    //弹簧效果
    AdvertisingScroll.bounces = NO;
    //正屏滚动
    AdvertisingScroll.pagingEnabled = YES;
    //横向纵向滚动条显示
    AdvertisingScroll.showsVerticalScrollIndicator = NO;
    AdvertisingScroll.showsHorizontalScrollIndicator = NO;
    AdvertisingScroll.delegate=self;
    
    
    NSArray *_DeviceImageArr = @[@"1.png", @"2.png", @"3.png"];
    
    // add user guide image
    
    for (int i = 0 ; i<_DeviceImageArr.count; i++) {
        
        
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(i*SIZE_WIDTH, 0, SIZE_WIDTH, SIZE_HEIGHT)];
        img.image=[UIImage imageNamed:[_DeviceImageArr objectAtIndex:i]];
        img.userInteractionEnabled=YES;
        
        if (i == _DeviceImageArr.count -1) {
            
            UIButton *ApplicationDelegateBut  =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
            ApplicationDelegateBut.frame = CGRectMake(0, 0, 150, 31);
            ApplicationDelegateBut.layer.cornerRadius = 20;
            ApplicationDelegateBut.layer.masksToBounds = true;
            ApplicationDelegateBut.layer.borderColor = [[UIColor redColor]CGColor];
            ApplicationDelegateBut.layer.borderWidth = 1;
            ApplicationDelegateBut.center =CGPointMake(SIZE_WIDTH/2 , SIZE_HEIGHT-110);
            
            //设置按钮的背景图片
            ApplicationDelegateBut.backgroundColor=[UIColor clearColor];
            [ApplicationDelegateBut setTitle:@"立即体验" forState:UIControlStateNormal];
            [ApplicationDelegateBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            //接受触摸事件
            ApplicationDelegateBut.userInteractionEnabled = YES;
            
            [ApplicationDelegateBut addTarget:self action:@selector(handleGo:) forControlEvents:UIControlEventTouchUpInside];
            
            [img addSubview:ApplicationDelegateBut];
        }
        
        [AdvertisingScroll addSubview:img];
    }
    //设置滚动视图的大小
    AdvertisingScroll.contentSize = CGSizeMake(_DeviceImageArr.count*SIZE_WIDTH, SIZE_HEIGHT);
    //滚动试图添加到superView中
    [self.view addSubview:AdvertisingScroll];
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(150,SIZE_HEIGHT-40 ,SIZE_WIDTH-300,40)];
    //页码控制器的数量是
    pageControl.numberOfPages = 3;
    //设置初始值
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
    
    [self.view addSubview:pageControl];
    

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
  
    
    //如果当前点已经到了最前边的一张，即坐标为0,0
    NSLog(@"%f",AdvertisingScroll.contentOffset.x);
    
    NSInteger numspage = [self getPageConlnum:AdvertisingScroll.contentOffset];
    
    pageControl.currentPage = numspage;
    
       
}

-(void)handleGo:(id)sender{


    NSLog(@"is but");
    [self.delegate goButtonProcessWhat];

}


//手机内存报错方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//计算页码的方法
-(NSInteger)getPageConlnum:(CGPoint)contentOffSet{
    
    return  contentOffSet.x / SIZE_WIDTH;
    
}

@end

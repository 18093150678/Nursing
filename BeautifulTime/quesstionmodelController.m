//
//  quesstionmodelController.m
//  BeautifulTime
//
//  Created by lee on 2017/4/15.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "quesstionmodelController.h"
#import "Pretreatment.h"

@interface quesstionmodelController ()

@end

@implementation quesstionmodelController

- (void)viewDidLoad {
    [super viewDidLoad];


//    UIButton *modelCloses=[[UIButton alloc]initWithFrame:CGRectMake(15, 20, 20, 20)];
//    modelCloses.userInteractionEnabled = YES;
//    [modelCloses setImage:[UIImage imageNamed:@"guanbi_1.png"] forState:UIControlStateNormal];
//    //   LeftClose.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"back_but.png"]];
//    [modelCloses setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [modelCloses addTarget:self action:@selector(closeConmodelFunc) forControlEvents:UIControlEventTouchUpInside];
  
    scroMaxZoonImage =[[UIScrollView alloc]initWithFrame:CGRectMake(0,20, SIZE_WIDTH, SIZE_HEIGHT-20)];
    scroMaxZoonImage.delegate = self;
    scroMaxZoonImage.bounces = NO;
    scroMaxZoonImage.userInteractionEnabled = YES;
    scroMaxZoonImage.showsHorizontalScrollIndicator = NO;//是否显示侧边的滚动栏
    scroMaxZoonImage.showsVerticalScrollIndicator = NO;
    scroMaxZoonImage.scrollsToTop = NO;
    scroMaxZoonImage.scrollEnabled = YES;
    scroMaxZoonImage.maximumZoomScale= 2.0;
    scroMaxZoonImage.minimumZoomScale = 1.0;
    scroMaxZoonImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *scroMaxZoonImagetap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeConmodelFunc)];

    [scroMaxZoonImage addGestureRecognizer:scroMaxZoonImagetap];
    
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, scroMaxZoonImage.frame.size.width,scroMaxZoonImage.frame.size.height-20)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    
    @try {
        
        imageView.image = _image;
        
    } @catch (NSException *exception) {
        
        [self closeConmodelFunc];
        
    }
  
    scroMaxZoonImage.contentSize = imageView.frame.size;
    [scroMaxZoonImage addSubview:imageView];
    
    [self.view addSubview:scroMaxZoonImage];
    
    UITapGestureRecognizer *viewtap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeConmodelFunc)];
    
    [self.view addGestureRecognizer:viewtap];

   // [self.view addSubview:modelCloses];


}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}
//当滑动结束时
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
    
}
-(void)closeConmodelFunc{
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

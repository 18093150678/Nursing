//
//  ScrollView.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/7.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "ScrollView.h"


@implementation ScrollView


-(id)initWithFrame:(CGRect)frame imageViewArray:(NSMutableArray *)imagearray{
 
 //重载初始化方法在代码的第一行要先调用父类的方法 用关键字super
    
   
    self = [super initWithFrame:frame];

    if (self !=nil) {
        
        self.frame = frame;
        scroView = [[UIScrollView alloc]initWithFrame:self.frame];
        
        id lastArray=NULL;
        id oneArray=NULL;
        NSMutableArray *newArray=[[NSMutableArray alloc]init];
        if (imagearray !=nil) {
            
            
            
            lastArray=[imagearray objectAtIndex:imagearray.count-1];
            oneArray=[imagearray objectAtIndex:0];
            
            [newArray addObject:lastArray];
            [newArray addObjectsFromArray:imagearray];
            [newArray addObject:oneArray];

        }
       
        arrayimage = [[NSMutableArray alloc]init];
        arrayimage = newArray.copy;
  
        NSLog(@"%@",arrayimage);
        for (int i=0; i<arrayimage.count; i++) {
            
            AsynImageView *asynImageView=[[AsynImageView alloc]init];
            asynImageView.tag=i;
            asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
            asynImageView.imageURL=[NSString stringWithFormat:@"%@",[[arrayimage objectAtIndex:i] valueForKey:@"img"]];
            asynImageView.imageURL = [NSString stringWithFormat:@"%@%@",newurl,asynImageView.imageURL];
            asynImageView.contentMode=UIViewContentModeScaleToFill;
           // UIImageView *images=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
            asynImageView.frame=CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
            
           
            asynImageView.userInteractionEnabled = YES;
            
             [scroView addSubview:asynImageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scroControllerFunc:)];
            tap.view.tag = asynImageView.tag;
            [asynImageView addGestureRecognizer:tap];
        }
        scroView.userInteractionEnabled=YES;
        scroView.showsHorizontalScrollIndicator = NO;
        scroView.showsVerticalScrollIndicator = NO;
        scroView.pagingEnabled=YES;
        scroView.delegate=self;
        scroView.contentSize = CGSizeMake(self.frame.size.width*arrayimage.count, self.frame.size.height);
        [scroView setContentOffset:CGPointMake(self.frame.size.width, 0)];
        [self addSubview:scroView];
        
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width/2,scroView.frame.size.height-30,scroView.frame.size.width-self.frame.size.width/2, 30)];
        //页码控制器的数量是
        pageControl.numberOfPages = arrayimage.count - 2;
        //设置初始值
        pageControl.currentPage = 0;
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        
        [self addSubview:pageControl];
    }
    
    timer =[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(scroAuto) userInfo:nil repeats:YES];
    
    return self;
}

-(void)scroAuto{

    //获得当先scrollView滚动到的点（俗称偏移量）
    CGFloat offx=scroView.contentOffset.x;
    //向左移动一个屏幕的距离
    offx+=self.frame.size.width;
    
    [scroView setContentOffset:CGPointMake(offx, 0) animated:YES];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [timer invalidate];//取消计时器
    timer = nil;//避免野指针
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    timer =[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scroAuto) userInfo:nil repeats:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //获得偏移量
    CGPoint point = scroView.contentOffset;
    //x轴的最大位置
    float maxwidth = scrollView.frame.size.width*(arrayimage.count-1);
    
    //如果当前点已经到了最前边的一张，即坐标为0,0
    
    
    NSInteger numspage = [self getPageConlnum:scrollView.contentOffset];
    
    pageControl.currentPage = numspage;
    
    if (point.x ==0.0) {
        
        //跳转至倒数第二个图片中
        CGFloat xzz=scroView.frame.size.width*(arrayimage.count-2);
        [scrollView setContentOffset:CGPointMake(xzz, 0) animated:NO];
        
    }
    if (point.x==maxwidth) {
        
        //跳转到第二张图片
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:NO];
    }
   
}
-(void)scroControllerFunc:(id)sender{

    UITapGestureRecognizer *tap=(UITapGestureRecognizer *)sender;
    NSInteger tapindex=tap.view.tag;
    NSString *indexUrl = [[arrayimage objectAtIndex:tapindex] valueForKey:@"url"];
    if ([_delegates respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [_delegates didSelectItemAtIndex:indexUrl];
    }
    
}


//计算页码的方法
-(NSInteger)getPageConlnum:(CGPoint)contentOffSet{
    
    return  (contentOffSet.x - self.frame.size.width) / self.frame.size.width;
    
}

@end

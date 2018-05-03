//
//  CollectionView.m
//  TimeMedicalcCare
//
//  Created by MyBockPro on 2017/3/25.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "CollectionView.h"

@implementation CollectionView

-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    
    if (self!=nil) {
        
        self.frame = frame;
        
        conName=@[@"孕检百科",@"舌尖孕味",@"预约名医",@"上门产检",@"月子公寓",@"好孕心情",@"产后恢复",@"分享有礼"];
        
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
        //设定每一个cell的大小
        layout.itemSize=CGSizeMake(SIZE_WIDTH/4,self.frame.size.height/2);
        layout.minimumLineSpacing = 0;
        // 设置垂直间距
        layout.minimumInteritemSpacing = 0;

        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _Conllection=[[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
        
        _Conllection.backgroundColor = [UIColor whiteColor];
        _Conllection.delegate = self;
        _Conllection.dataSource = self;
        
        //手动注册视图类了
        [_Conllection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
        
        [self addSubview:_Conllection];
        
    }
    return self;
}


//实现代理类
#pragma mark -返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

#pragma mark -返回每个分区中cell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 8;
    
}

#pragma mark -返回每个collectionCell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    //如果重用了cell 把cell里面的contengView的内容清空
    while ([[cell.contentView subviews] count]>0) {
        
        NSLog(@"collectionView");
        //如果contentView中的子视图数量不是0 就说明有子视图
        
        [[[cell.contentView subviews] objectAtIndex:0]
         removeFromSuperview];
        
    }
    cell.backgroundColor = [UIColor whiteColor];

    NSString *imageName = [NSString stringWithFormat:@"index_%ld.png",(long)indexPath.row+1];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((SIZE_WIDTH/4 - 35)/2, 15, 33, 33)];
    imageView.image=[UIImage imageNamed:imageName];
    [cell.contentView addSubview:imageView];
    
    UILabel *TitleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height+15,cell.frame.size.width, 20)];
    TitleLable.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
    TitleLable.textAlignment = NSTextAlignmentCenter;
    TitleLable.font = [UIFont systemFontOfSize:12.0];
    TitleLable.text = [conName objectAtIndex:indexPath.row];
    
    [cell.contentView addSubview:TitleLable];

    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row);
    NSInteger indexpathInt=(long)indexPath.row;
    //判断该方法是不是存在的哦
    if ([_delegates respondsToSelector:@selector(CollectiondidSelectItemAtIndex:)]) {
        
        [_delegates CollectiondidSelectItemAtIndex:indexpathInt];
    }
}


@end

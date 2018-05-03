//
//  CollectionView.h
//  TimeMedicalcCare
//
//  Created by MyBockPro on 2017/3/25.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pretreatment.h"

@protocol PageCollectionDelegate;


@interface CollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    UICollectionView *_Conllection;
    id <PageCollectionDelegate> _delegates;
    NSArray *conName;
    
}

@property(nonatomic,retain)id <PageCollectionDelegate> delegates;

@end

@protocol PageCollectionDelegate <NSObject>

@optional
-(void)CollectiondidSelectItemAtIndex:(NSInteger)indexInt;

@end

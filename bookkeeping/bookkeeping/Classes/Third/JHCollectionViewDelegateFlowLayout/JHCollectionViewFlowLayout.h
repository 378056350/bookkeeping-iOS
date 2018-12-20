//
//  JHCollectionViewFlowLayout.h
//  HiiN
//
//  Created by 张健华-迈动 on 2017/3/7.
//  Copyright © 2017年 huanli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section;

@end


@interface JHCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;

@end

//
//  BaseCollectionView.m
//  imiss
//
//  Created by 郑业强 on 2018/9/2.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseCollectionView.h"

#pragma mark - 声明
@interface BaseCollectionView()

@end

#pragma mark - 实现
@implementation BaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self initUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    
}

@end

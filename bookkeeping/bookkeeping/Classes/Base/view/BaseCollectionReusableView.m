//
//  BaseCollectionReusableView.m
//  coding-ios-master
//
//  Created by 郑业强 on 2018/5/5.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseCollectionReusableView.h"

@implementation BaseCollectionReusableView

+ (instancetype)initWithCollection:(UICollectionView *)collection kind:(NSString *)kind indexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(self);
    BaseCollectionReusableView *view = [collection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    [view initUI];
    return view;
}

- (void)initUI {
    
}

@end

//
//  UICollectionView+Extension.m
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/14.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "UICollectionView+Extension.h"
#import <objc/runtime.h>

@implementation UICollectionView (Extension)

+ (void)load {
    Method imp = class_getInstanceMethod([self class], @selector(initWithFrame:collectionViewLayout:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithFrame:collectionViewLayout:));
    method_exchangeImplementations(imp, myImp);  //交换方法
    
    
    Method imp1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp1 = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp1, myImp1);  //交换方法
}

- (instancetype)myInitWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    [self myInitWithFrame:frame collectionViewLayout:layout];
    // iOS11
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    return self;
}
- (instancetype)myInitWithCoder:(NSCoder *)aDecode {
    [self myInitWithCoder:aDecode];
    // iOS11
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    return self;
}



@end

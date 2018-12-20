//
//  JHCollectionReusableView.m
//  HiiN
//
//  Created by 张健华-迈动 on 2017/3/7.
//  Copyright © 2017年 huanli. All rights reserved.
//

#import "JHCollectionReusableView.h"
#import "JHCollectionViewLayoutAttributes.h"

@implementation JHCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[JHCollectionViewLayoutAttributes class]]) {
        JHCollectionViewLayoutAttributes *attr = (JHCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
//        self.clipsToBounds = YES;
    }
}
// 渐变不要了, 用图

//- (CAGradientLayer *)gradientLayer {
//    if (!_gradientLayer) {
//        _gradientLayer = [CAGradientLayer layer];
//        _gradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor, (__bridge id)[UIColor colorWithWholeRed:245 green:245 blue:245].CGColor];
//        _gradientLayer.locations = @[@0.0, @0.8];
//        _gradientLayer.startPoint = CGPointMake(0, 0);
//        _gradientLayer.endPoint = CGPointMake(0, 1.0);
//        _gradientLayer.frame = CGRectMake(0, -50, [UIScreen width], self.height + 50);
//        [self.layer addSublayer:_gradientLayer];
//    }
//    return _gradientLayer;
//}

@end

//
//  BaseCollectionCell.m
//  coding-ios-master
//
//  Created by 郑业强 on 2018/5/5.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseCollectionCell.h"

@implementation BaseCollectionCell

// 创建cell
+ (instancetype)loadItem:(UICollectionView *)collection index:(NSIndexPath *)index {
    NSString *name = NSStringFromClass(self);
    BaseCollectionCell *cell = [collection dequeueReusableCellWithReuseIdentifier:name forIndexPath:index];
    [cell initUI];
    return cell;
}

// 初始化UI
- (void)initUI {
    
}


@end

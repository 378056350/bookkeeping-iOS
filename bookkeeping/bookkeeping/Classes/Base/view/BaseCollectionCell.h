//
//  BaseCollectionCell.h
//  coding-ios-master
//
//  Created by 郑业强 on 2018/5/5.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionCell : UICollectionViewCell

/// 创建cell
+ (instancetype)loadItem:(UICollectionView *)collection index:(NSIndexPath *)index;
/// 初始化UI
- (void)initUI;

@end

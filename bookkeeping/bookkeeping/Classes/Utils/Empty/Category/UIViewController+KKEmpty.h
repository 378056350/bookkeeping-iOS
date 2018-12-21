//
//  UIViewController+KKEmpty.h
//  imiss-ios-master
//
//  Created by zhongke on 2018/10/24.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (KKEmpty)

- (void)showEmpty:(KKEmptyStatus)status;
- (void)showEmpty:(KKEmptyStatus)status complete:(KKEmptyClick)click;
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame;
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame complete:(KKEmptyClick)click;

- (void)showEmpty:(KKEmptyStatus)status hasBack:(BOOL)hasBack;
- (void)showEmpty:(KKEmptyStatus)status hasBack:(BOOL)hasBack complete:(KKEmptyClick)click;
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame hasBack:(BOOL)hasBack;
- (void)showEmpty:(KKEmptyStatus)status frame:(CGRect)frame hasBack:(BOOL)hasBack complete:(KKEmptyClick)click;


- (void)hideEmpty;

@end

NS_ASSUME_NONNULL_END

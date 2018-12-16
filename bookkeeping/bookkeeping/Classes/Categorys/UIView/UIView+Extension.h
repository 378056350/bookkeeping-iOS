//
//  UIView+Extension.h
//  iOS
//
//  Created by RY on 2018/3/20.
//  Copyright © 2018年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;

@property (nonatomic, readonly) CGFloat ttScreenX;

@property (nonatomic, readonly) CGFloat ttScreenY;

@property (nonatomic, readonly) CGFloat screenViewX;

@property (nonatomic, readonly) CGFloat screenViewY;

@property (nonatomic, readonly) CGRect screenFrame;

@property (nonatomic) CGPoint origin;

@property (nonatomic) CGSize size;


/// 删除所有子控件
- (void)removeAllSubviews;
/// 当前控制器
- (UIViewController *)viewController;
/// 控件截图
- (UIImage *)imageFromView;
/// 控件在window上的rect
- (CGRect)convertRectWithWindow;

@end

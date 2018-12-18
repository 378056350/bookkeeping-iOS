//
//  KKPopup.h
//  imiss-ios-master
//
//  Created by zhongke on 2018/10/18.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - ENUM
typedef NS_ENUM(NSInteger, KKPopupStatus) {
    KKPopupStatusBottom,        // 底部弹出
    KKPopupStatusTop,           // 顶部弹出
    KKPopupStatusCenter,        // 中心渐渐显示
};


#pragma mark - 代理
@class KKPopup;
@protocol KKPopupDelegate <NSObject>
@optional
// 创建Rect
+ (CGRect)createContentFrame;
// 创建样式
+ (KKPopupStatus)createStatus;

@end


#pragma mark - typedef
typedef void (^KKPopupClick)(id data, KKPopup *popup);


#pragma mark - 声明
@interface KKPopup : BaseView<KKPopupDelegate>

@property (nonatomic, strong) BaseView *contentv;
@property (nonatomic, assign) KKPopupStatus status;
@property (nonatomic, strong) id data;
@property (nonatomic, copy  ) KKPopupClick click;


+ (instancetype)initCode:(NSString *)clsName;
+ (instancetype)initNib:(NSString *)clsName;

- (void)show;
- (void)show:(void (^)(void))complete;
- (void)hide;
- (void)hide:(void (^)(void))complete;

@end


NS_ASSUME_NONNULL_END

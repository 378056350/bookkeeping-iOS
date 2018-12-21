/**
 * 空白页
 * @author 郑业强 2018-11-20
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark - NS_ENUM
typedef NS_ENUM(NSUInteger, KKEmptyStatus) {
    KKEmptyStatusNet,       // 网络错误
    KKEmptyStatusCommon,    // 暂无数据
    KKEmptyStatusLoading,   // 正在加载
    KKEmptyStatusNoneOrder, // 没有相关订单
    KKEmptyStatusLoadGoods, // 加载商品
};
typedef NS_ENUM(NSUInteger, KKEmptyClickDeal) {
    KKEmptyClickDealLoad,   // 请求数据
};


#pragma mark - typedef
@class KKEmpty;
typedef void (^__nullable KKEmptyClick)(KKEmptyClickDeal deal);


#pragma mark - 声明
@interface KKEmpty : UIView

@property (nonatomic, assign) KKEmptyStatus status;
@property (nonatomic, copy  ) KKEmptyClick click;
@property (nonatomic, assign) BOOL hasBack;         // 返回按钮

+ (instancetype)initWithFrame:(CGRect)frame;

@end


NS_ASSUME_NONNULL_END

/**
 * 页面请求参数
 * @author 郑业强 2018-10-
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPViewRequest : NSObject

@property (nonatomic, assign) NSInteger page;           // 当前页属性
@property (nonatomic, assign) CGRect afn_frame;         // 尺寸
@property (nonatomic, weak  ) UIView *view;             // 当前view
@property (nonatomic, assign) BOOL afn_useCache;        // 使用缓存
@property (nonatomic, assign) BOOL afn_showLoading;     // 显示等待
@property (nonatomic, assign) BOOL afn_showCommon;      // 显示无数据
@property (nonatomic, assign) BOOL afn_showError;       // 显示错误
@property (nonatomic, assign) BOOL afn_hasData;         // 请求成功
@property (nonatomic, assign) BOOL afn_hasBack;         // 返回
@property (nonatomic, assign) BOOL afn_isHeader;        // 下拉刷新
@property (nonatomic, strong) APPResult *result;        // 数据
@property (nonatomic, assign) KKEmptyStatus afn_loadStatus;     // 等待页面
@property (nonatomic, assign) KKEmptyStatus afn_commonStatus;   // 无数据页面
@property (nonatomic, assign) KKEmptyStatus afn_errorStatus;    // 错误页面

+ (instancetype)sharedManager;

@end

NS_ASSUME_NONNULL_END

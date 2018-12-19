/**
 * 分类
 * @author 郑业强 2018-12-19 创建文件
 */

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)

+ (void)load {
    [super load];
    if (@available(iOS 11.0, *)) {
        Method originalM = class_getInstanceMethod([self class], @selector(initWithFrame:));
        Method exchangeM = class_getInstanceMethod([self class], @selector(cl_initWithFrame:));
        method_exchangeImplementations(originalM, exchangeM);
    }
}

- (instancetype)cl_initWithFrame:(CGRect)frame {
    
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    return [self cl_initWithFrame:frame];
}


@end

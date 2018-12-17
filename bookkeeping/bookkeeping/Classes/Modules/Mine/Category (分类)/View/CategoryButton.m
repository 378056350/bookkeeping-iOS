/**
 * 分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "CategoryButton.h"
#import "CATEGORY_EVENT.h"


#pragma mark - 声明
@interface CategoryButton()

@end


#pragma mark - 实现
@implementation CategoryButton


+ (instancetype)initWithFrame:(CGRect)frame {
    CategoryButton *button = [CategoryButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:@"添加类别" forState:UIControlStateNormal];
    [button setTitle:@"添加类别" forState:UIControlStateHighlighted];
    [button setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [button setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [button setBackgroundImage:[UIColor createImageWithColor:kColor_White] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIColor createImageWithColor:kColor_BG] forState:UIControlStateHighlighted];
    [button shadowWithColor:kColor_Text_Gary offset:CGSizeMake(0, -3) opacity:0.1 radius:5];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [button routerEventWithName:CATEGORY_BTN_CLICK data:nil];
    }];
    return button;
}


@end

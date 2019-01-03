/**
 * 分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BottomButton.h"
#import "CA_EVENT.h"


#pragma mark - 声明
@interface BottomButton()

@end


#pragma mark - 实现
@implementation BottomButton


+ (instancetype)initWithFrame:(CGRect)frame {
    BottomButton *button = [BottomButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [button setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [button setBackgroundImage:[UIColor createImageWithColor:kColor_White] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIColor createImageWithColor:kColor_BG] forState:UIControlStateHighlighted];
    [button shadowWithColor:kColor_Text_Gary offset:CGSizeMake(0, -3) opacity:0.1 radius:5];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [button routerEventWithName:CATEGORY_BTN_CLICK data:nil];
    }];
    return button;
}
- (void)setName:(NSString *)name {
    _name = name;
    [self setTitle:name forState:UIControlStateNormal];
    [self setTitle:name forState:UIControlStateHighlighted];
}


@end

/**
 * 内容控件
 * @author 郑业强 2019-01-09 创建文件
 */

#import "StartView.h"
#import "StartHeader.h"
#import "StartScroll.h"
#import "StartKeyboard.h"


#pragma mark - 声明
@interface StartView()

@property (nonatomic, strong) StartHeader *header;
@property (nonatomic, strong) StartScroll *scroll;
@property (nonatomic, strong) StartKeyboard *keyboard;

@end


#pragma mark - 实现
@implementation StartView


- (void)initUI {
    [self header];
    [self scroll];
    [self keyboard];
}


#pragma mark - get
- (StartHeader *)header {
    if (!_header) {
        _header = [StartHeader loadCode:CGRectMake(0, 0, self.width, 40)];
        [self addSubview:_header];
    }
    return _header;
}
- (StartScroll *)scroll {
    if (!_scroll) {
        _scroll = [StartScroll loadCode:CGRectMake(0, self.header.bottom, self.width, 70)];
        [self addSubview:_scroll];
    }
    return _scroll;
}
- (StartKeyboard *)keyboard {
    if (!_keyboard) {
        _keyboard = [StartKeyboard loadCode:CGRectMake(0, self.scroll.bottom, self.width, self.width / 5.f * 4.f)];
        [self addSubview:_keyboard];
    }
    return _keyboard;
}


@end

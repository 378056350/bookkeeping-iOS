/**
 * 内容控件
 * @author 郑业强 2019-01-09 创建文件
 */

#import "StartView.h"
#import "StartHeader.h"


#pragma mark - 声明
@interface StartView()

@property (nonatomic, strong) StartHeader *header;

@end


#pragma mark - 实现
@implementation StartView


- (void)initUI {
    [self header];
}


#pragma mark - get
- (StartHeader *)header {
    if (!_header) {
        _header = [StartHeader loadCode:CGRectMake(0, 0, self.width, countcoordinatesX(40))];
        [self addSubview:_header];
    }
    return _header;
}


@end

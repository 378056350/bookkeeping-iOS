/**
 * 收入/支出
 * @author 郑业强 2019-01-09 创建文件
 */

#import "StartHeader.h"

#pragma mark - 声明
@interface StartHeader()

@property (nonatomic, strong) UISegmentedControl *seg;

@end


#pragma mark - 实现
@implementation StartHeader


- (void)initUI {
    [self seg];
}


#pragma mark - 点击
- (void)segValueChange:(UISegmentedControl *)seg {
    
}


#pragma mark - get
- (UISegmentedControl *)seg {
    if (!_seg) {
        _seg = [[UISegmentedControl alloc] initWithFrame:({
            CGFloat left = countcoordinatesX(20);
            CGFloat top = 0;
            CGFloat width = self.width - left * 2;
            CGFloat height = width;
            CGRectMake(left, top, width, height);
        })];
        [_seg insertSegmentWithTitle:@"收入" atIndex:0 animated:true];
        [_seg insertSegmentWithTitle:@"支出" atIndex:1 animated:true];
        [_seg setSelectedSegmentIndex:0];
        [_seg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_seg];
    }
    return _seg;
}


@end

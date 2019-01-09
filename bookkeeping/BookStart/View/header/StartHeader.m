/**
 * 收入/支出
 * @author 郑业强 2019-01-09 创建文件
 */

#import "StartHeader.h"
#import "START_EVENT.h"

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
    [self routerEventWithName:START_SEG_CLICK data:@(seg.selectedSegmentIndex)];
}


#pragma mark - get
- (UISegmentedControl *)seg {
    if (!_seg) {
        _seg = [[UISegmentedControl alloc] initWithFrame:({
            CGFloat width = self.width - countcoordinatesX(30);
            CGFloat height = countcoordinatesX(30);
            CGRectMake(0, 0, width, height);
        })];
        [_seg setTintColor:kColor_Text_Black];
        [_seg setCenter:CGPointMake(self.width / 2, self.height / 2)];
        [_seg insertSegmentWithTitle:@"收入" atIndex:0 animated:true];
        [_seg insertSegmentWithTitle:@"支出" atIndex:1 animated:true];
        [_seg setSelectedSegmentIndex:0];
        [_seg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
        [_seg setTitleTextAttributes:[NSDictionary dictionaryWithObject:kColor_Text_Black forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
        [_seg setTitleTextAttributes:[NSDictionary dictionaryWithObject:kColor_Main_Color forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
        [self addSubview:_seg];
    }
    return _seg;
}


@end

/**
 * 导航栏
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ChartNavigation.h"

#pragma mark - 声明
@interface ChartNavigation()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end


#pragma mark - 实现
@implementation ChartNavigation


- (void)initUI {
    [self setBackgroundColor:kColor_Main_Color];
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    if (selectIndex == 0) {
        _nameLab.text = @"支出";
    } else {
        _nameLab.text = @"收入";
    }
}


@end

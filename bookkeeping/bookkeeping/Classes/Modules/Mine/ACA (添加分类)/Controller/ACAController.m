/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ACAController.h"

#pragma mark - 声明
@interface ACAController()

@end


#pragma mark - 实现
@implementation ACAController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"添加支出类别"];
    [self setJz_navigationBarHidden:NO];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"完成" forState:UIControlStateHighlighted];
}

- (void)rightButtonClick {
    
}




@end

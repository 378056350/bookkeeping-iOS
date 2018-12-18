/**
 * 时间
 * @author 郑业强 2018-12-18 创建文件
 */

#import "KKDate.h"

#pragma mark - 声明
@interface KKDate()

@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIDatePicker *picker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateConstraintB;

@end


#pragma mark - 实现
@implementation KKDate


- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(16)]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.cancleBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.confirmBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    
    [self.nameConstraintH setConstant:countcoordinatesX(50)];
    [self.dateConstraintB setConstant:SafeAreaBottomHeight];
}


#pragma mark - 点击
// 取消
- (IBAction)cancleClick:(UIButton *)sender {
    if (self.popup.click) {
        self.popup.click(nil, self.popup);
    }
}
// 确定
- (IBAction)confirmClick:(UIButton *)sender {
    if (self.popup.click) {
        self.popup.click(_picker.date, self.popup);
    }
}


#pragma mark - KKPopupDelegate
// 创建Rect
+ (CGRect)createContentFrame {
    return CGRectMake(0, 0, SCREEN_WIDTH, 220 + SafeAreaBottomHeight + countcoordinatesX(50));
}
// 创建样式
+ (KKPopupStatus)createStatus {
    return KKPopupStatusBottom;
}



@end

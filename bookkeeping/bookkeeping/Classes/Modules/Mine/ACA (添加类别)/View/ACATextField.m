/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ACATextField.h"
#import "ACA_EVENT_MANAGER.h"

#pragma mark - 声明
@interface ACATextField()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *line;

@end


#pragma mark - 实现
@implementation ACATextField


- (void)initUI {
    [self.line setBackgroundColor:kColor_Line_Color];
    [self setBackgroundColor:kColor_BG];
    [self.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
}


- (void)textChange:(UITextField *)textField {
    if (textField.text.length > 4) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, 4)];
    }
}


#pragma mark - set
- (void)setModel:(ACAModel *)model {
    _model = model;
    [_icon setImage:[UIImage imageNamed:model.icon_s]];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}


@end

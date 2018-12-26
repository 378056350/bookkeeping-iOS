/**
 * 按钮
 * @author 郑业强 2018-12-22 创建文件
 */

#import "InfoFooter.h"
#import "INFO_EVENT_MANAGER.h"

#pragma mark - 声明
@interface InfoFooter()

@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnConstraintT;

@end


#pragma mark - 实现
@implementation InfoFooter


- (void)initUI {
    [self.nameBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.nameBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.nameBtn setBackgroundImage:[UIColor createImageWithColor:kColor_White] forState:UIControlStateNormal];
    [self.nameBtn setBackgroundImage:[UIColor createImageWithColor:kColor_BG] forState:UIControlStateHighlighted];
    
    [self.btnConstraintT setConstant:countcoordinatesX(10)];
}

// 退出登录
- (IBAction)quitClick:(id)sender {
    [self routerEventWithName:INFO_FOOTER_CLICK data:nil];
}


@end

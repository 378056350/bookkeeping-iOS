/**
 * 徽章
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BaseReusableHeader.h"

#pragma mark - 声明
@interface BaseReusableHeader()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end


#pragma mark - 实现
@implementation BaseReusableHeader


- (void)initUI {
    self.nameLab.font = [UIFont systemFontOfSize:AdjustFont(14)];
    self.nameLab.textColor = kColor_Text_Black;
    self.detailLab.font = [UIFont systemFontOfSize:AdjustFont(12)];
    self.detailLab.textColor = kColor_Text_Gary;
}


@end

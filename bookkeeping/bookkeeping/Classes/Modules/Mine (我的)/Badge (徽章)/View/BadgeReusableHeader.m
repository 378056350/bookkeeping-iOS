/**
 * 徽章
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BadgeReusableHeader.h"

#pragma mark - 声明
@interface BadgeReusableHeader()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end


#pragma mark - 实现
@implementation BadgeReusableHeader


- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    self.nameLab.font = [UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight];
    self.nameLab.textColor = kColor_Text_Black;
    self.detailLab.font = [UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight];
    self.detailLab.textColor = kColor_Text_Gary;
}


#pragma mark - set
- (void)setModel:(BadgeListModel *)model {
    _model = model;
    _nameLab.text = model.name;
    _detailLab.text = [NSString stringWithFormat:@"已获取%ld枚", model.count];
}


@end

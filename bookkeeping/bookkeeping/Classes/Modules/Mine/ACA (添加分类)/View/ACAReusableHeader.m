/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ACAReusableHeader.h"

#pragma mark - 声明
@interface ACAReusableHeader()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end


#pragma mark - 实现
@implementation ACAReusableHeader


- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
}


#pragma mark - set
- (void)setModel:(ACAListModel *)model {
    _model = model;
    _nameLab.text = model.name;
}


@end

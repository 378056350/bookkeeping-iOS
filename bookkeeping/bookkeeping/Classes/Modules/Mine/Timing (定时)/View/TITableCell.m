/**
 * 定时
 * @author 郑业强 2018-12-18 创建文件
 */

#import "TITableCell.h"

#pragma mark - 声明
@interface TITableCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end


#pragma mark - 实现
@implementation TITableCell


- (void)initUI {
    [self setBackgroundColor:kColor_White];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Gary];
    [self.detailLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.detailLab setTextColor:kColor_Text_Gary];
}


@end

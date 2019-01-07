/**
 * 收入/支出切换
 * @author 郑业强 2018-12-28 创建文件
 */

#import "ChartHUDCell.h"

#pragma mark - 声明
@interface ChartHUDCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *done;

@end


#pragma mark - 实现
@implementation ChartHUDCell


- (void)initUI {
    [self setSelectedBackgroundView:[[UIView alloc] initWithFrame:self.frame]];
    [self.selectedBackgroundView setBackgroundColor:kColor_BG];
    [self.nameLab setFont:[UIFont fontWithName:@"Helvetica Neue" size:AdjustFont(12)]];
    [self.done setHidden:true];
}


#pragma mark - set
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    if (indexPath.row == 0) {
        [self.icon setImage:[UIImage imageNamed:@"tally_select_expenditure"]];
        [self.nameLab setText:@"支出"];
    } else {
        [self.icon setImage:[UIImage imageNamed:@"tally_select_income"]];
        [self.nameLab setText:@"收入"];
    }
}
- (void)setChoose:(BOOL)choose {
    _choose = choose;
    _done.hidden = !choose;
}



@end

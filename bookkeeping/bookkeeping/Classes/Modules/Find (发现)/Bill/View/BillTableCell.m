/**
 * 列表Cell
 * @author 郑业强 2019-01-09 创建文件
 */

#import "BillTableCell.h"


#pragma mark - 声明
@interface BillTableCell()

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labConstraintL;

@end


#pragma mark - 实现
@implementation BillTableCell


- (void)initUI {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.labConstraintL setConstant:countcoordinatesX(20)];
    for (id obj in self.contentView.subviews) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *lab = obj;
            lab.font = [UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight];
            lab.textColor = kColor_Text_Black;
        }
    }
}


#pragma mark - set
- (void)setModel:(NSDictionary *)model {
    _model = model;
    [self.lab1 setText:model[@"month"]];
    [self.lab2 setAttributedText:[NSAttributedString createMath:model[@"income"] integer:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight] decimal:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]]];
    [self.lab3 setAttributedText:[NSAttributedString createMath:model[@"pay"] integer:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight] decimal:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]]];
    [self.lab4 setAttributedText:[NSAttributedString createMath:model[@"sum"] integer:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight] decimal:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]]];
    
}


@end

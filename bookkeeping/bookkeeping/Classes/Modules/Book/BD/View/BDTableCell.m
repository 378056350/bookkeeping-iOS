//
//  BDTableCell.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/1/6.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "BDTableCell.h"

#pragma mark - 声明
@interface BDTableCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstraintL;

@end


#pragma mark - 实现
@implementation BDTableCell


- (void)initUI {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Gary];
    [self.detailLab setFont:[UIFont fontWithName:@"Helvetica Neue" size:AdjustFont(12)]];
    [self.detailLab setTextColor:kColor_Text_Black];
    [self.nameConstraintL setConstant:countcoordinatesX(15)];
}


#pragma mark - set
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    [_nameLab setText:@[@"类型",@"金额",@"日期",@"备注"][indexPath.row]];
}
- (void)setModel:(BKModel *)model {
    _model = model;
    if (_indexPath.row == 0) {
        [_detailLab setText:model.cmodel.is_income == true ? @"收入" : @"支出"];
    } else if (_indexPath.row == 1) {
        [_detailLab setText:[@(model.price) description]];
    } else if (_indexPath.row == 2) {
        [_detailLab setText:model.dateStr];
    } else if (_indexPath.row == 3) {
        [_detailLab setText:(model.mark && model.mark.length != 0) ? model.mark : model.cmodel.name];
    }
}


@end

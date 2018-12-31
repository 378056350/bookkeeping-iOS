//
//  BCHUDContentCell.m
//  bookkeeping
//
//  Created by 郑业强 on 2018/12/30.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "BCHUDContentCell.h"

#pragma mark - 声明
@interface BCHUDContentCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailConstraintL;

@end


#pragma mark - 实现
@implementation BCHUDContentCell


- (void)initUI {
    [self setBackgroundColor:kColor_Text_Black];
    [self.contentView setBackgroundColor:kColor_Text_Black];
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(8) weight:UIFontWeightLight]];
    [self.detailLab setFont:[UIFont systemFontOfSize:AdjustFont(8) weight:UIFontWeightLight]];
    [self.priceLab setFont:[UIFont systemFontOfSize:AdjustFont(8) weight:UIFontWeightLight]];
    [self.detailConstraintL setConstant:countcoordinatesX(30)];
}


#pragma mark - set
- (void)setModel:(BookListModel *)model {
    _model = model;
    [_icon sd_setImageWithURL:[NSURL URLWithString:KStatic(model.icon_l)]];
    [_nameLab setText:[NSString stringWithFormat:@"%ld/%02ld/%02ld", model.year, model.month, model.day]];
    [_detailLab setText:model.name];
    [_priceLab setText:[@(model.price) description]];
}



@end

//
//  BDHeader.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/1/5.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "BDHeader.h"

#pragma mark - 声明
@interface BDHeader()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *shareLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraintW;

@end


#pragma mark - 实现
@implementation BDHeader


- (void)initUI {
    [self setBackgroundColor:kColor_Main_Color];
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.shareLab setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
    [self.shareLab setTextColor:kColor_Text_Black];
    [self.iconConstraintW setConstant:countcoordinatesX(60)];
    [self.shareLab addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
    }];
}

#pragma mark - 点击
- (IBAction)backClick:(UIButton *)sender {
    [self.viewController.navigationController popViewControllerAnimated:true];
}


#pragma mark - set
- (void)setModel:(BKModel *)model {
    _model = model;
    [_icon setImage:[UIImage imageNamed:model.cmodel.icon_l]];
    [_nameLab setText:model.cmodel.name];
//    [_icon sd_setImageWithURL:[NSURL URLWithString:KStatic(model.cmodel.icon_l)]];
}


@end

//
//  StartScrollCell.m
//  BookStart
//
//  Created by zhongke on 2019/1/9.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "StartScrollCell.h"

#pragma mark - 声明
@interface StartScrollCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end


#pragma mark - 实现
@implementation StartScrollCell


- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
}


#pragma mark - set
- (void)setModel:(BKCModel *)model {
    _model = model;
    [_nameLab setText:model.name];
}
- (void)setChoose:(BOOL)choose {
    _choose = choose;
    if (choose == true) {
        [_icon setImage:[UIImage imageNamed:_model.icon_s]];
    } else {
        [_icon setImage:[UIImage imageNamed:_model.icon_n]];
    }
}


@end

//
//  KKEmptyCommon.m
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/11/3.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "KKEmptyCommon.h"

#pragma mark - 声明
@interface KKEmptyCommon()

@property (nonatomic, strong) UIImageView *icn;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *detailLab;

@end


#pragma mark - 实现
@implementation KKEmptyCommon


- (void)initUI {
    [self icn];
    [self nameLab];
    [self detailLab];
}


#pragma mark - set
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _icn.frame = CGRectMake((self.width - self.icn.width) / 2,
                            (self.height - self.icn.height) / 2 - 40,
                            self.icn.width,
                            self.icn.height);
    _nameLab.frame = CGRectMake(0, self.icn.bottom + 8, SCREEN_WIDTH, 20);
    _detailLab.frame = CGRectMake(0, self.nameLab.bottom + 8, SCREEN_WIDTH, 20);
}


#pragma mark - 点击
- (void)btnClick {
    [self routerEventWithName:kEventNoNetClick data:nil];
}


#pragma mark - get
- (UIImageView *)icn {
    if (!_icn) {
        _icn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 3, SCREEN_WIDTH / 3)];
        _icn.backgroundColor = [UIColor redColor];
        _icn.frame = CGRectMake((self.width - self.icn.width) / 2,
                                (self.height - self.icn.height) / 2 - 40,
                                self.icn.width,
                                self.icn.height);
        [self addSubview:_icn];
    }
    return _icn;
}
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.icn.bottom + 8, SCREEN_WIDTH, 20)];
        _nameLab.font = [UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight];
        _nameLab.textColor = kColor_Text_Black;
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.text = @"暂无数据";
        [self addSubview:_nameLab];
    }
    return _nameLab;
}
- (UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLab.bottom, SCREEN_WIDTH, 20)];
        _detailLab.font = [UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight];
        _detailLab.textColor = kColor_Text_Gary;
        _detailLab.textAlignment = NSTextAlignmentCenter;
        _detailLab.text = @"可以去看看其他页面";
        [self addSubview:_detailLab];
    }
    return _detailLab;
}


@end


//
//  KKEmptyNoNet.m
//  imiss-ios-master
//
//  Created by zhongke on 2018/11/3.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "KKEmptyNoNet.h"

#pragma mark - 声明
@interface KKEmptyNoNet()

@property (nonatomic, strong) UIImageView *icn;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UIButton *btn;

@end

#pragma mark - 实现
@implementation KKEmptyNoNet


- (void)initUI {
    [self icn];
    [self nameLab];
    [self detailLab];
    [self btn];
}


#pragma mark - set
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [_icn setFrame:CGRectMake((self.width - self.icn.width) / 2,
                              (self.height - self.icn.height) / 2 - 40,
                              self.icn.width,
                              self.icn.height)];
    [_nameLab setFrame:CGRectMake(0, self.icn.bottom + 8, SCREEN_WIDTH, 20)];
    [_detailLab setFrame:CGRectMake(0, self.nameLab.bottom, SCREEN_WIDTH, 20)];
    [_btn setFrame:CGRectMake(0, self.detailLab.bottom + 10, 70, 25)];
    [_btn setCenterX:self.centerX];
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
        _nameLab.font = [UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight];
        _nameLab.textColor = kColor_Text_Black;
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.text = @"网络竟然崩溃了";
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
        _detailLab.text = @"别紧张, 试试看刷新页面~";
        [self addSubview:_detailLab];
    }
    return _detailLab;
}
- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setFrame:CGRectMake(0, self.detailLab.bottom + 10, 70, 25)];
        [_btn setCenterX:self.centerX];
        [_btn setTitle:@"刷新" forState:UIControlStateNormal];
        [_btn.layer setCornerRadius:_btn.height / 2];
        [_btn.layer setMasksToBounds:YES];
        [_btn.layer setBorderWidth:0.5];
        [_btn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
        [_btn.layer setBorderColor:kColor_Text_Black.CGColor];
        [_btn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn];
    }
    return _btn;
}


@end

//
//  BDBottom.m
//  bookkeeping
//
//  Created by 郑业强 on 2019/1/6.
//  Copyright © 2019年 kk. All rights reserved.
//

#import "BDBottom.h"
#import "BD_EVENT.h"


#pragma mark - 声明
@interface BDBottom()

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editConstraintB;

@end


#pragma mark - 实现
@implementation BDBottom


- (void)initUI {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.editBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
    [self.editBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.editBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.delBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
    [self.delBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.delBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.editConstraintB setConstant:SafeAreaBottomHeight];
    
}
- (IBAction)editBtnClick:(UIButton *)sender {
    [self routerEventWithName:BD_BOTTOM_CLICK data:@(0)];
}
- (IBAction)delBtnClick:(UIButton *)sender {
    [self routerEventWithName:BD_BOTTOM_CLICK data:@(1)];
}



@end

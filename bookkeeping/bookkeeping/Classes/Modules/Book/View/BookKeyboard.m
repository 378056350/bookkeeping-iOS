/**
 * 键盘
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BookKeyboard.h"

#define DATE_TAG 13         // 日期
#define PLUS_TAG 17         // 加
#define LESS_TAG 21         // 减
#define POINT_TAG 22        // 点
#define DELETE_TAG 24       // 删除
#define FINISH_TAG 25       // 完成
#define IS_MATH(tag) (tag >= 10 && tag <= 12) || (tag >= 14 && tag <= 16) || (tag >= 18 && tag <= 20) || tag == 23   // 是否是数字



#pragma mark - 声明
@interface BookKeyboard()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UITextField *markField;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIView *textContent;

@property (nonatomic, assign) BOOL isPlus;      // 加
@property (nonatomic, assign) BOOL isLess;      // 减
@property (nonatomic, assign) BOOL animation;   // 动画中

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyConstraintB;

@end


#pragma mark - 实现
@implementation BookKeyboard


+ (instancetype)init {
    BookKeyboard *view = [BookKeyboard loadFirstNib:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_WIDTH / 5 * 4 + SafeAreaBottomHeight)];
    [view setHidden:YES];
    [view initUI];
    return view;
}
- (void)initUI {
    [self setAnimation:NO];
    [self setIsPlus:NO];
    [self setIsLess:NO];
    
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.markField setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [self.moneyLab setFont:[UIFont systemFontOfSize:AdjustFont(20)]];
    
    [self.textConstraintH setConstant:countcoordinatesX(60)];
    [self.keyConstraintB setConstant:SafeAreaBottomHeight];
    
    [self createBtn];
    
    if (!_money) {
        _money = [NSMutableString string];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)createBtn {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]] && [obj tag] >= 10) {
            UIButton *btn = obj;
            [btn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
            // 背景色
            if (btn.tag == FINISH_TAG) {
                [btn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Color] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Dark_Color] forState:UIControlStateHighlighted];
            }
            else {
                [btn setBackgroundImage:[UIColor createImageWithColor:kColor_White] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIColor createImageWithColor:kColor_BG] forState:UIControlStateHighlighted];
            }
            
            // 数字
            if (IS_MATH(btn.tag)) {
                NSInteger math = [self getMath:btn.tag];
                [btn setTitle:[@(math) description] forState:UIControlStateNormal];
                [btn setTitle:[@(math) description] forState:UIControlStateHighlighted];
            }
            else if (btn.tag == POINT_TAG) {
                [btn setTitle:@"." forState:UIControlStateNormal];
                [btn setTitle:@"." forState:UIControlStateHighlighted];
            }
            else if (btn.tag == DATE_TAG) {
                [btn setTitle:@"今天" forState:UIControlStateNormal];
                [btn setTitle:@"今天" forState:UIControlStateHighlighted];
            }
            else if (btn.tag == PLUS_TAG) {
                [btn setTitle:@"+" forState:UIControlStateNormal];
                [btn setTitle:@"+" forState:UIControlStateHighlighted];
            }
            else if (btn.tag == LESS_TAG) {
                [btn setTitle:@"-" forState:UIControlStateNormal];
                [btn setTitle:@"-" forState:UIControlStateHighlighted];
            }
            else if (btn.tag == FINISH_TAG) {
                [btn setTitle:@"完成" forState:UIControlStateNormal];
                [btn setTitle:@"完成" forState:UIControlStateHighlighted];
            }
            
            [btn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
            [btn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}


#pragma mark - 动画
- (void)show {
    if (_animation == YES) {
        return;
    }
    _animation = YES;
    
    
    [self setHidden:NO];
    [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self setTop:SCREEN_HEIGHT - self.height];
    } completion:^(BOOL finished) {
        [self setAnimation:NO];
    }];
}
- (void)hide {
    if (_animation == YES) {
        return;
    }
    _animation = YES;
    
    [self setHidden:NO];
    [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self setTop:SCREEN_HEIGHT];
    } completion:^(BOOL finished) {
        [self setAnimation:NO];
    }];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - 点击
- (void)btnClick:(UIButton *)btn {
    // 数字
    [self mathBtnClick:btn];
    // 点
    [self pointBtnClick:btn];
    // 加
    [self plusBtnClick:btn];
    // 时间
    [self dateBtnClick:btn];
    // 删除
    [self deleteBtnClick:btn];
    
    // 刷新
    [self reloadCompleteButton];
    // 计算
    [self calculationMath];
}
// 数字
- (void)mathBtnClick:(UIButton *)btn {
    // 数字
    if (IS_MATH(btn.tag)) {
        // 超过10位
        if (_money.length >= 10) {
            return;
        }
        
        
        NSInteger math = [self getMath:btn.tag];
        NSString *str = ({
            NSString *str;
            if (_isPlus == true) {
                str = [_money componentsSeparatedByString:@"+"][1];
            } else {
                str = _money;
            }
            str;
        });
        NSArray<NSString *> *arr = [str componentsSeparatedByString:@"."];
        if (arr.count != 2 || (arr.count == 2 && arr[1].length < 2)) {
            [_money appendString:[@(math) description]];
            [self setMoney:_money];
        }
    }
}
// 点
- (void)pointBtnClick:(UIButton *)btn {
    // 点
    if (btn.tag == POINT_TAG) {
        // 超过10位
        if (_money.length >= 10) {
            return;
        }
        
        
        NSString *str = [_money containsString:@"+"] ? [_money componentsSeparatedByString:@"+"][1] : _money;
        if (![str containsString:@"."] && str.length != 0) {
            [_money appendString:@"."];
            [self setMoney:_money];
        }
    }
}
// 加
- (void)plusBtnClick:(UIButton *)btn {
    // 加
    if (btn.tag == PLUS_TAG) {
        if (_money.length == 0) {
            _money = [NSMutableString stringWithString:@"0"];
        }
        
        NSString *lastStr = [_money substringWithRange:NSMakeRange(_money.length - 1, 1)];
        if ([lastStr isEqualToString:@"+"]) {
            return;
        }
        
        [_money appendString:@"+"];
        [self setMoney:_money];
        _isPlus = true;
    }
}
// 时间
- (void)dateBtnClick:(UIButton *)btn {
    // 时间
    if (btn.tag == DATE_TAG) {
        KKPopup *popup = [KKPopup initNib:@"KKDate"];
        [popup show];
        [popup setClick:^(NSDate *date, KKPopup * _Nonnull popup) {
            [popup hide];
            if (date) {
                NSString *dateStr = [date formatYMD];
                [btn setTitle:dateStr forState:UIControlStateNormal];
                [btn setTitle:dateStr forState:UIControlStateHighlighted];
            }
        }];
    }
}
// 删除
- (void)deleteBtnClick:(UIButton *)btn {
    if (btn.tag == DELETE_TAG) {
        if (_money.length > 1) {
            [_money deleteCharactersInRange:NSMakeRange(_money.length - 1, 1)];
            [self setMoney:_money];
        } else {
            _money = [NSMutableString string];
            _moneyLab.text = @"0";
        }
    }
}


// 根据btn.tag 返回数字
- (CGFloat)getMath:(NSInteger)tag {
    if (tag >= 10 && tag <= 12) {
        return tag - 3;
    }
    else if (tag >= 14 && tag <= 16) {
        return tag - 10;
    }
    else if (tag >= 18 && tag <= 20) {
        return tag - 17;
    }
    else if (tag == 23) {
        return 0;
    }
    return 0;
}
// 刷新完成按钮
- (void)reloadCompleteButton {
    if (_money.length == 0) {
        UIButton *btn = [self viewWithTag:FINISH_TAG];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn setTitle:@"完成" forState:UIControlStateHighlighted];
    } else {
        NSString *lastStr = [_money substringWithRange:NSMakeRange(_money.length - 1, 1)];
        if (_isPlus == true && ![lastStr isEqualToString:@"+"]) {
            UIButton *btn = [self viewWithTag:FINISH_TAG];
            [btn setTitle:@"=" forState:UIControlStateNormal];
            [btn setTitle:@"=" forState:UIControlStateHighlighted];
        } else {
            UIButton *btn = [self viewWithTag:FINISH_TAG];
            [btn setTitle:@"完成" forState:UIControlStateNormal];
            [btn setTitle:@"完成" forState:UIControlStateHighlighted];
        }
    }
}
// 计算
- (void)calculationMath {
    BOOL condition1 = [_money containsString:@"+"] && [_money containsString:@"-"]; // 加减
    BOOL condition2 = [_money componentsSeparatedByString:@"+"].count == 3;         // 加加
    BOOL condition3 = [_money componentsSeparatedByString:@"-"].count == 3;         // 减减
    // 需要计算
    if (condition1 == true || condition2 == true || condition3 == true) {
        NSMutableArray *arrm = [NSMutableArray array];
    }
}



#pragma mark - set
- (void)setMoney:(NSMutableString *)money {
    _money = money;
    _moneyLab.text = money;
}


#pragma mark - 通知
- (void)showKeyboard:(NSNotification *)not {
    NSTimeInterval time = [not.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat keyHeight = [not.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.textContent setTop:(self.height - keyHeight) - countcoordinatesX(60)];
    } completion:^(BOOL finished) {
        
    }];
}
- (void)hideKeyboard:(NSNotification *)not {
    NSTimeInterval time = [not.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.textContent setTop:0];
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - 系统
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

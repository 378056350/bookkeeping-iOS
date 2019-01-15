/**
 * 键盘
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BKCKeyboard.h"

#define DATE_TAG 13         // 日期
#define PLUS_TAG 17         // 加
#define LESS_TAG 21         // 减
#define POINT_TAG 22        // 点
#define DELETE_TAG 24       // 删除
#define FINISH_TAG 25       // 完成
#define IS_MATH(tag) (tag >= 10 && tag <= 12) || (tag >= 14 && tag <= 16) || (tag >= 18 && tag <= 20) || tag == 23   // 是否是数字



#pragma mark - 声明
@interface BKCKeyboard()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UITextField *markField;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIView *textContent;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyConstraintB;

@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, assign) BOOL isLess;          // 减
@property (nonatomic, assign) BOOL animation;       // 动画中

@end


#pragma mark - 实现
@implementation BKCKeyboard


+ (instancetype)init {
    BKCKeyboard *view = [BKCKeyboard loadFirstNib:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_WIDTH / 5 * 4 + SafeAreaBottomHeight)];
    [view setHidden:YES];
    [view initUI];
    return view;
}
- (void)initUI {
    [self borderForColor:kColor_BG borderWidth:1.f borderType:UIBorderSideTypeTop];
    [self setAnimation:NO];
    [self setIsLess:NO];
    [self setCurrentDate:[NSDate date]];
    
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [self.nameLab setTextColor:kColor_Text_Gary];
    [self.markField setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [self.moneyLab setFont:[UIFont systemFontOfSize:AdjustFont(18)]];
    [self.markField setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [self.markField setTintColor:kColor_Main_Color];
    [self.markField setTextColor:kColor_Text_Gary];
    
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
    
    [self.markField endEditing:YES];
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
    // 减
    [self lessBtnClick:btn];
    // 时间
    [self dateBtnClick:btn];
    // 删除
    [self deleteBtnClick:btn];
    // 完成/等于
    [self calculationClick:btn];
    // 刷新
    [self reloadCompleteButton];
    // 计算
    [self calculationMath];
}
// 数字
- (void)mathBtnClick:(UIButton *)btn {
    // 数字
    if (IS_MATH(btn.tag)) {
        
        NSInteger math = [self getMath:btn.tag];
        NSString *str = ({
            NSString *str;
            if ([_money componentsSeparatedByString:@"+"].count == 2) {
                str = [_money componentsSeparatedByString:@"+"][1];
            } else {
                str = _money;
            }
            str;
        });
        
        
        
        // 是否可以输入
        if ([self isAllowMath:str]) {
            if (_money.length == 0 || [_money isEqualToString:@"0"]) {
                _money = [NSMutableString stringWithString:[@(math) description]];
            } else {
                [_money appendString:[@(math) description]];
            }
            [self setMoney:_money];
        }
        
    }
}
// 点
- (void)pointBtnClick:(UIButton *)btn {
    // 点
    if (btn.tag == POINT_TAG) {
        // 是否可以输入
        if ([self isAllowPoint:_money]) {
            if (_money.length == 0) {
                [_money appendString:@"0"];
            }
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
        
        if ([self isAllowPlusOrLess:_money]) {
            [_money appendString:@"+"];
            [self setMoney:_money];
        }
    }
}
// 减
- (void)lessBtnClick:(UIButton *)btn {
    // 减
    if (btn.tag == LESS_TAG) {
        if (_money.length == 0) {
            _money = [NSMutableString stringWithString:@"0"];
        }
        
        if ([self isAllowPlusOrLess:_money]) {
            [_money appendString:@"-"];
            [self setMoney:_money];
        }
    }
}
// 时间
- (void)dateBtnClick:(UIButton *)btn {
    // 时间
    if (btn.tag == DATE_TAG) {
        @weakify(self)
        NSDate *date = [NSDate date];
        NSDate *min = [NSDate br_setYear:2000 month:1 day:1];
        NSDate *max = [NSDate br_setYear:date.year + 3 month:12 day:31];
        [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeYMD defaultSelValue:[self.currentDate formatYMD] minDate:min maxDate:max isAutoSelect:false themeColor:nil resultBlock:^(NSString *selectValue) {
            @strongify(self)
            [self setCurrentDate:({
                NSDateFormatter *fora = [[NSDateFormatter alloc] init];
                [fora setDateFormat:@"yyyy-MM-dd"];
                NSDate *date = [fora dateFromString:selectValue];
                date;
            })];
            selectValue = [self.currentDate isToday] ? @"今天" : selectValue;
            [btn setTitle:selectValue forState:UIControlStateNormal];
            [btn setTitle:selectValue forState:UIControlStateHighlighted];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
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
// 计算
- (void)calculationClick:(UIButton *)btn {
    if (btn.tag == FINISH_TAG) {
        [_money appendString:@"="];
        [self setMoney:_money];
        [self calculationMath];
    }
    if ([btn.titleLabel.text isEqualToString:@"完成"]) {
        if (self.complete) {
            self.complete(_moneyLab.text, _markField.text, self.currentDate);
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
        NSString *subMoney = [_money substringFromIndex:1];
        BOOL condition1 = ([subMoney containsString:@"+"] || [subMoney containsString:@"-"]) && ![_money hasSuffix:@"+"] && ![_money hasSuffix:@"-"];
        if (condition1) {
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
    if (_money.length == 0) {
        return;
    }
    
    
    BOOL condition1 = [_money hasSuffix:@"="];
    BOOL condition2 = [_money componentsSeparatedByString:@"+"].count == 3;
    BOOL condition3 = ([_money hasPrefix:@"-"] && [NSString getDuplicateSubStrCountInCompleteStr:_money withSubStr:@"-"] == 3) ||
                      (![_money hasPrefix:@"-"] && [NSString getDuplicateSubStrCountInCompleteStr:_money withSubStr:@"-"] == 2);
    BOOL condition4 = [_money containsString:@"+"] &&
                      (([_money hasPrefix:@"-"] && [NSString getDuplicateSubStrCountInCompleteStr:_money withSubStr:@"-"] == 2) ||
                       (![_money hasPrefix:@"-"] && [NSString getDuplicateSubStrCountInCompleteStr:_money withSubStr:@"-"] == 1));
    if (condition1 == true || condition2 == true || condition3 == true || condition4 == true) {
        NSMutableString *strm = [NSMutableString stringWithString:[NSString calcComplexFormulaString:_money]];
        // 没小数
        if (![self hasDecimal:strm]) {
            strm = [NSMutableString stringWithString:[strm componentsSeparatedByString:@"."][0]];
        }
        // 加
        if ([_money hasSuffix:@"+"]) {
            [strm appendString:@"+"];
        }
        // 减
        if ([_money hasSuffix:@"-"]) {
            [strm appendString:@"-"];
        }
//        // 没加减
//        if (![_money hasSuffix:@"+"] && ![_money hasSuffix:@"-"]) {
//            [self reloadCompleteButton];
//        }
        
        [self setMoney:strm];
    }
}


// 两数加减
- (NSString *)calculation:(NSString *)str1 math:(NSString *)str2 isPlus:(BOOL)isPlus {
    CGFloat number1 = [str1 floatValue];
    CGFloat number2 = [str2 floatValue];
    NSString *newNumber = [NSString stringWithFormat:@"%.2f", (isPlus ? number1 + number2 : number1 - number2)];
    if (![self hasDecimal:newNumber]) {
        newNumber = [newNumber substringWithRange:NSMakeRange(0, newNumber.length - 3)];
    }
    return newNumber;
}
// 是否有小数
- (BOOL)hasDecimal:(NSString *)number {
    NSArray<NSString *> *arr = [number componentsSeparatedByString:@"."];
    NSString *decimal = arr[1];
    if ([decimal integerValue] == 0) {
        return false;
    }
    return true;
}
// 获取字符串中的数字
- (NSArray<NSString *> *)getNumberWithString:(NSString *)string {
    // 第一个数是负数
    BOOL isNegative = [[string substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"-"];
    if (isNegative == true) {
        string = [string substringFromIndex:1];
    }
    
    NSString *lastStr = [string substringWithRange:NSMakeRange(string.length - 1, 1)];
    if ([lastStr isEqualToString:@"+"] || [lastStr isEqualToString:@"-"]) {
        string = [string substringToIndex:string.length - 1];
    }
    
    
    NSMutableArray *arrm;
    // 加法
    if ([string containsString:@"+"]) {
        arrm = [NSMutableArray arrayWithArray:[string componentsSeparatedByString:@"+"]];
    }
    // 减法
    else if ([string containsString:@"-"]) {
        arrm = [NSMutableArray arrayWithArray:[string componentsSeparatedByString:@"-"]];
    }
    // 第一个数是负数
    if (isNegative == true) {
        NSString *str = [NSString stringWithFormat:@"-%@", arrm[0]];
        [arrm replaceObjectAtIndex:0 withObject:str];
    }
    NSLog(@"%@", arrm);
    NSLog(@"123");
    return @[];
    
}

// 是否可以输入数字
- (BOOL)isAllowMath:(NSString *)str {
    // 超过10位
    if (_money.length >= 15) {
        return false;
    }
    
    
    if (!str || str.length == 0) {
        return true;
    }
    
    NSString *lastStr = [str substringFromIndex:str.length - 1];
    // 最后输入的是数字
    if ([lastStr isEqualToString:@"+"] || [lastStr isEqualToString:@"-"] || [lastStr isEqualToString:@"="]) {
        return true;
    }
    // 最后输入的是数字/点
    else {
        if ([str containsString:@"+"]) {
            str = [str componentsSeparatedByString:@"+"][1];
        } else if ([str containsString:@"-"]) {
            str = [str componentsSeparatedByString:@"-"][1];
        }
        NSArray<NSString *> *arr = [str componentsSeparatedByString:@"."];
        if (arr.count != 2 || (arr.count == 2 && arr[1].length < 2)) {
            return true;
        }
        return false;
    }
}
// 是否可以输入点
- (BOOL)isAllowPoint:(NSString *)str {
    // 超过10位
    if (_money.length >= 15) {
        return false;
    }
    
    
    // 是否可以输入
    for (int i=0; i<3; i++) {
        str = [str containsString:@"+"] ? [str componentsSeparatedByString:@"+"][1] : str;
        str = [str containsString:@"-"] ? [str componentsSeparatedByString:@"-"][1] : str;
    }
    if (![str containsString:@"."]) {
        return true;
    }
    return false;
}
// 是否可以输入加号减号
- (BOOL)isAllowPlusOrLess:(NSString *)str {
    NSString *lastStr = [str substringWithRange:NSMakeRange(_money.length - 1, 1)];
    if ([lastStr isEqualToString:@"+"] || [lastStr isEqualToString:@"-"]) {
        return false;
    }
    return true;
}


#pragma mark - set
- (void)setMoney:(NSMutableString *)money {
    _money = money;
    _moneyLab.text = money;
}
- (void)setModel:(BKModel *)model {
    _model = model;
    NSString *key = [NSString stringWithFormat:@"%ld-%02ld-%02ld", model.year, model.month, model.day];
    [self.markField setText:model.mark];
    [self setMoney:[@(model.price) description].mutableCopy];
    [self setCurrentDate:[NSDate dateWithYMD:key]];
    
    UIButton *btn = [self viewWithTag:DATE_TAG];
    NSString *selectValue = [self.currentDate isToday] ? @"今天" : key;
    [btn setTitle:selectValue forState:UIControlStateNormal];
    [btn setTitle:selectValue forState:UIControlStateHighlighted];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
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

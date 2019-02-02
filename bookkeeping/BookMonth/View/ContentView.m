/**
 * 月份
 * @author 郑业强 2019-01
 */

#import "ContentView.h"


#pragma mark - 声明
@interface ContentView()

@property (weak, nonatomic) IBOutlet UILabel *monthLab;
@property (weak, nonatomic) IBOutlet UILabel *monthDescLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab1;
@property (weak, nonatomic) IBOutlet UILabel *descLab2;
@property (weak, nonatomic) IBOutlet UILabel *descLab3;
@property (weak, nonatomic) IBOutlet UILabel *valueLab1;
@property (weak, nonatomic) IBOutlet UILabel *valueLab2;
@property (weak, nonatomic) IBOutlet UILabel *valueLab3;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *monthConstraintW;

@end


#pragma mark - 实现
@implementation ContentView


- (void)initUI {
    [self.monthLab setFont:[UIFont systemFontOfSize:AdjustFont(16)]];
    [self.monthLab setTextColor:kColor_Text_Black];
    [self.monthDescLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.monthDescLab setTextColor:kColor_Text_Black];
    [self.descLab1 setFont:[UIFont systemFontOfSize:AdjustFont(8) weight:UIFontWeightLight]];
    [self.descLab1 setTextColor:kColor_Text_Black];
    [self.descLab2 setFont:[UIFont systemFontOfSize:AdjustFont(8) weight:UIFontWeightLight]];
    [self.descLab2 setTextColor:kColor_Text_Black];
    [self.descLab3 setFont:[UIFont systemFontOfSize:AdjustFont(8) weight:UIFontWeightLight]];
    [self.descLab3 setTextColor:kColor_Text_Black];
    [self.bookBtn setTitle:@"记一笔" forState:UIControlStateNormal];
    [self.bookBtn.layer setCornerRadius:3];
    [self.bookBtn.layer setMasksToBounds:true];
    [self.bookBtn setBackgroundColor:kColor_Main_Color];
    [self.bookBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Color] forState:UIControlStateNormal];
    [self.bookBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.bookBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Dark_Color] forState:UIControlStateHighlighted];
    [self.bookBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.icon setBackgroundColor:kColor_Text_Gary];
    
    [self.valueLab1 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.valueLab1 setTextColor:kColor_Text_Black];
    [self.valueLab2 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.valueLab2 setTextColor:kColor_Text_Black];
    [self.valueLab3 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.valueLab3 setTextColor:kColor_Text_Black];
    
    
    // 月份
    NSDate *date = [NSDate date];
    NSString *month = [@(date.month) description];
    [_monthLab setText:month];
    [_monthConstraintW setConstant:[month sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:_monthLab.font].width];
    
    
    // 数据
    NSMutableArray<BKMonthModel *> *monthModels = [BKMonthModel statisticalMonthWithYear:date.year month:date.month];
    NSMutableArray<BKModel *> *arrm = [NSMutableArray array];
    for (BKMonthModel *month in monthModels) {
        [arrm addObjectsFromArray:month.list];
    }
    // 支出
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"cmodel.is_income == 0"];
//    NSMutableArray<BKModel *> *pay = [NSMutableArray arrayWithArray:[arrm filteredArrayUsingPredicate:pre]];
    NSMutableArray<BKModel *> *pay = [NSMutableArray kk_filteredArrayUsingPredicate:@"cmodel.is_income == 0" array:arrm];
    
    CGFloat payPrice = [[pay valueForKeyPath:@"@sum.price.floatValue"] floatValue];
    // 收入
//    pre = [NSPredicate predicateWithFormat:@"cmodel.is_income == 1"];
//    NSMutableArray<BKModel *> *income = [NSMutableArray arrayWithArray:[arrm filteredArrayUsingPredicate:pre]];
    NSMutableArray<BKModel *> *income = [NSMutableArray kk_filteredArrayUsingPredicate:@"cmodel.is_income == 1" array:arrm];
    CGFloat incomePrice = [[income valueForKeyPath:@"@sum.price.floatValue"] floatValue];
    
    [_valueLab1 setText:[NSString stringWithFormat:@"%.2f", incomePrice]];
    [_valueLab2 setText:[NSString stringWithFormat:@"%.2f", payPrice]];
    [_valueLab3 setText:[NSString stringWithFormat:@"%.2f", incomePrice - payPrice]];
    
    
}


@end

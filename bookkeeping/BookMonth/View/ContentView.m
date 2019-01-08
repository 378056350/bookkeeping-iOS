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
    [self setBackgroundColor:[UIColor clearColor]];
    [self.monthLab setFont:[UIFont systemFontOfSize:AdjustFont(16)]];
    [self.monthLab setTextColor:kColor_Text_Black];
    [self.monthDescLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.monthDescLab setTextColor:kColor_Text_Black];
    [self.descLab1 setFont:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]];
    [self.descLab1 setTextColor:kColor_Text_Gary];
    [self.descLab2 setFont:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]];
    [self.descLab2 setTextColor:kColor_Text_Gary];
    [self.descLab3 setFont:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]];
    [self.descLab3 setTextColor:kColor_Text_Gary];
    [self.bookBtn setTitle:@"记一笔" forState:UIControlStateNormal];
    [self.bookBtn.layer setCornerRadius:3];
    [self.bookBtn.layer setMasksToBounds:true];
    [self.bookBtn setBackgroundColor:kColor_Main_Color];
    [self.bookBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Color] forState:UIControlStateNormal];
    [self.bookBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.bookBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Dark_Color] forState:UIControlStateHighlighted];
    [self.bookBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.icon setBackgroundColor:kColor_Text_Gary];
    
    [self.valueLab1 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.valueLab2 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.valueLab3 setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    
    
    // 月份
    NSDate *date = [NSDate date];
    NSString *month = [@(date.month) description];
    [_monthLab setText:month];
    [_monthConstraintW setConstant:[month sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:_monthLab.font].width];
    
    
    
}


@end

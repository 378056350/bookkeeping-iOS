/**
 * 定时
 * @author 郑业强 2018-12-18 创建文件
 */

#import "TITableCell.h"
#import "TIMING_EVENT.h"

#pragma mark - 声明
@interface TITableCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeConstraintW;

@end


#pragma mark - 实现
@implementation TITableCell


- (void)initUI {
    [self setBackgroundColor:kColor_White];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Gary];
    [self.detailLab setFont:[UIFont fontWithName:@"Helvetica Neue" size:AdjustFont(12)]];
    [self.detailLab setTextColor:kColor_Text_Gary];
    [self.dayLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.dayLab setTextColor:kColor_Text_Gary];
    [self.timeConstraintW setConstant:[@"00:00" sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:self.detailLab.font].width + 5];
    
    
    
    @weakify(self)
    MGSwipeButton *btn = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:kColor_Red_Color];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [btn setButtonWidth:countcoordinatesX(80)];
    [btn setCallback:^BOOL(MGSwipeTableCell *cell) {
        @strongify(self)
        [self routerEventWithName:TIMING_CELL_DELETE data:self];
        return NO;
    }];
    [self setRightButtons:@[btn]];
}


#pragma mark - set
- (void)setTime:(NSString *)time {
    _time = time;
    _nameLab.text = @"提醒时间";
    _detailLab.text = time;
}
//- (void)setModel:(TIModel *)model {
//    _model = model;
//    _nameLab.text = @"提醒时间";
//    _detailLab.text = model.time;
//}


@end

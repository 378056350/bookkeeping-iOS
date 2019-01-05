/**
 * 头视图
 * @author 郑业强 2018-12-18 创建文件
 */

#import "HomeListHeader.h"

#pragma mark - 声明
@interface HomeListHeader()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstraintL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detaileConstraintR;

@end


#pragma mark - 实现
@implementation HomeListHeader


- (void)initUI {
    [self.nameLab setFont:[UIFont fontWithName:@"Helvetica Neue" size:AdjustFont(10)]];
    [self.nameLab setTextColor:kColor_Text_Gary];
    [self.detailLab setFont:[UIFont fontWithName:@"Helvetica Neue" size:AdjustFont(10)]];
    [self.detailLab setTextColor:kColor_Text_Gary];
    [self.line setBackgroundColor:kColor_BG];
    
    
    [self.nameConstraintL setConstant:countcoordinatesX(15)];
    [self.detaileConstraintR setConstant:countcoordinatesX(15)];
}


#pragma mark - set
- (void)setModel:(BKMonthModel *)model {
    _model = model;
    [_nameLab setText:model.dateStr];
    [_detailLab setText:model.moneyStr];
}
//- (void)setListSorts:(NSMutableArray<BookListModel *> *)listSorts {
//    _listSorts = listSorts;
//    if (listSorts.count != 0) {
//        BookListModel *submodel = listSorts[0];
//        NSArray *week = @[@"",@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
//        NSString *name = [NSString stringWithFormat:@"%02ld月%02ld日 星期%@", submodel.month, submodel.day, week[submodel.week_day]];
//        NSMutableString *detail = ({
//            CGFloat income = 0;
//            CGFloat pay = 0;
//            for (BookListModel *model in listSorts) {
//                if (model.is_income == 0) {
//                    pay += model.price;
//                } else {
//                    income += model.price;
//                }
//            }
//            NSMutableString *detail = [[NSMutableString alloc] init];
//            if (income != 0) {
//                [detail appendFormat:@"收入: %.f", income];
//            }
//            if (income != 0 && pay != 0) {
//                [detail appendString:@" "];
//            }
//            if (pay != 0) {
//                [detail appendFormat:@"支出: %.f", pay];
//            }
//            detail;
//        });
//        [self.nameLab setText:name];
//        [self.detailLab setText:detail];
//    }
//}


@end

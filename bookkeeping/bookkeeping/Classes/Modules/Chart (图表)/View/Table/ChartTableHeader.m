/**
 * 图表头视图
 * @author 郑业强 2018-12-18 创建文件
 */

#import "ChartTableHeader.h"
#import "BookChart.h"

#pragma mark - 声明
@interface ChartTableHeader()

@property (nonatomic, strong) UILabel *maxLab;
@property (nonatomic, strong) UILabel *avgLab;
@property (nonatomic, strong) BookChart *chart;

@end


#pragma mark - 实现
@implementation ChartTableHeader


- (void)initUI {
    [self maxLab];
    [self avgLab];
    [self chart];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.chart.status = BookChartStatusWeek;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.chart.status = BookChartStatusMonth;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                self.chart.status = BookChartStatusYear;
//            });
//        });
//    });
}


#pragma mark - set
- (void)setModel:(BKChartModel *)model {
    _model = model;
    _chart.model = model;
    _avgLab.text = [NSString stringWithFormat:@"平均值: %@", [@(model.avg) description]];
    _maxLab.text = ({
        NSString *str;
        if (model.is_income == false) {
            str = [NSString stringWithFormat:@"总支出: %@", [@(model.sum) description]];
        } else {
            str = [NSString stringWithFormat:@"总收入: %@", [@(model.sum) description]];
        }
        str;
    });
}


#pragma mark - get
- (UILabel *)maxLab {
    if (!_maxLab) {
        _maxLab = [[UILabel alloc] initWithFrame:CGRectMake(countcoordinatesX(15), countcoordinatesX(5), SCREEN_WIDTH, countcoordinatesX(20))];
        _maxLab.textColor = kColor_Text_Black;
        _maxLab.font = [UIFont systemFontOfSize:AdjustFont(11) weight:UIFontWeightUltraLight];
        [self addSubview:_maxLab];
    }
    return _maxLab;
}
- (UILabel *)avgLab {
    if (!_avgLab) {
        _avgLab = [[UILabel alloc] initWithFrame:CGRectMake(_maxLab.left, _maxLab.bottom + countcoordinatesX(3), SCREEN_WIDTH, countcoordinatesX(20))];
        _avgLab.textColor = kColor_Text_Black;
        _avgLab.font = [UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightUltraLight];
        [self addSubview:_avgLab];
    }
    return _avgLab;
}
- (BookChart *)chart {
    if (!_chart) {
        _chart = [BookChart loadCode:({
            CGFloat left = 0;
            CGFloat top = _avgLab.bottom + countcoordinatesX(5);
            CGFloat width = SCREEN_WIDTH;
            CGFloat height = self.height - top;
            CGRectMake(left, top, width, height);
        })];
        [self addSubview:_chart];
    }
    return _chart;
}


@end

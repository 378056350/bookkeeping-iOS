/**
 * 图表
 * @author 郑业强 2018-12-18 创建文件
 */

#import "BookChart.h"

#define CHART_L countcoordinatesX(15)
#define CHART_T countcoordinatesX(5)
#define CHART_W (SCREEN_WIDTH - CHART_L * 2)
#define CHART_H (self.height - CHART_T * 2)
#define CHART_LINE 1.f / [UIScreen mainScreen].scale / 2.f
#define CHART_POINT_W countcoordinatesX(5)

#define CHART_FONT [UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]

#pragma mark - 声明
@interface BookChart()


@end


#pragma mark - 实现
@implementation BookChart


- (void)initUI {
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"123");
}


- (void)drawRect:(CGRect)rect {
    [kColor_White setFill];
    UIRectFill(rect);
    
    [self drawLine:CGPointMake(CHART_L, CHART_T) point2:CGPointMake(CHART_W + CHART_L, CHART_T) color:kColor_Text_Gary isDash:NO];
    [self drawLine:CGPointMake(CHART_L, CHART_T + countcoordinatesX(40)) point2:CGPointMake(CHART_W + CHART_L, CHART_T + countcoordinatesX(40)) color:kColor_Text_Gary isDash:YES];
    [self drawLine:CGPointMake(CHART_L, CHART_T + countcoordinatesX(80)) point2:CGPointMake(CHART_W + CHART_L, CHART_T + countcoordinatesX(80)) color:kColor_Text_Black isDash:NO];

    
//    [self drawText:@"123123" color:kColor_Text_Gary frame:CGRectMake(CHART_L, CHART_T + countcoordinatesX(80) + countcoordinatesX(5), 80, countcoordinatesX(20))];
//
//    [self drawArc:kColor_Text_Gary fill:kColor_Main_Color frame:CGRectMake(10, 10, 20, 20)];
//
//    [self drawLine:kColor_Text_Gary points:@[[NSValue valueWithCGPoint:CGPointMake(CHART_L, CHART_T)],
//                                             [NSValue valueWithCGPoint:CGPointMake(CHART_L + countcoordinatesX(10), CHART_T + countcoordinatesX(10))],
//                                             [NSValue valueWithCGPoint:CGPointMake(CHART_L + countcoordinatesX(20), CHART_T + countcoordinatesX(20))]]];
    
    if (_status == BookChartStatusWeek) {
        [self drawWeek];
    }
    else if (_status == BookChartStatusMonth) {
        [self drawMonth];
    }
    else if (_status == BookChartStatusYear) {
        [self drawYear];
    }
}

#pragma mark - set
- (void)setStatus:(BookChartStatus)status {
    _status = status;
    [self setNeedsDisplay];
}
- (void)setModels:(NSMutableArray<ChartModel *> *)models {
    _models = models;
    
}



// 周
- (void)drawWeek {
    CGFloat count = 7;
    for (int i=0; i<count; i++) {
        
        CGFloat width = CHART_W / (count - 1);
        CGFloat left = CHART_L - CHART_POINT_W / 2 + width * i;
        // 点
        [self drawArc:kColor_Text_Gary fill:kColor_Main_Color frame:({
            CGFloat top = CHART_T + countcoordinatesX(80) - CHART_POINT_W / 2;
            CGRectMake(left, top, CHART_POINT_W, CHART_POINT_W);
        })];
        
        // 文字
        NSString *str = @"12-06";
        [self drawText:str color:kColor_Text_Black frame:({
            CGFloat textW = [str sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:CHART_FONT].width;
            CGFloat top = CHART_T + countcoordinatesX(80) + countcoordinatesX(5);
            if (i == 0) {
                left += textW / 2.f;
            } else if (i == (count - 1)) {
                left -= textW / 2.f - CHART_POINT_W;
            } else {
                left += CHART_POINT_W / 2;
            }
            CGRectMake(left - textW / 2.f, top, textW, countcoordinatesX(20));
        })];
    }
}
// 月
- (void)drawMonth {
    CGFloat count = 30;
    for (int i=0; i<count; i++) {
        
        CGFloat width = CHART_W / (count - 1);
        CGFloat left = CHART_L - CHART_POINT_W / 2 + width * i;
        // 点
        [self drawArc:kColor_Text_Gary fill:kColor_Main_Color frame:({
            CGFloat top = CHART_T + countcoordinatesX(80) - CHART_POINT_W / 2;
            CGRectMake(left, top, CHART_POINT_W, CHART_POINT_W);
        })];
        
        // 文字
        NSString *str = @"12";
        if (i == 0 || i == (count - 1) || (i % 5 == 0 && i != (count - 2))) {
            [self drawText:str color:kColor_Text_Black frame:({
                CGFloat textW = [str sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:CHART_FONT].width;
                CGFloat top = CHART_T + countcoordinatesX(80) + countcoordinatesX(5);
                if (i == 0) {
                    left += textW / 2.f;
                } else if (i == (count - 1)) {
                    left -= textW / 2.f - CHART_POINT_W;
                } else {
                    left += CHART_POINT_W / 2;
                }
                CGRectMake(left - textW / 2.f, top, textW, countcoordinatesX(20));
            })];
        }
    }
}
// 年
- (void)drawYear {
    
    CGFloat count = 12;
    for (int i=0; i<count; i++) {
        
        CGFloat width = CHART_W / (count - 1);
        CGFloat left = CHART_L - CHART_POINT_W / 2 + width * i;
        // 点
        [self drawArc:kColor_Text_Gary fill:kColor_Main_Color frame:({
            CGFloat top = CHART_T + countcoordinatesX(80) - CHART_POINT_W / 2;
            CGRectMake(left, top, CHART_POINT_W, CHART_POINT_W);
        })];
        
        // 文字
        NSString *str = @"12";
        if (i == 0 || (i + 1) % 3 == 0) {
            [self drawText:str color:kColor_Text_Black frame:({
                CGFloat textW = [str sizeWithMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:CHART_FONT].width;
                CGFloat top = CHART_T + countcoordinatesX(80) + countcoordinatesX(5);
                if (i == 0) {
                    left += textW / 2.f;
                } else if (i == (count - 1)) {
                    left -= textW / 2.f - CHART_POINT_W;
                } else {
                    left += CHART_POINT_W / 2;
                }
                CGRectMake(left - textW / 2.f, top, textW, countcoordinatesX(20));
            })];
        }
    }
}



// 绘制线条
- (void)drawLine:(CGPoint)point point2:(CGPoint)point2 color:(UIColor *)color isDash:(BOOL)isDash {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, point.x, point.y);
    CGContextAddLineToPoint(ctx, point2.x, point2.y);
    [color set];
    if (isDash == YES) {
        CGFloat lengths[] = {5, 5, 5, 5};
        CGContextSetLineDash(ctx, 0, lengths, 4);
    } else {
        CGFloat lengths[] = {};
        CGContextSetLineDash(ctx, 0, lengths, 0);
    }
    CGContextSetLineWidth(ctx, CHART_LINE);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextStrokePath(ctx);
}
// 绘制文字
- (void)drawText:(NSString *)text color:(UIColor *)color frame:(CGRect)frame {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *dict = @{NSForegroundColorAttributeName: color,
                           NSFontAttributeName: CHART_FONT,
                           NSParagraphStyleAttributeName: style
                           };
    [text drawInRect:frame withAttributes:dict];
}
// 绘制圆形
- (void)drawArc:(UIColor *)line fill:(UIColor *)fill frame:(CGRect)frame {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, CHART_LINE);
    CGContextSetStrokeColorWithColor(context, line.CGColor);
    CGContextSetFillColorWithColor(context, fill.CGColor);
    CGContextAddEllipseInRect(context, frame);
    CGContextDrawPath(context, kCGPathFillStroke);
}
// 绘制折现
- (void)drawLine:(UIColor *)color points:(NSArray<NSValue *> *)arr {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (int i=0; i<arr.count; i++) {
        CGPoint point = [arr[i] CGPointValue];
        if (i == 0) {
            CGContextMoveToPoint(ctx, point.x, point.y);
        } else {
            CGContextAddLineToPoint(ctx, point.x, point.y);
        }
    }
    [color set];
    CGContextSetLineWidth(ctx, CHART_LINE);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextStrokePath(ctx);
}



@end

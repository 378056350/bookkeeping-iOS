/**
 * 分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "CAHeader.h"
#import "CA_EVENT.h"

#pragma mark - 声明
@interface CAHeader()

@end


#pragma mark - 实现
@implementation CAHeader


- (void)initUI {
    CGFloat height = 30;
    [self setBackgroundColor:kColor_Main_Color];
    [self.seg setBackgroundColor:kColor_Main_Color];
    [self.seg setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Color size:CGSizeMake(1, height)]
                        forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.seg setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Dark_Color size:CGSizeMake(1, height)]
                        forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self.seg setBackgroundImage:[UIColor createImageWithColor:kColor_Text_Black size:CGSizeMake(1, height)]
                        forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    NSDictionary *dic1 = @{NSForegroundColorAttributeName: kColor_Text_Black};
    [self.seg setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    NSDictionary *dic2 = @{NSForegroundColorAttributeName: kColor_Main_Color};
    [self.seg setTitleTextAttributes:dic2 forState:UIControlStateSelected];
    [self.seg.layer setCornerRadius:5];
    [self.seg.layer setMasksToBounds:YES];
    [self.seg.layer setBorderWidth:1];
    [self.seg.layer setBorderColor:kColor_Text_Black.CGColor];
    [self.seg setTintColor:kColor_Text_Black];
}


- (IBAction)segValueChange:(UISegmentedControl *)sender {
    [self routerEventWithName:CATEGORY_SEG_CHANGE data:@(sender.selectedSegmentIndex)];
}


@end

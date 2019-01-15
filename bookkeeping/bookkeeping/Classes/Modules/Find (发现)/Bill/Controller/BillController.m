/**
 * 账单
 * @author 郑业强 2019-01-09 创建文件
 */

#import "BillController.h"
#import "BillTable.h"

#pragma mark - 声明
@interface BillController()

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) BillTable *table;

@end


#pragma mark - 实现
@implementation BillController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"账单"];
    [self setDate:[NSDate date]];
    [self.rightButton setHidden:false];
    [self.rightButton setFrame:CGRectMake(0, 0, 70, 44)];
    [self.rightButton addSubview:({
        UIImageView *image = [[UIImageView alloc] init];
        image.frame = CGRectMake(self.rightButton.width - 15, 0, 15, self.rightButton.height);
        image.image = [UIImage imageNamed:@"time_down"];
        image.contentMode = UIViewContentModeScaleAspectFit;
        image;
    })];
    [self.rightButton addSubview:({
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
        lab.text = @"2019年";
        lab.font = [UIFont systemFontOfSize:AdjustFont(14)];
        lab.textColor = kColor_Text_Black;
        lab.textAlignment = NSTextAlignmentRight;
        lab.tag = 10;
        lab;
    })];
    [self table];
    dispatch_async(dispatch_get_main_queue(), ^{
       [self changeVlaue:[@(self.date.year) description]];
    });
}


- (void)rightButtonClick {
    @weakify(self)
    NSDate *date = [NSDate date];
    NSDate *min = [NSDate br_setYear:2000 month:1 day:1];
    NSDate *max = [NSDate br_setYear:date.year + 3 month:12 day:31];
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeY defaultSelValue:[@(self.date.year) description] minDate:min maxDate:max isAutoSelect:false themeColor:nil resultBlock:^(NSString *selectValue) {
        @strongify(self)
        [self changeVlaue:selectValue];
    }];
}


- (void)changeVlaue:(NSString *)selectValue {
    [self setDate:[NSDate dateWithYMD:[NSString stringWithFormat:@"%@-01-01", selectValue]]];
    [(UILabel *)[self.rightButton viewWithTag:10] setText:[NSString stringWithFormat:@"%ld年", self.date.year]];
    
    // 过滤
    NSMutableArray<BKModel *> *bookArr = [NSUserDefaults objectForKey:PIN_BOOK];
    NSString *str = [NSString stringWithFormat:@"year == %@", selectValue];
//    NSPredicate *pre = [NSPredicate predicateWithFormat:str];
//    bookArr = [NSMutableArray arrayWithArray:[bookArr filteredArrayUsingPredicate:pre]];
    bookArr = [NSMutableArray kk_filteredArrayUsingPredicate:str array:bookArr];
    
    
    str = [NSString stringWithFormat:@"cmodel.is_income == 1"];
//    pre = [NSPredicate predicateWithFormat:str];
//    NSMutableArray<BKModel *> *arrm1 = [NSMutableArray arrayWithArray:[bookArr filteredArrayUsingPredicate:pre]];
    NSMutableArray<BKModel *> *arrm1 = [NSMutableArray kk_filteredArrayUsingPredicate:str array:bookArr];
    
    str = [NSString stringWithFormat:@"cmodel.is_income == 0"];
//    pre = [NSPredicate predicateWithFormat:str];
//    NSMutableArray<BKModel *> *arrm2 = [NSMutableArray arrayWithArray:[bookArr filteredArrayUsingPredicate:pre]];
    NSMutableArray<BKModel *> *arrm2 = [NSMutableArray kk_filteredArrayUsingPredicate:str array:bookArr];
    
            
            
    
    
    [self.table setIncome:[[arrm1 valueForKeyPath:@"@sum.price.floatValue"] floatValue]];
    [self.table setPay:[[arrm2 valueForKeyPath:@"@sum.price.floatValue"] floatValue]];
    
    
    NSMutableArray *arrm = [NSMutableArray array];
    for (NSInteger i=1; i<=12; i++) {
        NSString *str1 = [NSString stringWithFormat:@"month == %ld AND cmodel.is_income == 1", i];
//        NSPredicate *pre = [NSPredicate predicateWithFormat:str1];
//        NSMutableArray<BKModel *> *incomeModels = [NSMutableArray arrayWithArray:[bookArr filteredArrayUsingPredicate:pre]];
        NSMutableArray<BKModel *> *incomeModels = [NSMutableArray kk_filteredArrayUsingPredicate:str1 array:bookArr];
        
        NSString *str2 = [NSString stringWithFormat:@"month == %ld AND cmodel.is_income == 0", i];
//        pre = [NSPredicate predicateWithFormat:str2];
//        NSMutableArray<BKModel *> *payModels = [NSMutableArray arrayWithArray:[bookArr filteredArrayUsingPredicate:pre]];
        NSMutableArray<BKModel *> *payModels = [NSMutableArray kk_filteredArrayUsingPredicate:str2 array:bookArr];
        
        
        CGFloat income = [[incomeModels valueForKeyPath:@"@sum.price.floatValue"] floatValue];
        CGFloat pay = [[payModels valueForKeyPath:@"@sum.price.floatValue"] floatValue];
        NSDictionary *param = @{@"month": [NSString stringWithFormat:@"%ld月", i],
                                @"income": [NSString stringWithFormat:@"%.2f", income],
                                @"pay": [NSString stringWithFormat:@"%.2f", pay],
                                @"sum": [NSString stringWithFormat:@"%.2f", income - pay]
                                };
        [arrm addObject:param];
    }
    
    BOOL maxMonth = false;
    NSMutableArray *newArrm = [NSMutableArray array];
    for (NSInteger i=12; i>=1; i--) {
        NSDictionary *param = arrm[i-1];
        if (![param[@"income"] isEqualToString:@"0.00"] || ![param[@"pay"] isEqualToString:@"0.00"]) {
            maxMonth = true;
        }
        if (maxMonth == true) {
            [newArrm addObject:param];
        }
    }
    [self.table setModels:newArrm];
}


#pragma mark - get
- (BillTable *)table {
    if (!_table) {
        _table = [[BillTable alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight) style:UITableViewStyleGrouped];
        [_table setBackgroundView:({
            UIView *back = [[UIView alloc] initWithFrame:self.table.bounds];
            [back setBackgroundColor:kColor_BG];
            [back addSubview:({
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
                view.backgroundColor = kColor_Main_Color;
                view;
            })];
            back;
        })];
        [self.view addSubview:_table];
    }
    return _table;
}


@end

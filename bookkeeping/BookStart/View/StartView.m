/**
 * 内容控件
 * @author 郑业强 2019-01-09 创建文件
 */

#import "StartView.h"
#import "StartHeader.h"
#import "StartScroll.h"
#import "StartKeyboard.h"
#import "START_EVENT.h"


#pragma mark - 声明
@interface StartView()

@property (nonatomic, strong) StartHeader *header;
@property (nonatomic, strong) StartScroll *scroll;
@property (nonatomic, strong) StartKeyboard *keyboard;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation StartView


- (void)initUI {
    [self header];
    [self scroll];
    [self keyboard];
}


#pragma mark - 事件
- (void)routerEventWithName:(NSString *)eventName data:(id)data {
    [self handleEventWithName:eventName data:data];
}
- (void)handleEventWithName:(NSString *)eventName data:(id)data {
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&data atIndex:2];
    [invocation invoke];
    [super routerEventWithName:eventName data:data];
}
// 收入/支出切换
- (void)startSegClick:(NSNumber *)index {
    _scroll.segIndex = [index integerValue];
}
// 记账
- (void)startBook:(NSString *)price date:(NSDate *)date {
    if (!price || price.length == 0 || [price isEqualToString:@"0"]) {
        return;
    }
    
    BKCModel *cmodel = self.scroll.models[self.scroll.currentPage];
    BKModel *model = [[BKModel alloc] init];
    model.Id = [[BKModel getId] integerValue];
    model.price = [price floatValue];
    model.year = date.year;
    model.month = date.month;
    model.day = date.day;
    model.mark = @"";
    model.category_id = cmodel.Id;
    model.cmodel = cmodel;
    
    // 新增
    NSMutableArray *bookArr = [NSUserDefaults objectForKey:PIN_BOOK];
    NSMutableArray *bookSyncedArr = [NSUserDefaults objectForKey:PIN_BOOK_SYNCED];
    [bookArr addObject:model];
    [bookSyncedArr addObject:model];
    [NSUserDefaults setObject:bookArr forKey:PIN_BOOK];
    [NSUserDefaults setObject:bookArr forKey:PIN_BOOK_SYNCED];
    
    // 传递
    [super routerEventWithName:START_SEG_BOOK data:nil];
}


#pragma mark - get
- (StartHeader *)header {
    if (!_header) {
        _header = [StartHeader loadCode:CGRectMake(0, 0, self.width, 40)];
        [self addSubview:_header];
    }
    return _header;
}
- (StartScroll *)scroll {
    if (!_scroll) {
        _scroll = [StartScroll loadCode:CGRectMake(0, self.header.bottom, self.width, 70)];
        [self addSubview:_scroll];
    }
    return _scroll;
}
- (StartKeyboard *)keyboard {
    if (!_keyboard) {
        @weakify(self)
        _keyboard = [StartKeyboard loadFirstNib:({
            CGFloat left = countcoordinatesX(20);
            CGFloat width = self.width - left * 2;
            CGFloat height = self.width / 4.f * 3.f - countcoordinatesX(20);
            CGRectMake(left, self.scroll.bottom + countcoordinatesX(2), width, height);
        })];
        [_keyboard setComplete:^(NSString *price, NSString *mark, NSDate *date) {
            @strongify(self)
            [self startBook:price date:date];
        }];
        [self addSubview:_keyboard];
    }
    return _keyboard;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           START_SEG_CLICK: [self createInvocationWithSelector:@selector(startSegClick:)],
                           };
    }
    return _eventStrategy;
}


@end

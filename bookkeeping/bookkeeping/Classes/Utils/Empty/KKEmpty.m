/**
 * 空白页
 * @author 郑业强 2018-11-20
 */

#import "KKEmpty.h"
#import "KKGoodsEmpty.h"
#import "KKEmptyNoNet.h"
#import "KKEmptyCommon.h"
#import "KKEmptyLoading.h"
#import "KKEmptyNoneOrder.h"

#define Shadow_Tag 100

#pragma mark - 声明
@interface KKEmpty()

@property (nonatomic, strong) KKEmptyNoNet *noNet;
@property (nonatomic, strong) KKEmptyCommon *common;
@property (nonatomic, strong) KKEmptyLoading *loading;
@property (nonatomic, strong) KKEmptyNoneOrder *noneOrder;
@property (nonatomic, strong) KKGoodsEmpty *emptyGoods;

@property (nonatomic, strong) UIButton *back;
@property (nonatomic, strong) NSDictionary<NSString*, NSInvocation*> *eventStrategy;

@end

#pragma mark - 实现
@implementation KKEmpty


+ (instancetype)initWithFrame:(CGRect)frame {
    KKEmpty *view = [[KKEmpty alloc] initWithFrame:frame];
    [view initUI];
    return view;
}
- (void)initUI {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self noNet];
    [self common];
    [self loading];
    [self noneOrder];
    [self emptyGoods];
    [self back];
}


#pragma mark - set
- (void)setStatus:(KKEmptyStatus)status {
    _status = status;
    
    // 无网络
    if (status == KKEmptyStatusNet) {
        [self.noNet setHidden:NO];
        [self.common setHidden:YES];
        [self.loading setHidden:YES];
        [self.loading hide];
        [self.noneOrder setHidden:YES];
        [self.emptyGoods setHidden:YES];
    }
    // 无数据
    else if (status == KKEmptyStatusCommon) {
        [self.noNet setHidden:YES];
        [self.common setHidden:NO];
        [self.loading setHidden:YES];
        [self.loading hide];
        [self.noneOrder setHidden:YES];
        [self.emptyGoods setHidden:YES];
    }
    // 正在加载
    else if (status == KKEmptyStatusLoading) {
        [self.noNet setHidden:YES];
        [self.common setHidden:YES];
        [self.loading setHidden:NO];
        [self.loading show];
        [self.noneOrder setHidden:YES];
        [self.emptyGoods setHidden:YES];
    }
    // 没有相关订单
    else if (status == KKEmptyStatusNoneOrder) {
        [self.noNet setHidden:YES];
        [self.common setHidden:YES];
        [self.loading setHidden:YES];
        [self.loading hide];
        [self.noneOrder setHidden:NO];
        [self.emptyGoods setHidden:YES];
    }
    // 暂无商品
    else if (status == KKEmptyStatusLoadGoods) {
        [self.noNet setHidden:YES];
        [self.common setHidden:YES];
        [self.loading setHidden:YES];
        [self.loading hide];
        [self.noneOrder setHidden:YES];
        [self.emptyGoods setHidden:NO];
    }
}
- (void)setHasBack:(BOOL)hasBack {
    _hasBack = hasBack;
    if (hasBack == YES) {
        _back.hidden = NO;
    }
    else {
        _back.hidden = YES;
    }
    [self bringSubviewToFront:_back];
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGRect bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    [self.noNet setFrame:bounds];
    [self.common setFrame:bounds];
    [self.loading setFrame:bounds];
    [self.noneOrder setFrame:bounds];
    [self.emptyGoods setFrame:bounds];
}


#pragma mark - Event Response
- (void)routerEventWithName:(NSString *)eventName data:(id)data {
    // 处理事件
    [self handleEventWithName:eventName data:data];
    // 把响应链继续传递下去
    [super routerEventWithName:eventName data:data];
}
- (void)handleEventWithName:(NSString *)eventName data:(id)data {
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&data atIndex:2];
    [invocation invoke];
}
- (void)nonetClick:(id)data {
    if (self.click) {
        self.click(KKEmptyClickDealLoad);
    }
}


#pragma mark - 点击
- (void)backClick {
    [self.viewController.navigationController popViewControllerAnimated:YES];
}


#pragma mark - get
- (KKEmptyNoNet *)noNet {
    if (!_noNet) {
        _noNet = [KKEmptyNoNet loadCode:self.bounds];
        [self addSubview:_noNet];
    }
    return _noNet;
}
- (KKEmptyCommon *)common {
    if (!_common) {
        _common = [KKEmptyCommon loadCode:self.bounds];
        [self addSubview:_common];
    }
    return _common;
}
- (KKEmptyLoading *)loading {
    if (!_loading) {
        _loading = [KKEmptyLoading loadCode:self.bounds];
        [self addSubview:_loading];
    }
    return _loading;
}
- (KKEmptyNoneOrder *)noneOrder {
    if (!_noneOrder) {
        _noneOrder = [KKEmptyNoneOrder loadCode:self.bounds];
        [self addSubview:_noneOrder];
    }
    return _noneOrder;
}
- (KKGoodsEmpty *)emptyGoods {
    if (!_emptyGoods) {
        _emptyGoods = [KKGoodsEmpty loadFirstNib:self.bounds];
        [self addSubview:_emptyGoods];
    }
    return _emptyGoods;
}
- (UIButton *)back {
    if (!_back) {
        _back = [UIButton buttonWithType:UIButtonTypeCustom];
        [_back.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_back setFrame:CGRectMake(0, countcoordinatesX(10) + StatusBarHeight, 35, 30)];
        [_back setHidden:YES];
        [_back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_back];
    }
    return _back;
}

- (NSDictionary<NSString*, NSInvocation*> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           kEventNoNetClick: [self createInvocationWithSelector:@selector(nonetClick:)]
                           };
    }
    return _eventStrategy;
}


@end

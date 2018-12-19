/**
 * 记账
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BookController.h"
#import "BookCollectionView.h"
#import "BookNavigation.h"
#import "BookKeyboard.h"
#import "BOOK_EVENT_MANAGER.h"


#pragma mark - 声明
@interface BookController()<UIScrollViewDelegate>

@property (nonatomic, strong) BookNavigation *navigation;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) NSMutableArray<BookCollectionView *> *collections;
@property (nonatomic, strong) BookKeyboard *keyboard;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation BookController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:YES];
    [self setTitle:@"记账"];
    [self navigation];
    [self scroll];
    [self collections];
    [self keyboard];
}


#pragma mark - 点击
- (void)rightButtonClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
// 点击导航栏
- (void)bookClickNavigation:(NSNumber *)index {
    [self.scroll setContentOffset:CGPointMake(SCREEN_WIDTH * [index integerValue], 0) animated:YES];
}
// 点击item
- (void)bookClickItem:(NSIndexPath *)indexPath {
    [self.keyboard show];
    
    NSInteger page = _scroll.contentOffset.x / SCREEN_WIDTH;
    BookCollectionView *collection = self.collections[page];
    [collection setHeight:SCREEN_HEIGHT - NavigationBarHeight - self.keyboard.height];
    [collection scrollToIndex:indexPath];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (BookCollectionView *collection in self.collections) {
        [collection reloadSelectIndex];
        [collection setHeight:SCREEN_HEIGHT - NavigationBarHeight];
    }
    [self.keyboard hide];
    [self.navigation setOffsetX:scrollView.contentOffset.x];
}


#pragma mark - get
- (UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:({
            CGFloat left = 0;
            CGFloat top = NavigationBarHeight;
            CGFloat width = SCREEN_WIDTH;
            CGFloat height = SCREEN_HEIGHT - NavigationBarHeight;
            CGRectMake(left, top, width, height);
        })];
        [_scroll setDelegate:self];
        [_scroll setShowsHorizontalScrollIndicator:NO];
        [_scroll setPagingEnabled:YES];
        [self.view addSubview:_scroll];
    }
    return _scroll;
}
- (BookNavigation *)navigation {
    if (!_navigation) {
        _navigation = [BookNavigation loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight)];
        [self.view addSubview:_navigation];
    }
    return _navigation;
}
- (NSMutableArray<BookCollectionView *> *)collections {
    if (!_collections) {
        _collections = [NSMutableArray array];
        for (int i=0; i<2; i++) {
            BookCollectionView *collection = [BookCollectionView initWithFrame:({
                CGFloat width = SCREEN_WIDTH;
                CGFloat left = i * width;
                CGFloat height = SCREEN_HEIGHT - NavigationBarHeight;
                CGRectMake(left, 0, width, height);
            })];
            [_scroll setContentSize:CGSizeMake(SCREEN_WIDTH * 2, 0)];
            [_scroll addSubview:collection];
            [_collections addObject:collection];
        }
    }
    return _collections;
}
- (BookKeyboard *)keyboard {
    if (!_keyboard) {
        _keyboard = [BookKeyboard init];
        [self.view addSubview:_keyboard];
    }
    return _keyboard;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           BOOK_CLICK_ITEM: [self createInvocationWithSelector:@selector(bookClickItem:)],
                           BOOK_CLICK_NAVIGATION: [self createInvocationWithSelector:@selector(bookClickNavigation:)],
                           };
    }
    return _eventStrategy;
}


@end

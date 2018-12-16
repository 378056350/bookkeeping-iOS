/**
 * 记账
 * @author 郑业强 2018-12-16 创建文件
 */

#import "BookController.h"
#import "BookCollectionView.h"

#pragma mark - 声明
@interface BookController()

@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) NSMutableArray<BookCollectionView *> *collections;

@end


#pragma mark - 实现
@implementation BookController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self setTitle:@"记账"];
    [self scroll];
    [self collections];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[UIView new]]];
    [self.rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.rightButton setHidden:NO];
}


- (void)rightButtonClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
        [_scroll setShowsHorizontalScrollIndicator:NO];
        [_scroll setPagingEnabled:YES];
        [self.view addSubview:_scroll];
    }
    return _scroll;
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


@end

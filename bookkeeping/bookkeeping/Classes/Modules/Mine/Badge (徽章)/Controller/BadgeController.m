/**
 * 徽章
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BadgeController.h"
#import "BadgeCollection.h"

#pragma mark - 声明
@interface BadgeController()

@property (nonatomic, strong) BadgeCollection *collection;

@end


#pragma mark - 实现
@implementation BadgeController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"徽章"];
    [self setJz_navigationBarHidden:NO];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self collection];
}


#pragma mark - get
- (BadgeCollection *)collection {
    if (!_collection) {
        _collection = [BadgeCollection loadCode:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight)];
        [self.view addSubview:_collection];
    }
    return _collection;
}


@end

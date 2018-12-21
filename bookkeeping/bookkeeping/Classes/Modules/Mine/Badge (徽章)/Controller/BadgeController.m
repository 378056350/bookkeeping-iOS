/**
 * 徽章
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BadgeController.h"
#import "BadgeCollection.h"
#import "BadgeListModel.h"

#pragma mark - 声明
@interface BadgeController()

@property (nonatomic, strong) BadgeCollection *collection;
@property (nonatomic, strong) NSArray<BadgeListModel *> *models;

@end


#pragma mark - 实现
@implementation BadgeController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"徽章"];
    [self setJz_navigationBarHidden:NO];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self collection];
    [self getBadgeListRequest];
}


#pragma mark - 请求
// 获取我的徽章
- (void)getBadgeListRequest {
    @weakify(self)
    [self.collection createRequest:BadgeListRequest params:@{} complete:^(APPResult * result) {
        @strongify(self)
        [self setModels:[BadgeListModel mj_objectArrayWithKeyValuesArray:result.data]];
    }];
}


#pragma mark - set
- (void)setModels:(NSArray<BadgeListModel *> *)models {
    _models = models;
    _collection.models = models;
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

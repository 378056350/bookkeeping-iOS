/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ACAController.h"
#import "ACATextField.h"
#import "ACACollection.h"
#import "ACAListModel.h"
#import "ACA_EVENT_MANAGER.h"


#pragma mark - 声明
@interface ACAController()

@property (nonatomic, strong) ACATextField *textField;
@property (nonatomic, strong) ACACollection *collection;
@property (nonatomic, strong) NSArray<ACAListModel *> *models;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation ACAController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"添加支出类别"];
    [self setJz_navigationBarHidden:NO];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"完成" forState:UIControlStateHighlighted];
    [self.rightButton setHidden:NO];
    [self textField];
    [self collection];
    [self getCategoryListRequest];
}

- (void)rightButtonClick {
    
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
// 点击item
- (void)itemClick:(ACAModel *)model {
    [self.textField setModel:model];
}


#pragma mark - 请求
// 添加类别列表
- (void)getCategoryListRequest {
    @weakify(self)
    [self.collection createRequest:InsertCategoryListRequest params:@{} complete:^(APPResult * result) {
        @strongify(self)
        [self setModels:[ACAListModel mj_objectArrayWithKeyValuesArray:result.data]];
    }];
}
// 添加新类别
- (void)addCategoryRequest {
    @weakify(self)
    [AFNManager POST:AddInsertCategoryListRequest complete:^(APPResult *result) {
        @strongify(self)
        if (result.status == ServiceCodeSuccess) {
            
        } else {
            
        }
    }];
}
// 添加原有类别
- (void)addAleardyCategoryRequest {
    @weakify(self)
    [AFNManager POST:AddAleardyCategoryRequest complete:^(APPResult *result) {
        @strongify(self)
        if (result.status == ServiceCodeSuccess) {
            
        } else {
            
        }
    }];
}


#pragma mark - set
- (void)setModels:(NSArray<ACAListModel *> *)models {
    _models = models;
    _collection.models = models;
}


#pragma mark - get
- (ACATextField *)textField {
    if (!_textField) {
        _textField = [ACATextField loadFirstNib:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, countcoordinatesX(60))];
        [self.view addSubview:_textField];
    }
    return _textField;
}
- (ACACollection *)collection {
    if (!_collection) {
        _collection = [ACACollection initWithFrame:CGRectMake(0, _textField.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _textField.bottom)];
        [self.view addSubview:_collection];
    }
    return _collection;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           ACA_CLICK_ITEM: [self createInvocationWithSelector:@selector(itemClick:)],
                           
                           };
    }
    return _eventStrategy;
}


@end

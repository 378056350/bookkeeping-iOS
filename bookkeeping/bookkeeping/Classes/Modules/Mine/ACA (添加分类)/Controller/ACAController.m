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
@property (nonatomic, strong) ACAModel *selectModel;
@property (nonatomic, strong) NSArray<ACAListModel *> *models;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation ACAController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:_is_income == true ? @"添加收入类别" : @"添加支出类别"];
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
    [self addCategoryRequest];
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
    _selectModel = model;
    [self.textField setModel:model];
}


#pragma mark - 请求
// 添加类别列表
- (void)getCategoryListRequest {
    @weakify(self)
    [self.collection createRequest:CustomerCategoryListRequest params:@{} complete:^(APPResult * result) {
        @strongify(self)
        [self setModels:[ACAListModel mj_objectArrayWithKeyValuesArray:result.data]];
    }];
}
// 添加自定义类别
- (void)addCategoryRequest {
    if (_textField.textField.text.length == 0) {
        [self showTextHUD:@"类别名称不能为空" delay:1.f];
        return;
    }
    
    @weakify(self)
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           _textField.textField.text, @"name",
                           @(_selectModel.Id), @"category_insert_id",
                           @(1), @"customer_id",
                           @(_is_income), @"is_income", nil];
    [self showProgressHUD];
    [AFNManager POST:AddInsertCategoryListRequest params:param complete:^(APPResult * _Nonnull result) {
        @strongify(self)
        [self hideHUD];
        if (result.status == ServiceCodeSuccess) {
            [self showTextHUD:result.message delay:1.5f];
            if (self.complete) {
                self.complete();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else {
            [self showTextHUD:result.message delay:1.5f];
        }
    }];
}
//// 添加原有类别
//- (void)addAleardyCategoryRequest {
//    @weakify(self)
//    [AFNManager POST:AddAleardyCategoryRequest complete:^(APPResult *result) {
//        @strongify(self)
//        if (result.status == ServiceCodeSuccess) {
//
//        } else {
//
//        }
//    }];
//}


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

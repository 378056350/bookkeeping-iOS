/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "ACAController.h"
#import "ACATextField.h"
#import "ACACollection.h"


#pragma mark - 声明
@interface ACAController()

@property (nonatomic, strong) ACATextField *textField;
@property (nonatomic, strong) ACACollection *collection;

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
}

- (void)rightButtonClick {
    
}


#pragma mark - get
- (ACATextField *)textField {
    if (!_textField) {
        _textField = [ACATextField loadFirstNib:CGRectMake(0, NavigationBarHeight, SCREEN_WIDTH, countcoordinatesX(50))];
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



@end

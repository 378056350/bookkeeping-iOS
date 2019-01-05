/**
 * 记账详情页
 * @author 郑业强 2019-01-05 创建
 */

#import "BDController.h"
#import "BDHeader.h"
#import "BDBottom.h"

#pragma mark - 声明
@interface BDController()

@property (nonatomic, strong) BDHeader *header;
@property (nonatomic, strong) BDBottom *bottom;

@end


#pragma mark - 实现
@implementation BDController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:true];
    [self.rightButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"分享" forState:UIControlStateHighlighted];
    [self.rightButton setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.rightButton setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.rightButton setHidden:NO];
    [self header];
    [self bottom];
}


#pragma mark - set
- (void)setModel:(BKModel *)model {
    _model = model;
    self.header.model = model;
}


#pragma mark - get
- (BDHeader *)header {
    if (!_header) {
        _header = [BDHeader loadFirstNib:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + 64)];
        [self.view addSubview:_header];
    }
    return _header;
}
- (BDBottom *)bottom {
    if (!_bottom) {
        _bottom = [BDBottom loadFirstNib:({
            CGFloat height = countcoordinatesX(50) + SafeAreaBottomHeight;
            CGRectMake(0, SCREEN_HEIGHT - height, SCREEN_WIDTH, height);
        })];
        [self.view addSubview:_bottom];
    }
    return _bottom;
}


@end

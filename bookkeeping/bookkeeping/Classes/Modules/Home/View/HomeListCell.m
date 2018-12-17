/**
 * 列表cell
 * @author 郑业强 2018-12-17 创建文件
 */

#import "HomeListCell.h"
#import "KKRefreshNormalHeader.h"
#import "HOME_EVENT_MANAGER.h"

#pragma mark - 声明
@interface HomeListCell()

@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) KKRefreshNormalHeader *header;

@end


#pragma mark - 实现
@implementation HomeListCell


- (void)initUI {
    [self setBackgroundColor:[UIColor brownColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self scroll];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.scroll setFrame:self.contentView.bounds];
}


#pragma mark - get
- (UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [_scroll setBackgroundColor:RGBA(random() % 255, random() % 255, random() % 255, 1)];
        [_scroll setMj_header:self.header];
        [self.contentView addSubview:_scroll];
    }
    return _scroll;
}
- (KKRefreshNormalHeader *)header {
    if (!_header) {
        __weak typeof(self) weak = self;
        _header = [KKRefreshNormalHeader headerWithRefreshingBlock:^{
            [weak routerEventWithName:HOME_HEADER_BEGIN_REFRESH data:nil];
        }];
    }
    return _header;
}


@end

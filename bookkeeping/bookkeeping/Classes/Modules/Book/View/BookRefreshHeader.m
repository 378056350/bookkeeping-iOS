/**
 * 刷新
 * @author 郑业强 2018-12-19 创建文件
 */

#import "BookRefreshHeader.h"

#pragma mark - 声明
@interface BookRefreshHeader()

@end

#pragma mark - 实现
@implementation BookRefreshHeader


+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    BookRefreshHeader *header = [super headerWithRefreshingBlock:refreshingBlock];
    [header setTitle:@"下拉关闭页面" forState:MJRefreshStateIdle];
    [header setTitle:@"离开此页面" forState:MJRefreshStatePulling];
    [header setTitle:@"离开此页面" forState:MJRefreshStateRefreshing];
    [header.lastUpdatedTimeLabel setHidden:YES];
    [header.stateLabel setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [header.stateLabel setTextColor:kColor_Text_Gary];
    [header.arrowView setHidden:YES];
    [header setOnlyText:NO];
    return header;
}


@end

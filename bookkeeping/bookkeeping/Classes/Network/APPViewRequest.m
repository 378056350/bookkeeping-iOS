/**
 * 页面请求参数
 * @author 郑业强 2018-10-
 */

#import "APPViewRequest.h"

@implementation APPViewRequest


+ (instancetype)sharedManager {
    APPViewRequest *manager = [[APPViewRequest alloc] init];
    manager.afn_frame = CGRectZero;
    manager.afn_useCache = YES;
    manager.afn_showLoading = YES;
    manager.afn_showCommon = YES;
    manager.afn_showError = YES;
    manager.afn_hasData = YES;
    manager.afn_loadStatus = KKEmptyStatusLoading;
    manager.afn_commonStatus = KKEmptyStatusCommon;
    manager.afn_errorStatus = KKEmptyStatusNet;
    manager.afn_hasData = NO;
    manager.page = -1;
    manager.afn_isHeader = YES;
    return manager;
}


@end

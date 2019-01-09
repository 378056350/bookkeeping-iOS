/**
 * 定时
 * @author 郑业强 2018-12-18 创建文件
 */

#import <UIKit/UIKit.h>
#import "TIModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TITableView : UITableView

@property (nonatomic, strong) NSMutableArray *models;

+ (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END

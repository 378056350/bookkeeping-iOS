/**
 * 添加分类
 * @author 郑业强 2018-12-17 创建文件
 */

#import "BaseView.h"
#import "ACAListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ACATextField : BaseView

@property (nonatomic, strong) ACAModel *model;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

NS_ASSUME_NONNULL_END

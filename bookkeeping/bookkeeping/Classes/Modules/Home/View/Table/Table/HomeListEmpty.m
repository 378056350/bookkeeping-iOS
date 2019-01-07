/**
 * 空白页
 * @author 郑业强 2018-12-28 创建文件
 */

#import "HomeListEmpty.h"

#pragma mark - 声明
@interface HomeListEmpty()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end


#pragma mark - 实现
@implementation HomeListEmpty


- (void)initUI {
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(12) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Gary];
    [self setUserInteractionEnabled:false];
    [self setHidden:true];
}


@end

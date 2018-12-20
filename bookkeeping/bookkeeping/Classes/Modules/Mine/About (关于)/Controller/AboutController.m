/**
 * 关于
 * @author 郑业强 2018-12-20 创建文件
 */

#import "AboutController.h"

#pragma mark - 声明
@interface AboutController()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *share;

@end


#pragma mark - 实现
@implementation AboutController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:NO];
    [self setJz_navigationBarTintColor:kColor_Main_Color];
    [self setNavTitle:@"关于鲨鱼记账"];
    [self image];
    [self share];
    [self nameLab];
    [self share];
}


#pragma mark - get
- (UIImageView *)image {
    if (!_image) {
        _image = [[UIImageView alloc] initWithFrame:({
            CGFloat left = countcoordinatesX(30);
            CGFloat width = SCREEN_WIDTH - left * 2;
            CGRectMake(left, countcoordinatesX(30) + NavigationBarHeight, width, width);
        })];
        _image.contentMode = UIViewContentModeScaleAspectFit;
        _image.image = [UIImage imageNamed:@"about"];
        [self.view addSubview:_image];
    }
    return _image;
}
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _image.bottom, SCREEN_WIDTH, countcoordinatesX(20))];
        _nameLab.text = @"财务自由从鲨鱼记账开始";
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight];
        [self.view addSubview:_nameLab];
    }
    return _nameLab;
}
- (UIButton *)share {
    if (!_share) {
        _share = [UIButton buttonWithType:UIButtonTypeCustom];
        _share.frame = ({
            CGFloat left = SCREEN_WIDTH / 4;
            CGFloat width = SCREEN_WIDTH - left * 2;
            CGFloat height = countcoordinatesX(40);
            CGFloat top = SCREEN_HEIGHT - SafeAreaBottomHeight - countcoordinatesX(80) - height;
            CGRectMake(left, top, width, height);
        });
        [_share setTitle:@"关注鲨鱼记账微信公众号" forState:UIControlStateNormal];
        [_share setTitle:@"关注鲨鱼记账微信公众号" forState:UIControlStateHighlighted];
        [_share setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
        [_share setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
        [_share.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight]];
        [_share setBackgroundImage:[UIColor createImageWithColor:kColor_BG] forState:UIControlStateNormal];
        [_share setBackgroundImage:[UIColor createImageWithColor:kColor_Line_Color] forState:UIControlStateHighlighted];
        [_share.layer setBorderColor:kColor_Text_Gary.CGColor];
        [_share.layer setBorderWidth:1.f / [UIScreen mainScreen].scale];
        [_share.layer setCornerRadius:5];
        [self.view addSubview:_share];
    }
    return _share;
}



@end

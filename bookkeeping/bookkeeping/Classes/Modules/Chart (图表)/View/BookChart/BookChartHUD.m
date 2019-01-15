/**
 * 图表弹框
 * @author 郑业强 2018-12-30 创建文件
 */

#import "BookChartHUD.h"
#import "BCHUDContent.h"

#pragma mark - 声明
@interface BookChartHUD()

@property (nonatomic, strong) UIView *line;             // 线
@property (nonatomic, strong) UIImageView *triangle;    // 三角
@property (nonatomic, strong) UIView *point;            // 点
@property (nonatomic, strong) BCHUDContent *content;

@end

#pragma mark - 实现
@implementation BookChartHUD

+ (instancetype)init {
    BookChartHUD *hud = [BookChartHUD loadCode:CGRectMake(0, 0, SCREEN_WIDTH / 2, 30)];
    [hud initUI];
    [hud content];
    return hud;
}
- (void)initUI {
    [self setUserInteractionEnabled:false];
    [self line];
    [self point];
    [self setHidden:true];
}

#pragma mark - set
- (void)setPointFrame:(CGRect)pointFrame {
    _pointFrame = pointFrame;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.point setFrame:pointFrame];
        [self.point.layer setCornerRadius:pointFrame.size.height / 2];
        [self.line setTop:pointFrame.origin.y - self.line.height];
        [self.line setCenterX:CGRectGetMidX(pointFrame)];
        [self.content setTop:self.line.top - self.content.height];
        [self.content setCenterX:CGRectGetMidX(pointFrame)];
        [self.triangle setCenterX:CGRectGetMidX(pointFrame)];
        [self.triangle setTop:self.line.top - 2];
        
        if (self.content.left < 0) {
            self.content.left = 0;
        } else if (self.content.right > SCREEN_WIDTH) {
            self.content.left = SCREEN_WIDTH - self.content.width;
        }
        
        [self setHidden:false];
    });
}
- (void)setModels:(NSMutableArray<BKModel *> *)models {
    _models = models;
    _content.models = models;
    NSInteger count = models.count > 3 ? 3 : models.count;
    if (models.count == 0) {
        _content.height = countcoordinatesX(50);
    } else {
        _content.height = countcoordinatesX(20) + count * countcoordinatesX(20) + countcoordinatesX(20) + countcoordinatesX(10) * 2 + countcoordinatesX(5);
    }
}

#pragma mark - get
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, countcoordinatesX(1), countcoordinatesX(60))];
        [_line setBackgroundColor:kColor_Text_Black];
        [self addSubview:_line];
    }
    return _line;
}
- (UIView *)point {
    if (!_point) {
        _point = [[UIView alloc] init];
        [_point setBackgroundColor:kColor_Text_Black];
        [self addSubview:_point];
    }
    return _point;
}
- (UIImageView *)triangle {
    if (!_triangle) {
        UIImage *image = [UIImage imageNamed:@"triangle"];
        _triangle = [[UIImageView alloc] initWithFrame:({
            CGFloat width = countcoordinatesX(10);
            CGRectMake(0, 0, width, width / image.size.width * image.size.height);
        })];
        _triangle.contentMode = UIViewContentModeScaleAspectFit;
        _triangle.image = image;
        [self addSubview:_triangle];
    }
    return _triangle;
}
- (BCHUDContent *)content {
    if (!_content) {
        _content = [BCHUDContent loadCode:CGRectMake(0, 0, SCREEN_WIDTH / 2, countcoordinatesX(120))];
        [self addSubview:_content];
    }
    return _content;
}

@end

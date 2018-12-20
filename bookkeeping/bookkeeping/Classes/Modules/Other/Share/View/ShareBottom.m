/**
 * 分享
 * @author 郑业强 2018-12-20 创建文件
 */

#import "ShareBottom.h"

#pragma mark - 声明
@interface ShareBottom()

@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *arr;

@end

#pragma mark - 实现
@implementation ShareBottom


- (void)initUI {
    [self setBackgroundColor:kColor_White];
    [self scroll];
    [self createShareButton];
}

- (void)createShareButton {
    NSArray<NSArray<NSString *> *> *arr = @[
                                            @[@"保存图片",@"微信",@"朋友圈",@"QQ",@"新浪微博",@"短信"],
                                            @[@"share_download",
                                              @"share_wx",
                                              @"share_wxfc",
                                              @"share_qq",
                                              @"share_sina",
                                              @"share_sms"]
                                            ];
    for (int i=0; i<arr[0].count; i++) {
        CGFloat padding = countcoordinatesX(25);
        CGFloat width = SCREEN_WIDTH / 7;
        CGFloat height = self.height - SafeAreaBottomHeight;
        CGFloat left = (width + padding) * i + padding;
        
        UIImageView *image = ({
            UIImageView *image = [[UIImageView alloc] initWithFrame:({
                CGRectMake(0, countcoordinatesX(20), width, width);
            })];
            image.image = [UIImage imageNamed:arr[1][i]];
            image.contentMode = UIViewContentModeScaleAspectFit;
            image.tag = 10;
            image;
        });
        
        UILabel *lab = ({
            UILabel *lab = [[UILabel alloc] initWithFrame:({
                CGRectMake(0, image.bottom, width, countcoordinatesX(20));
            })];
            lab.font = [UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight];
            lab.textColor = kColor_Text_Black;
            lab.text = arr[0][i];
            lab.textAlignment = NSTextAlignmentCenter;
            lab;
        });
        
        UIButton *view = [[UIButton alloc] initWithFrame:({
            CGRectMake(left, 0, width, height);
        })];
        [view setTag:i];
        [[view rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIButton *btn) {
            NSString *str = [NSString stringWithFormat:@"%@_h", self.arr[1][btn.tag]];
            UIImageView *image = [btn viewWithTag:10];
            image.image = [UIImage imageNamed:str];
        }];
        [[view rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton *btn) {
            NSString *str = [NSString stringWithFormat:@"%@", self.arr[1][btn.tag]];
            UIImageView *image = [btn viewWithTag:10];
            image.image = [UIImage imageNamed:str];
        }];
        [[view rac_signalForControlEvents:UIControlEventTouchUpOutside] subscribeNext:^(__kindof UIButton *btn) {
            NSString *str = [NSString stringWithFormat:@"%@", self.arr[1][btn.tag]];
            UIImageView *image = [btn viewWithTag:10];
            image.image = [UIImage imageNamed:str];
        }];
        [view addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:image];
        [view addSubview:lab];
        [self.scroll addSubview:view];
        [self.scroll setContentSize:CGSizeMake(view.right + padding, 0)];
    }
}


- (void)btnClick:(UIButton *)btn {
    NSString *str = [NSString stringWithFormat:@"%@", self.arr[1][btn.tag]];
    
    UIImageView *image = [btn viewWithTag:10];
    image.image = [UIImage imageNamed:str];
}


#pragma mark - get
- (UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        [_scroll setShowsHorizontalScrollIndicator:NO];
        [self addSubview:_scroll];
    }
    return _scroll;
}
- (NSArray<NSArray<NSString *> *> *)arr {
    if (!_arr) {
        _arr =  @[
                  @[@"保存图片",@"微信",@"朋友圈",@"QQ",@"新浪微博",@"短信"],
                  @[@"share_download",
                    @"share_wx",
                    @"share_wxfc",
                    @"share_qq",
                    @"share_sina",
                    @"share_sms"]
                  ];
    }
    return _arr;
}


@end

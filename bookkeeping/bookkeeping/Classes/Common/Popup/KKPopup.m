//
//  KKPopup.m
//  imiss-ios-master
//
//  Created by zhongke on 2018/10/18.
//  Copyright © 2018年 kk. All rights reserved.
//

#import "KKPopup.h"
#import "BaseView+Popup.h"

#pragma mark - 声明
@interface KKPopup()

@property (nonatomic, strong) UIButton *shadow;

@end


#pragma mark - 实现
@implementation KKPopup
static BOOL _isCreateCode;
static NSString *_clsName;


+ (instancetype)initCode:(NSString *)clsName {
    _clsName = clsName;
    _isCreateCode = YES;
    KKPopup *popup = [KKPopup loadCode:SCREEN_BOUNDS];
    [[UIApplication sharedApplication].keyWindow addSubview:popup];
    return popup;
}
+ (instancetype)initNib:(NSString *)clsName {
    _clsName = clsName;
    _isCreateCode = NO;
    KKPopup *popup = [KKPopup loadCode:SCREEN_BOUNDS];
    [[UIApplication sharedApplication].keyWindow addSubview:popup];
    return popup;
}
- (void)initUI {
    [self setUserInteractionEnabled:NO];
    [self shadow];
    [self contentv];
    [self setStatus:[NSClassFromString(_clsName) createStatus]];
}


#pragma mark - action
- (void)show {
    [self show:^{
        
    }];
}
- (void)show:(void (^)(void))complete {
    if (_status == KKPopupStatusBottom) {
        _contentv.alpha = 0;
        _contentv.top = SCREEN_HEIGHT - self.contentv.height;
        
        __weak typeof(self) weak = self;
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
        scaleAnimation.fromValue = @(self.contentv.height);
        scaleAnimation.toValue = @(0);
        scaleAnimation.beginTime = CACurrentMediaTime();
        scaleAnimation.duration = 0.2f;
        [scaleAnimation setAnimationDidStartBlock:^(POPAnimation *anim) {
            weak.contentv.alpha = 1;
        }];
        [self.contentv.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        
        POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        alphaAnimation.toValue  = @(1);
        alphaAnimation.beginTime = CACurrentMediaTime();
        alphaAnimation.duration = 0.2f;
        [self.shadow pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
        
        
        [alphaAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            self.userInteractionEnabled = YES;
            if (complete) {
                complete();
            }
        }];
    }
    else if (_status == KKPopupStatusCenter) {
        _contentv.alpha = 0;
        _contentv.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.2, 0.2f)];
        scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
        scaleAnimation.beginTime = CACurrentMediaTime();
        scaleAnimation.duration = 0.2f;
        [self.contentv.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        
        POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        alphaAnimation.toValue  = @(1);
        alphaAnimation.beginTime = CACurrentMediaTime();
        alphaAnimation.duration = 0.2f;
        [self.contentv pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
        [self.shadow pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
        
        
        [alphaAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            self.userInteractionEnabled = YES;
            if (complete) {
                complete();
            }
        }];
    }
    else if (_status == KKPopupStatusTop) {
        _contentv.alpha = 0;
        _contentv.top = 0;
        
        __weak typeof(self) weak = self;
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
        scaleAnimation.fromValue = @(-self.contentv.height);
        scaleAnimation.toValue = @(0);
        scaleAnimation.beginTime = CACurrentMediaTime();
        scaleAnimation.duration = 0.2f;
        [scaleAnimation setAnimationDidStartBlock:^(POPAnimation *anim) {
            weak.contentv.alpha = 1;
        }];
        [self.contentv.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        alphaAnimation.toValue  = @(1);
        alphaAnimation.beginTime = CACurrentMediaTime();
        alphaAnimation.duration = 0.2f;
        [self.shadow pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
        
        [alphaAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            self.userInteractionEnabled = YES;
            if (complete) {
                complete();
            }
        }];
    }
}
- (void)hide {
    [self hide:^{
        
    }];
}
- (void)hide:(void (^)(void))complete {
    if (_status == KKPopupStatusBottom) {
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
        scaleAnimation.toValue = @(self.contentv.height);
        scaleAnimation.beginTime = CACurrentMediaTime();
        scaleAnimation.springBounciness = 8.f;
        scaleAnimation.springSpeed = 6;
        [self.contentv.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        alphaAnimation.toValue  = @(0);
        alphaAnimation.beginTime = CACurrentMediaTime();
        alphaAnimation.duration = 0.2f;
        [self.shadow pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
        
        
        [alphaAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            [self removeFromSuperview];
            if (complete) {
                complete();
            }
        }];
    }
    else if (_status == KKPopupStatusCenter) {
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
        scaleAnimation.toValue  = [NSValue valueWithCGSize:CGSizeMake(0.2, 0.2)];
        scaleAnimation.beginTime = CACurrentMediaTime();
        scaleAnimation.springBounciness = 8.f;
        scaleAnimation.springSpeed = 3;
        [self.contentv.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        alphaAnimation.toValue  = @(0);
        alphaAnimation.beginTime = CACurrentMediaTime();
        alphaAnimation.duration = 0.2f;
        [self.contentv pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
        [self.shadow pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
        
        [alphaAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            [self removeFromSuperview];
            if (complete) {
                complete();
            }
        }];
    }
    else if (_status == KKPopupStatusTop) {
        
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
        scaleAnimation.toValue = @(-self.contentv.height);
        scaleAnimation.beginTime = CACurrentMediaTime();
        scaleAnimation.duration = 0.2f;
        [self.contentv.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        alphaAnimation.toValue  = @(0);
        alphaAnimation.beginTime = CACurrentMediaTime();
        alphaAnimation.duration = 0.2f;
        [self.shadow pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
        
        [alphaAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            [self removeFromSuperview];
            if (complete) {
                complete();
            }
        }];
    }
}


#pragma mark - set
- (void)setStatus:(KKPopupStatus)status {
    _status = status;
    if (status == KKPopupStatusBottom) {
        if (_contentv) {
            _contentv.top = SCREEN_HEIGHT;
            _contentv.alpha = 0;
        }
    } else if (status == KKPopupStatusCenter) {
        if (_contentv) {
            _contentv.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
            _contentv.alpha = 0;
        }
    } else if (status == KKPopupStatusTop) {
        if (_contentv) {
            _contentv.top = -_contentv.height;
            _contentv.alpha = 0;
        }
    }
}
- (void)setData:(id)data {
    _data = data;
    [_contentv setValue:data forKey:@"data"];
}


#pragma mark - get
- (UIButton *)shadow {
    if (!_shadow) {
        _shadow = [UIButton buttonWithType:UIButtonTypeCustom];
        _shadow.frame = SCREEN_BOUNDS;
        _shadow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _shadow.alpha = 0;
        [_shadow addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shadow];
    }
    return _shadow;
}
- (BaseView *)contentv {
    if (!_contentv) {
        Class cls = NSClassFromString(_clsName);
        if (_isCreateCode == YES) {
            _contentv = [cls loadCode:[cls createContentFrame]];
        } else {
            _contentv = [cls loadFirstNib:[cls createContentFrame]];
        }
        _contentv.backgroundColor = [UIColor whiteColor];
        _contentv.popup = self;
        [self addSubview:_contentv];
    }
    return _contentv;
}


@end

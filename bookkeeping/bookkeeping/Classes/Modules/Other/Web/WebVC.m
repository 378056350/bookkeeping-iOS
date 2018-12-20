//
//  GameController.m
//  ZhongLv
//
//  Created by zhongke on 2018/11/14.
//  Copyright © 2018年 iOSlmm. All rights reserved.
//

#import "WebVC.h"
#import <WebKit/WebKit.h>

#pragma mark - 声明
@interface WebVC()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *web;
@property (nonatomic, strong) UIProgressView *myProgressView;

@end

#pragma mark - 实现
@implementation WebVC


- (instancetype)init {
    if (self = [super init]) {
        _showProgress = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self web];
    [self myProgressView];
    if (_url) {
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
}


#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.web && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - getter and setter
- (WKWebView *)web {
    if (!_web) {
        _web = [[WKWebView alloc] initWithFrame:({
            CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight);
        }) configuration:({
            WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
            config.userContentController = [[WKUserContentController alloc] init];
            [config setPreferences:({
                WKPreferences *preferences = [WKPreferences new];
                preferences.javaScriptCanOpenWindowsAutomatically = YES;
                preferences.minimumFontSize = 40.0;
                preferences;
            })];
            config;
        })];
        [_web addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_web setUIDelegate:self];
        [_web setNavigationDelegate:self];
        [self.view addSubview:_web];
    }
    return _web;
}
- (UIProgressView *)myProgressView {
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        _myProgressView.tintColor = [UIColor blueColor];
        _myProgressView.trackTintColor = [UIColor whiteColor];
        _myProgressView.hidden = !_showProgress;
        [self.view addSubview:_myProgressView];
    }
    return _myProgressView;
}


#pragma mark - set
- (void)setShowProgress:(BOOL)showProgress {
    _showProgress = showProgress;
    if (showProgress == YES) {
        _myProgressView.hidden = NO;
    } else {
        _myProgressView.hidden = YES;
    }
}


#pragma mark - 系统
- (void)dealloc {
    [self.web removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end

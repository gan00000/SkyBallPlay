//
//  HTNewsWebCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsWebCell.h"
#import <WebKit/WebKit.h>

@interface HTNewsWebCell ()

@property (nonatomic, weak) HTNewsModel *newsModel;
@property (nonatomic, strong) UIScrollView *webContentView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation HTNewsWebCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.webContentView];
}

- (void)dealloc {
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    BJLog(@"cell: %@ dealloc", NSStringFromClass([self class]));
}

- (void)setupWithNewsModel:(HTNewsModel *)newsModel {
    if (!newsModel) {
        return;
    }
    if (self.newsModel == newsModel) {
        return;
    }
    self.newsModel = newsModel;
    
//    if (!self.hasLoad) {
//        self.hasLoad = YES;
//        NSMutableString *tempHtmlStr = [NSMutableString stringWithString:self.newsModel.content];
//
//        /*
//         NSString *cssStyleStart = @"<style> * {margin: 0;padding: 0;}";
//         NSString *bodyStley = @"body{padding: 10px;color: #101010;font-size:14px;font-family: 'Helvetica Neue'; font-weight: 300;}";
//         NSString *dtStyle = @"dt{margin-bottom: 0;}";
//         NSString *ddStyle = @"dd{margin-bottom: 15px; line-height: 1.5; text-align: justify; display: inline-block;}";
//         NSString *pStyle = @"p{text-indent: 2em;}";
//         NSString *imgStyle = @"img{display: block;width: 100%;}";
//         NSString *cssStyleEnd = @"</style>";
//         NSString *cssStyle = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", cssStyleStart, bodyStley, dtStyle, ddStyle, pStyle, imgStyle, cssStyleEnd];
//         */
//
//        NSString *meta = @"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\">";
//
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"bid_safety" ofType:@"css"];
//        NSString *safetyStyle = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//
//        NSString *htmlStr = [NSString stringWithFormat:@"<!DOCTYPE html><html>%@<body>%@%@</body></html>", meta, safetyStyle, tempHtmlStr];
//        [self.webView loadHTMLString:htmlStr baseURL:nil];
//    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.newsModel.url]]];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    __weak typeof(self) weakSelf = self;
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self.webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            CGFloat height = [result doubleValue];
            weakSelf.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
            weakSelf.webContentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
            weakSelf.webContentView.contentSize =CGSizeMake(SCREEN_WIDTH, height);
            
            if (weakSelf.onContentHeightUpdateBlock) {
                weakSelf.onContentHeightUpdateBlock(height);
            }
        }];
    }
}

#pragma mark - getters
- (UIScrollView *)webContentView {
    if (!_webContentView) {
        _webContentView = [[UIScrollView alloc] init];
        [_webContentView addSubview:self.webView];
    }
    return _webContentView;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.scrollView.scrollEnabled = NO;
        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

@end















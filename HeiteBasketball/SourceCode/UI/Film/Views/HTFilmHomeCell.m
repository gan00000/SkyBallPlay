//
//  HTFilmHomeCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTFilmHomeCell.h"
#import <WebKit/WebKit.h>

@interface HTFilmHomeCell () <WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, weak) HTNewsModel *model;

@end

@implementation HTFilmHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self addSubview:self.webView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithNewsModel:(HTNewsModel *)newsModel {
    if (!newsModel) {
        return;
    }
    self.model = newsModel;
    
    self.webView.frame = CGRectMake(0, 10, SCREEN_WIDTH, newsModel.iframe_height);
    [self.webView loadHTMLString:newsModel.iframe baseURL:nil];
    [self.webView showLoadingView];
    
    self.titleLabel.text = newsModel.title;
    self.kindLabel.text = newsModel.news_type;
    self.timeLabel.text = newsModel.time;
    self.viewCountLabel.text = newsModel.view_count;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [self.webView hideLoadingView];
}

#pragma mark - lazy load
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f4f4"];
        _webView.scrollView.scrollEnabled = NO;
        _webView.navigationDelegate = self;
        _webView.clearsContextBeforeDrawing = YES;
        _webView.clipsToBounds = YES;
    }
    return _webView;
}


@end

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

@property (weak, nonatomic) IBOutlet UIView *webContentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButtonContentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webContentViewHeight;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, weak) HTNewsModel *newsModel;

@end

@implementation HTFilmHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.webContentView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    if ([HTNewsModel canShare]) {
        self.shareButtonContentView.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithNewsModel:(HTNewsModel *)newsModel {
    if (!newsModel) {
        return;
    }
    
    self.newsModel = newsModel;
    self.webContentViewHeight.constant = newsModel.iframe_height;
    [self.webView loadHTMLString:newsModel.iframe baseURL:nil];
    [self.webView showLoadingView];
    
    self.titleLabel.text = newsModel.title;
    self.timeLabel.text = newsModel.time;
    self.viewCountLabel.text = newsModel.view_count;
}

- (IBAction)onShareButtonTapped:(id)sender {
    [self.newsModel share];
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

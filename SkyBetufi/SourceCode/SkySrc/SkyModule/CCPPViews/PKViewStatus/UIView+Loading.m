//
//  UIView+Loading.m
//  Exchange
//
//  Created by Marco on 2017/3/7.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import "UIView+Loading.h"
#import "XJLoadingView.h"
#import "objc/runtime.h"
#import "Masonry.h"

static void * kLoadingViewKey;

@implementation UIView (Loading)

- (void)setLoadingView:(UIView *)loadingView {
    objc_setAssociatedObject(self, &kLoadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)loadingView {
    return objc_getAssociatedObject(self, &kLoadingViewKey);
}

- (void)showLoadingView {
    [self showLoadingViewWithEdge:UIEdgeInsetsZero];
}

- (void)showLoadingViewWithEdge:(UIEdgeInsets)edge {
    if ([self loadingView]) {
        [self bringSubviewToFront:[self loadingView]];
        return;
    }
    
    XJLoadingView *loadingView = [[NSBundle mainBundle] loadNibNamed:@"XJLoadingView" owner:nil options:nil].firstObject;
    [self addSubview:loadingView];
    [self bringSubviewToFront:loadingView];
    [self setLoadingView:loadingView];
    
    [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(edge.left);
        make.right.mas_equalTo(edge.right);
        make.top.mas_equalTo(edge.top);
        make.bottom.mas_equalTo(edge.bottom);
        make.center.mas_equalTo(0);
    }];
}

- (void)hideLoadingView {
    if ([self loadingView]) {
        [[self loadingView] removeFromSuperview];
        [self setLoadingView:nil];
    }
}

@end

//
//  BJWebViewJSBridge.h
//  BenjiaPro
//
//  Created by Marco on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WKWebViewJavascriptBridge.h"

@class BJWebViewController;
@class WKWebView;

@interface BJWebViewJSBridge : NSObject

@property (nonatomic, strong, readonly) WKWebViewJavascriptBridge *jsBridge;

@property (nonatomic, assign) BOOL canGoBack;

- (instancetype)initWithWebView:(WKWebView *)webView viewController:(BJWebViewController *)viewController;

- (void)registerBridges;

@end

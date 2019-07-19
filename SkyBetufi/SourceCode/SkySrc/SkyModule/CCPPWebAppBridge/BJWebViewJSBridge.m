//
//  BJWebViewJSBridge.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJWebViewJSBridge.h"
#import "BJWebViewController.h"
#import "BJUtility.h"
#import "YYModel.h"
#import "BJURINavigator.h"
#import "PPXXBJViewControllerCenter.h"
#import "MJRefreshGenerator.h"

#import <WebKit/WebKit.h>


@interface BJWebViewJSBridge ()

@property (nonatomic, strong) WKWebViewJavascriptBridge *jsBridge;
@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) BJWebViewController *webViewController;

@end

@implementation BJWebViewJSBridge

- (instancetype)initWithWebView:(WKWebView *)webView viewController:(BJWebViewController *)viewController {
    self = [super init];
    if (self) {
        self.webView = webView;
        self.webViewController = viewController;
        self.jsBridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];
        [self.jsBridge setWebViewDelegate:viewController];
        //[WKWebViewJavascriptBridge enableLogging];
        self.canGoBack = YES;
    }
    return self;
}

- (void)registerBridges {
    
    //Device info
    [self.jsBridge registerHandler:@"getDeviceName" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *deviceName = [BJUtility modelName];
        responseCallback([@{@"device" : deviceName} yy_modelToJSONString]);
    }];
    
    [self.jsBridge registerHandler:@"getOSType" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([@{@"os_type" : @"1"} yy_modelToJSONString]);
    }];
    
    [self.jsBridge registerHandler:@"getOSVersion" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *systemVersion = [BJUtility systemVersion];
        responseCallback([@{@"os_version" : systemVersion} yy_modelToJSONString]);
    }];
    
    [self.jsBridge registerHandler:@"getScreenWidth" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *width = @([UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale).stringValue;
        responseCallback([@{@"width" : width} yy_modelToJSONString]);
    }];
    
    [self.jsBridge registerHandler:@"getScreenHeight" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *height = @([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale).stringValue;
        responseCallback([@{@"height" : height} yy_modelToJSONString]);
    }];
    
    [self.jsBridge registerHandler:@"getNetworkState" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"");
    }];
    
    [self.jsBridge registerHandler:@"getCarrierName" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *carrier = [BJUtility carrierName];
        responseCallback([@{@"carrier" : carrier} yy_modelToJSONString]);
    }];
    
    [self.jsBridge registerHandler:@"getAppVersion" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *appVersion = [BJUtility appVersion];
        responseCallback([@{@"version" : appVersion} yy_modelToJSONString]);
    }];
    
    [self.jsBridge registerHandler:@"getUdid" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *udid = [BJUtility idfa];
        responseCallback([@{@"udid" : udid} yy_modelToJSONString]);
    }];
    
    [self.jsBridge registerHandler:@"getDeviceInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *width = @([UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale).stringValue;
        NSString *height = @([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale).stringValue;
        NSDictionary *deviceInfo = @{ @"device_name" : [BJUtility modelName],
                                      @"os_type" : @"1",
                                      @"os_version" : [BJUtility systemVersion],
                                      @"screen_width" :  width,
                                      @"screen_height" : height };
        
        NSString *infoString = [deviceInfo yy_modelToJSONString];
        responseCallback(infoString);
    }];
    
    
    //User info
//    [self.jsBridge registerHandler:@"getUserInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
//        BJUserProfileModel *userProfile = [BJUserInfoStore userStore].userProfile;
//        if (![BJUserInfoStore userStore].isUserLogin || userProfile == nil) {
//            responseCallback(nil);
//        } else {
//            NSDictionary *userInfo = @{@"user_token": [BJUserInfoStore userStore].token,
//                                       @"phone": userProfile.info.phone};
//            responseCallback([userInfo yy_modelToJSONString]);
//        }
//    }];
    
//    [self.jsBridge registerHandler:@"getUserToken" handler:^(id data, WVJBResponseCallback responseCallback) {
//        if (![BJUserInfoStore userStore].isUserLogin) {
//            responseCallback(nil);
//        } else {
//            NSDictionary *userInfo = @{@"user_token": [BJUserInfoStore userStore].token};
//            responseCallback([userInfo yy_modelToJSONString]);
//        }
//    }];
    
    //Navigation
    [self.jsBridge registerHandler:@"backToMainPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSInteger tab = [data[@"tab"] integerValue];
        if (tab > 3) {
            tab = 0;
        }
        [[PPXXBJViewControllerCenter currentViewController].navigationController popToRootViewControllerAnimated:NO];
        [PPXXBJViewControllerCenter mainViewController].selectedIndex = tab;
    }];
    
    [self.jsBridge registerHandler:@"backToLastPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        BOOL animated = YES;
        if (data[@"animated"]) {
            animated = [data[@"animated"] integerValue] == 1;
        }
        [[PPXXBJViewControllerCenter currentViewController].navigationController popViewControllerAnimated:animated];
    }];
    
    [self.jsBridge registerHandler:@"gotoPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *uri = data[@"url"];
        [[BJURINavigator sharedInstance] handleURI:uri];
    }];
    
    __weak typeof(self)weakSelf = self;
    [self.jsBridge registerHandler:@"canGoBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        if ([data[@"result"] integerValue] == -1) {
            weakSelf.canGoBack = NO;
            weakSelf.webView.allowsBackForwardNavigationGestures = NO;
        }
    }];
    
    [self.jsBridge registerHandler:@"canPullToRefresh" handler:^(id data, WVJBResponseCallback responseCallback) {
        if ([data[@"result"] integerValue] == 1) {
            weakSelf.webView.scrollView.mj_header = [MJRefreshGenerator bj_headerWithRefreshingBlock:^{
                [weakSelf.webView reloadFromOrigin];
                [weakSelf.webView.scrollView.mj_header performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
            }];
        } else {
            weakSelf.webView.scrollView.mj_header = nil;
        }
    }];
    
//    [self.jsBridge registerHandler:@"shareAction" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSString *url = data[@"link"];
//        NSString *title = data[@"title"];
//        NSString *desc = data[@"desc"];
//        NSString *imgUrl = data[@"imgUrl"];
//        [[BJShareManager shareManager] shareWebWithUrl:[NSURL URLWithString:url]
//                                                 title:title
//                                                  text:desc
//                                            thumbImage:imgUrl
//                                                inView:[BJViewControllerCenter currentViewController].view
//                                          successBlock:^{
//
//                                              responseCallback([@{@"result" : @1} yy_modelToJSONString]);
//
//                                                }];
//    }];
    
    [self.jsBridge registerHandler:@"pageShareState" handler:^(id data, WVJBResponseCallback responseCallback) {
        BOOL canShare = [data[@"open"] integerValue] == 1;
        [weakSelf.webViewController setShareState:canShare shareParams:data shareSuccessBlock:^{
            responseCallback([@{@"result" : @1} yy_modelToJSONString]);
        }];
    }];
    
//    [self.jsBridge registerHandler:@"refreshUserProfile" handler:^(id data, WVJBResponseCallback responseCallback) {
//        [[[BJUserProfileAPI alloc] initWithDelegate:nil] requestUserProfile];
//    }];
    
//    [self.jsBridge registerHandler:@"eventCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSInteger type = [data[@"type"] integerValue];
//        NSInteger result = [data[@"result"] integerValue];
//        if (type == 1) {
//            NSInteger productId = [data[@"params"][@"product_id"] integerValue];
//            if (result == 1) {
//                [[BJStatisticsManager sharedManager] eventWithType:kInvestEventType action:@"invest_success" content:@(productId).stringValue];
//            } else if (result == 0) {
//                [[BJStatisticsManager sharedManager] eventWithType:kInvestEventType action:@"invest_fail" content:@(productId).stringValue];
//            }
//        } else if (type == 2) {
//            if (result == 1) {
//                [[BJStatisticsManager sharedManager] eventWithType:kRechargeEventType action:@"recharge_success"];
//            } else if (result == 0) {
//                [[BJStatisticsManager sharedManager] eventWithType:kRechargeEventType action:@"recharge_fail"];
//            }
//        }
//        responseCallback(nil);
//    }];
    
}

@end

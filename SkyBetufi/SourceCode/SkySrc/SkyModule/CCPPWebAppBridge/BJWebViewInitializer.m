//
//  BJWebViewInitializer.m
//  BenjiaPro
//
//  Created by Marco on 2017/10/31.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJWebViewInitializer.h"
#import <WebKit/WebKit.h>
#import "BJUtility.h"
#import "BJWebViewCacheHelper.h"

@interface BJWebViewInitializer()

@property (nonatomic, strong) WKWebView *tempUAWebView; //用于第一次修改UA时使用，修改后马上释放

@end

@implementation BJWebViewInitializer

+ (instancetype)sharedInstance {
    static BJWebViewInitializer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BJWebViewInitializer alloc] init];
    });
    return instance;
}

- (void)setupWebViewWithCompletion:(void (^)(void))completion {
    self.tempUAWebView = [[WKWebView alloc] init];
    
    [self.tempUAWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *uaStr = result;
        if ([uaStr containsString:@"zhugeapp/"]) {
            //NSLog(@"");
        } else {
            NSString *zhugeUA = [NSString stringWithFormat:@" zhugeapp/%@", [BJUtility appVersion]];
            NSString *newUserAgent = [uaStr stringByAppendingString:zhugeUA];
            if (newUserAgent) {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : newUserAgent}];                
            } else {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : zhugeUA}];
            }
        }
        //清除所有缓存
        [BJWebViewCacheHelper removeAllCache];
        if (completion) {
            completion();
        }
    }];
    
}

@end

//
//  BJWebViewCacheHelper.m
//  BenjiaPro
//
//  Created by Marco on 2017/7/21.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJWebViewCacheHelper.h"
#import "BJUtility.h"
#import <WebKit/WebKit.h>

@implementation BJWebViewCacheHelper

+ (void)removeAllCache {
    //清除缓存
    if ([BJUtility systemVersion].floatValue >= 9) {
        //NSSet *types = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeCookies, WKWebsiteDataTypeSessionStorage, WKWebsiteDataTypeLocalStorage]];
        //NSLog(@"==========>%@", [WKWebsiteDataStore allWebsiteDataTypes]);
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:[WKWebsiteDataStore allWebsiteDataTypes] modifiedSince:dateFrom completionHandler:^{
            BJLog(@"WKWebsiteDataStore remove cache");
        }];
    } else {
        NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        NSString *cookiesFolder = [libPath stringByAppendingString:@"/Cookies"];
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolder error:&error];
        if (error) {
            BJLog(@"BJWebViewController remove cookies error = %@", error);
        }
    }
}

@end

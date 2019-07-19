//
//  BJViewControllerCenter.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "PPXXBJViewControllerCenter.h"

@implementation PPXXBJViewControllerCenter

+ (PPXXBJMainViewController *)mainViewController {
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows) {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    if ([topWindow.rootViewController isKindOfClass:[PPXXBJMainViewController class]]) {
        return (PPXXBJMainViewController *)topWindow.rootViewController;
    }
    return nil;
}

+ (UIViewController *)currentViewController {
    __block UIViewController *result = nil;
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows) {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    
    NSArray *windowSubviews = [topWindow subviews];
    
    [windowSubviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
         UIView *rootView = obj;
         
         if ([NSStringFromClass([rootView class]) isEqualToString:@"UITransitionView"]) {
             
             NSArray *aSubViews = rootView.subviews;
             
             [aSubViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                 UIView *tempView = obj;
                 
                 id nextResponder = [tempView nextResponder];
                 
                 if ([nextResponder isKindOfClass:[UIViewController class]]) {
                     result = nextResponder;
                     *stop = YES;
                 }
             }];
             *stop = YES;
         } else {
             
             id nextResponder = [rootView nextResponder];
             
             if ([nextResponder isKindOfClass:[UIViewController class]]) {
                 result = nextResponder;
                 *stop = YES;
             }
         }
     }];
    
    if (result == nil && [topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil) {
        result = topWindow.rootViewController;
    }
    
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    
    if ([result isKindOfClass:[PPXXBJMainViewController class]]) {
        UIViewController *tVc = [(PPXXBJMainViewController *)result selectedViewController];
        if ([tVc isKindOfClass:[UINavigationController class]]) {
            result = [(UINavigationController *)tVc topViewController];
        } else {
            result = tVc;
        }
    }
    
    while (result.presentedViewController) {
        if ([result.presentedViewController isKindOfClass:[UINavigationController class]]) {
            result = [((UINavigationController *)result.presentedViewController) topViewController];
        } else {
            result = result.presentedViewController;
        }
    }
    
    return result;
}


@end

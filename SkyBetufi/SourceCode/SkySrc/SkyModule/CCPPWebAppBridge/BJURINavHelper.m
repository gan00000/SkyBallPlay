//
//  BJURINavHelper.m
//  BenjiaPro
//
//  Created by Marco on 2017/7/3.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJURINavHelper.h"
#import "BJWebViewController.h"
#import "PPXXBJViewControllerCenter.h"
#import "BJURINavigator.h"

@implementation BJURINavHelper

+ (BOOL)canHandleURI:(NSString *)uri {
    if ([[BJURINavigator sharedInstance] canHandleURI:uri]) {
        return YES;
    }
    if ([uri hasPrefix:@"http://"] || [uri hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}

+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController {
    BOOL result = [[BJURINavigator sharedInstance] handleURI:uri];
    if (!result) {
        BJWebViewController *webVC = [[BJWebViewController alloc] initWithAddress:uri];
        UINavigationController *navCon = nil;
        if (!viewController) {
            navCon = [PPXXBJViewControllerCenter currentViewController].navigationController;
        } else if ([viewController isKindOfClass:[UINavigationController class]]) {
            navCon = (UINavigationController *)viewController;
        } else {
            navCon = viewController.navigationController;
        }
        [navCon pushViewController:webVC animated:YES];
    }
}

@end

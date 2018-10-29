//
//  AppDelegate.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/22.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>

#import "AFNetworkReachabilityManager.h"
#import "BJLaunchViewController.h"
#import "UIView+Toast.h"

#define UM_APP_KEY @"5bd67116f1f556f834000081"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UMConfigure initWithAppkey:UM_APP_KEY channel:@"App Store"];
    [self sdk_setUpNetworkReachability];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    BJLaunchViewController *rootVc = [[BJLaunchViewController alloc] init];
    self.window.rootViewController = rootVc;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AFNetworkingReachabilityDidChangeNotification
                                                  object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appNetworkChangedNotification:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - SDK init
- (void)sdk_setUpNetworkReachability {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appNetworkChangedNotification:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
}

#pragma mark - Notifications
- (void)appNetworkChangedNotification:(NSNotification *)notification {
    AFNetworkReachabilityStatus status = [notification.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue];
    if (status == AFNetworkReachabilityStatusNotReachable) {
        [self.window showToast:@"未连接到网络！" duration:3];
    }
}

@end

//
//  AppDelegate.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/22.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>

#import "AFNetworkReachabilityManager.h"
#import "BJLaunchViewController.h"
#import "UIView+Toast.h"

#define UM_APP_KEY @"5bd67116f1f556f834000081"
#define FB_APP_ID  @"479868032525276"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UMConfigure initWithAppkey:UM_APP_KEY channel:@"App Store"];
    [UMConfigure setLogEnabled:YES];
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook
                                          appKey:FB_APP_ID
                                       appSecret:nil
                                     redirectURL:@"http://www.ballgametime.com"];
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_FaceBookMessenger]) {
        [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_FaceBookMessenger];
    }
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Facebook]) {
        [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_Facebook];
    }
    
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Line]) {
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Line
                                              appKey:nil appSecret:nil
                                         redirectURL:@"http://www.ballgametime.com"];
    }
    
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

#pragma mark - share
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end

//
//  BJDeviceAuthorizeCheckUtility.m
//  BenjiaPro
//
//  Created by JZ_Stone on 2017/7/6.
//  Copyright © 2017年 Benjia. All Authorize reserved.
//

#import "BJDeviceAuthorizeCheckUtility.h"
#import <UserNotifications/UserNotifications.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation BJDeviceAuthorizeCheckUtility

#pragma mark - 打开系统设置
+ (void)openSystemSettingForCurrentApp {
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - 检查系统设置
// 通知
+ (void)checkForAPNsAuthorizeWithBlock:(void (^) (BOOL result))block
{
    if (!block) {
        return;
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(settings.authorizationStatus == UNAuthorizationStatusAuthorized);
        });
    }];
#elif __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    block([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]);
#else
    UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    block(type != UIRemoteNotificationTypeNone);
#endif
}

// 摄像头
+ (void)checkForCameraAuthorizeWithBlock:(void (^) (BOOL result))block
{
    if (!block) {
        return;
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(granted);
            });
        }];
    } else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        block(NO);
    } else {
        block(YES);
    }
#endif
}

// 相册
+ (void)checkForAlbumAuthorizeWithBlock:(void (^) (BOOL result))block
{
    if (!block) {
        return;
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(status);
            });
        }];
    } else {
        block(authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied);
    }
#else
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if (authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied) {
        block(NO);
    } else {
        block(YES);
    }
#endif
}

// 麦克风
+ (void)checkForMicrophoeAuthorizeWithBlock:(void (^) (BOOL result))block
{
    if (!block) {
        return;
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
    if (permissionStatus == AVAudioSessionRecordPermissionUndetermined) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(granted);
            });
        }];
    } else if (permissionStatus == AVAudioSessionRecordPermissionDenied) {
        block(NO);
    } else {
        block(YES);
    }
#else
    AVAudioSession *avSession = [AVAudioSession sharedInstance];
    if([avSession respondsToSelector:@selector(requestRecordPermission:)])
    {
        [avSession requestRecordPermission:^(BOOL available) {
            block(available);
        }];
    } else {
        block(NO);
    }
#endif
}

// 定位
+ (void)checkForLocationServicesAuthorizeWithBlock:(void (^) (BOOL result))block
{
    if (!block) {
        return;
    }
    if (![CLLocationManager locationServicesEnabled] ||
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted ||
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied ) {
        block(NO);
        return;
    }
    block(YES);
}

@end

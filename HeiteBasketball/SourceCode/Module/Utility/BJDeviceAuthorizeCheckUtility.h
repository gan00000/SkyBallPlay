//
//  BJDeviceAuthorizeCheckUtility.h
//  BenjiaPro
//
//  Created by JZ_Stone on 2017/7/6.
//  Copyright © 2017年 Benjia. All Authorize reserved.
//

#import <Foundation/Foundation.h>

@interface BJDeviceAuthorizeCheckUtility : NSObject

#pragma mark - 打开系统设置
/*
 *  打开查看当前APP的所有系统设置项
 */
+ (void)openSystemSettingForCurrentApp;

#pragma mark - 检查系统设置
/*
 *  检查当前app是否开启通知权限
 */
+ (void)checkForAPNsAuthorizeWithBlock:(void (^) (BOOL result))block;

/**
 *  检查当前app是否有调用摄像头的权限
 */
+ (void)checkForCameraAuthorizeWithBlock:(void (^) (BOOL result))block;

/**
 *  检查当前app是否有访问相册的权限
 */
+ (void)checkForAlbumAuthorizeWithBlock:(void (^) (BOOL result))block;

/**
 *  检查app是否有录音权限
 */
+ (void)checkForMicrophoeAuthorizeWithBlock:(void (^) (BOOL result))block;

/**
 *  检查当前app是否有启用定位服务的权限
 */
+ (void)checkForLocationServicesAuthorizeWithBlock:(void (^) (BOOL result))block;

@end










//
//  BJTouchIDUtility.m
//  BenjiaPro
//
//  Created by Marco on 2017/8/31.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJLocalAuthUtility.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "BJUtility.h"

@interface BJLocalAuthUtility ()

@property (nonatomic, strong) LAContext *context;

@end

@implementation BJLocalAuthUtility

+ (instancetype)shareInstance {
    static BJLocalAuthUtility *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BJLocalAuthUtility alloc] init];
        //instance.context = [[LAContext alloc] init];
    });
    return instance;
}

/*
- (BOOL)hasTouchID {
    NSString *modelName = [BJUtility modelName];
    if ([modelName hasPrefix:@"iPhone"]) {
        NSString *prefix = [modelName componentsSeparatedByString:@","][0];
        NSInteger modelNum = [[prefix stringByReplacingOccurrencesOfString:@"iPhone" withString:@""] integerValue];
        if (modelNum >= 6) {
            return YES;
        }
    } else if ([modelName hasPrefix:@"iPad"]) {
        NSString *prefix = [modelName componentsSeparatedByString:@","][0];
        NSInteger modelNum = [[prefix stringByReplacingOccurrencesOfString:@"iPad" withString:@""] integerValue];
        if (modelNum >= 3) {
            return YES;
        }
    }
    return NO;
}
 */

- (BOOL)canUseBiometryAuth {
    NSError *error = nil;
    if (!self.context) {
        self.context = [[LAContext alloc] init];
    }
    BOOL result = [self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (error) {
        if (error.code == LAErrorTouchIDLockout) { //支持TouchID，但错误次数超过限制了
            return YES;
        }
    }
    return result;
}

- (BOOL)isSupportFaceID {
    if (!self.context) {
        self.context = [[LAContext alloc] init];
    }
    if (@available(iOS 11.0, *)) {
        return self.context.biometryType == LABiometryTypeFaceID;
    }
    return NO;
}

- (void)evaluateTouchIDWithBlock:(void (^)(BOOL, NSError *))block {
    self.context = [[LAContext alloc] init];
    NSString *reason = [self isSupportFaceID] ? @"通过Face ID验证" : @"通过Home键验证已有手机指纹";
    self.context.localizedFallbackTitle = @"";
    [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(success, error);
            });
        }
    }];
}

- (void)invalidate {
    if (@available(iOS 9.0, *)) {
        [self.context invalidate];
        self.context = nil;
    }
}


@end

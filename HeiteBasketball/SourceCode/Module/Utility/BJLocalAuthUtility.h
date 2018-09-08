//
//  BJTouchIDUtility.h
//  BenjiaPro
//
//  Created by Marco on 2017/8/31.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface BJLocalAuthUtility : NSObject

+ (instancetype)shareInstance;

- (BOOL)canUseBiometryAuth;
- (BOOL)isSupportFaceID;
- (void)evaluateTouchIDWithBlock:(void(^)(BOOL success, NSError *error))block;
- (void)invalidate;

@end

//
//  HTUserManager.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/3/31.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

extern const NSString * kUserLogStatusChagneNotice;

@interface HTUserManager : NSObject

// 判断用是否登录
+ (BOOL)isUserLogin;
// 獲取用戶信息
+ (HTUserInfoModel *)userInfo;
// token
+ (NSString *)userToken;
// 推送deviceToken
+ (NSString *)deviceToken;
+ (void)saveDeviceToken:(NSString *)deviceToken;

// 执行用户登录
+ (void)doUserLogin;
+ (void)doUserLogout;
+ (void)refreshUserInfo;

@end

NS_ASSUME_NONNULL_END

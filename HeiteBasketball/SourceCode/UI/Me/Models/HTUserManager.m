//
//  HTUserManager.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/3/31.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTUserManager.h"
#import <UMShare/UMShare.h>
#import <LineSDK/LineSDK.h>
#import "HTLoginAlertView.h"
#import "HTLoginRequest.h"
#import "DRSandBoxManager.h"

const NSString * kUserLogStatusChagneNotice = @"UserLogStatusChagneNotice";
#define kUserTokenKey @"userToken"
#define kDeviceTokenKey @"deviceToken"

@interface HTUserManager () <LineSDKLoginDelegate>

@property (nonatomic, strong) HTUserInfoModel *userInfoModel;

@end

@implementation HTUserManager

- (instancetype)init {
    self = [super init];
    if (self) {
        if ([HTUserManager isUserLogin]) {
            NSData *data = [NSData dataWithContentsOfFile:[HTUserManager userInfoPath]];
            self.userInfoModel = [HTUserInfoModel yy_modelWithJSON:data];
        }
    }
    return self;
}

+ (instancetype)manager {
    static HTUserManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HTUserManager alloc] init];
    });
    return manager;
}

+ (BOOL)isUserLogin {
    return [HTUserManager userToken].length > 0;
}

+ (HTUserInfoModel *)userInfo {
    return [HTUserManager manager].userInfoModel;
}

// token
+ (NSString *)userToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserTokenKey];
}

+ (void)saveUserToken:(NSString *)userToken {
    [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:kUserTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 推送deviceToken
+ (NSString *)deviceToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceTokenKey];
}

+ (void)saveDeviceToken:(NSString *)deviceToken {
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:kDeviceTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 执行用户登录
+ (void)doUserLogin {
    [HTLoginAlertView showLoginAlertViewWithSelectBlock:^(HTLoginPlatform platform) {
        HTUserManager *manager = [HTUserManager manager];
        if (platform == HTLoginPlatformFB) {
            [manager getAuthWithUserInfoFromFacebook];
        } else if (platform == HTLoginPlatformLine) {
            [manager getAuthWithUserInfoFromLine];
        }
    }];
}

+ (void)doUserLogout {
    [self saveUserToken:nil];
    [DRSandBoxManager deleteFileAtPath:[self userInfoPath] doneBlock:^(NSString * _Nonnull filePath, BOOL success, NSError * _Nonnull error) {
        BJLog(@"用戶信息刪除 %d", success);
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogStatusChagneNotice object:nil];
}

#pragma mark - Facebook Authory
- (void)getAuthWithUserInfoFromFacebook {
    kWeakSelf
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Facebook currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
        } else {
            UMSocialUserInfoResponse *resp = result;
            [weakSelf doLoginRequesWithAccessToken:resp.accessToken sns:1];
            // 授权信息
            NSLog(@"Facebook uid: %@", resp.uid);
            NSLog(@"Facebook accessToken: %@", resp.accessToken);
            NSLog(@"Facebook expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Facebook name: %@", resp.name);
            // 第三方平台SDK源数据
            NSLog(@"Facebook originalResponse: %@", resp.originalResponse);
        }
    }];
}

#pragma mark - Line Authory
- (void)getAuthWithUserInfoFromLine {
    [LineSDKLogin sharedInstance].delegate = self;
    [[LineSDKLogin sharedInstance] startLogin];
}

- (void)didLogin:(LineSDKLogin *)login
      credential:(nullable LineSDKCredential *)credential
         profile:(nullable LineSDKProfile *)profile
           error:(nullable NSError *)error {
    [self doLoginRequesWithAccessToken:credential.accessToken.accessToken sns:2];
}

#pragma mark - request
- (void)doLoginRequesWithAccessToken:(NSString *)accessToken sns:(NSInteger)sns {
    [HTLoginRequest doLoginRequestWithAccessToken:accessToken sns:sns successBlock:^(NSString * _Nonnull userToken) {
        [HTUserManager saveUserToken:userToken];
        [HTUserManager refreshUserInfo];
    } failBlock:^(BJError *error) {
        BJLog(@"登錄失敗");
    }];
}

+ (void)refreshUserInfo {
    [HTLoginRequest requestUserInfoWithSuccessBlock:^(NSDictionary * _Nonnull userInfo) {
        HTUserManager *manager = [HTUserManager manager];
        manager.userInfoModel = [HTUserInfoModel yy_modelWithJSON:userInfo];
        NSData *data = [userInfo yy_modelToJSONData];
        [data writeToFile:[HTUserManager userInfoPath] atomically:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogStatusChagneNotice object:nil];
    } failBlock:^(BJError *error) {
        BJLog(@"獲取用戶信息失敗");
    }];
}

#pragma mark - util
+ (NSString *)userInfoPath {
    return [NSString stringWithFormat:@"%@/userInfo.json", [DRSandBoxManager getDocumentPath]];
}

@end

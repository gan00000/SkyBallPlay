//
//  HTUserManager.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/3/31.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTUserManager.h"
#import <LineSDK/LineSDK.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "HTLoginAlertView.h"
#import "HTUserRequest.h"
#import "DRSandBoxManager.h"

const NSString * kUserLogStatusChagneNotice = @"UserLogStatusChagneNotice";
#define kUserTokenKey @"userToken"
#define kDeviceTokenKey @"deviceToken"

@interface HTUserManager () <LineSDKLoginDelegate>

@property (nonatomic, strong) HTUserInfoModel *userInfoModel;
@property (nonatomic, strong) FBSDKLoginManager *skarg_fbLoginManager;

@end

@implementation HTUserManager

- (instancetype)init {
    self = [super init];
    if (self) {
//        self.appInView = YES;
        if ([HTUserManager skarg_isUserLogin]) {
            NSData *data = [NSData dataWithContentsOfFile:[HTUserManager skarguserInfoPath]];
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

+ (BOOL)skarg_isUserLogin {
    return [HTUserManager skarg_userToken].length > 0;
}

+ (HTUserInfoModel *)skarg_userInfo {
    return [HTUserManager manager].userInfoModel;
}

+ (void)saveUserInfo:(NSDictionary *)userInfo {
    HTUserManager *manager = [HTUserManager manager];
    manager.userInfoModel = [HTUserInfoModel yy_modelWithJSON:userInfo];
    NSData *data = [userInfo yy_modelToJSONData];
    [data writeToFile:[HTUserManager skarguserInfoPath] atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogStatusChagneNotice object:nil];
}

// token
+ (NSString *)skarg_userToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserTokenKey];
}

+ (void)saveUserToken:(NSString *)userToken {
    [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:kUserTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 推送deviceToken
+ (NSString *)skarg_deviceToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceTokenKey];
}

+ (void)skarg_saveDeviceToken:(NSString *)deviceToken {
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:kDeviceTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 执行用户登录
+ (void)skarg_doUserLogin {
    [HTLoginAlertView skargshowLoginAlertViewWithSelectBlock:^(HTLoginPlatform platform) {
        HTUserManager *manager = [HTUserManager manager];
        if (platform == HTLoginPlatformFB) {
            [manager getAuthWithUserInfoFromFacebook];
        } else if (platform == HTLoginPlatformLine) {
            [manager getAuthWithUserInfoFromLine];
        }
    }];
}

+ (void)skarg_doUserLogout {
    [self saveUserToken:nil];
    [DRSandBoxManager skargdeleteFileAtPath:[self skarguserInfoPath] doneBlock:^(NSString * _Nonnull filePath, BOOL success, NSError * _Nonnull error) {
        BJLog(@"用戶信息刪除 %d", success);
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogStatusChagneNotice object:nil];
    [[HTUserManager manager].skarg_fbLoginManager logOut];
}

#pragma mark - Facebook Authory
- (void)getAuthWithUserInfoFromFacebook {
    kWeakSelf
    [self.skarg_fbLoginManager logInWithReadPermissions: @[@"public_profile",@"email"] fromViewController:[PPXXBJViewControllerCenter currentViewController] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             [kWindow showToast:@"登錄失敗"];
         } else if (result.isCancelled) {
             [kWindow showToast:@"取消登錄"];
         } else {
             [weakSelf doLoginRequesWithAccessToken:result.token.tokenString sns:1];
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
    [HTUserRequest skargdoLoginRequestWithAccessToken:accessToken sns:sns successBlock:^(NSString * _Nonnull userToken) {
        [HTUserManager saveUserToken:userToken];
        [HTUserManager skarg_refreshUserInfoWithSuccessBlock:nil];
    } failBlock:^(BJError *error) {
        BJLog(@"登錄失敗");
    }];
}

+ (void)skarg_refreshUserInfoWithSuccessBlock:(dispatch_block_t)block {
    [HTUserRequest skargrequestUserInfoWithSuccessBlock:^(NSDictionary * _Nonnull userInfo) {
        [self saveUserInfo:userInfo];
        if (block) {
            block();
        }
    } failBlock:^(BJError *error) {
        BJLog(@"獲取用戶信息失敗");
    }];
}

#pragma mark - util
+ (NSString *)skarguserInfoPath {
    return [NSString stringWithFormat:@"%@/userInfo.json", [DRSandBoxManager skarggetDocumentPath]];
}

+ (void)skargcameraDenied {
    [self skarg_showAlertWithTitle:@"相機權限未開啟" message:@"檢測到相機被禁用，無法拍照" cancelButton:@"取消" confirmButton:@"去開啟" confirmBlock:^{
        [self skarg_goSystemSettingCenter];
    }];
}

+ (void)skargphotoAlbumDenied {
    [self skarg_showAlertWithTitle:@"相冊權限未開啟" message:@"檢測到相冊被禁用，無法查看照片" cancelButton:@"取消" confirmButton:@"去開啟" confirmBlock:^{
        [self skarg_goSystemSettingCenter];
    }];
}

+ (void)skarg_showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton confirmButton:(NSString *)confirmButton confirmBlock:(dispatch_block_t)confirmBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    if (confirmButton) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmBlock) {
                confirmBlock();
            }
        }];
        [alert addAction:confirmAction];
    }
    [[PPXXBJViewControllerCenter currentViewController] presentViewController:alert animated:YES completion:nil];
}

+ (void)skarg_goSystemSettingCenter {
    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:appSettings];
}

- (FBSDKLoginManager *)skarg_fbLoginManager {
    if (!_skarg_fbLoginManager) {
        _skarg_fbLoginManager = [[FBSDKLoginManager alloc] init];
    }
    return _skarg_fbLoginManager;
}

@end

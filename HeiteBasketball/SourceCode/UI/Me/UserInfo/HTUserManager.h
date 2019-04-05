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

@property (nonatomic, strong) HTUserInfoModel *userInfo;

+ (BOOL)isUserLogin;

@end

NS_ASSUME_NONNULL_END

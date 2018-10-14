//
//  HTDataHomeRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/11.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJHTTPServiceEngine.h"
#import "HTDataHomeInfoModel.h"

@interface HTDataHomeRequest : NSObject

+ (void)requestWithType:(NSInteger)type successBlock:(void(^)(HTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock;

/// type 1:队员 2:球队
+ (void)requestMoreDataWithType:(NSInteger)type
                        subType:(NSString *)subType
                   successBlock:(void (^)(NSArray<HTDataHomeModel *> *rankList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;

@end

//
//  HTDataAllRankRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/19.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJHTTPServiceEngine.h"
#import "HTDataTeamRankModel.h"
#import "HTDataPlayerRankModel.h"

@interface HTDataAllRankRequest : NSObject

+ (void)skargrequestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<HTDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<HTDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock;

@end

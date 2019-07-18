//
//  HTDataAllRankRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/19.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataAllRankRequest.h"

@implementation HTDataAllRankRequest

+ (void)requestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<HTDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock {
    NSDictionary *params = @{
                             @"type": type,
                             @"sort_by": @"desc"
                             };
    
    [BJHTTPServiceEngine getRequestWithFunctionPath:API_TEAM_RANK_ALL params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *allTeamRankList = [NSArray yy_modelArrayWithClass:[HTDataTeamRankModel class] json:responseData[@"teams_rank"]];
            successBlock(allTeamRankList);
        }
    } errorBlock:errorBlock];
}

+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<HTDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock {
    NSDictionary *params = @{
                             @"type": type,
                             @"sort_by": @"desc"
                             };
    
    [BJHTTPServiceEngine getRequestWithFunctionPath:API_PLAYER_RANK_ALL params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *allTeamRankList = [NSArray yy_modelArrayWithClass:[HTDataPlayerRankModel class] json:responseData[@"players_rank"]];
            successBlock(allTeamRankList);
        }
    } errorBlock:errorBlock];
}

@end

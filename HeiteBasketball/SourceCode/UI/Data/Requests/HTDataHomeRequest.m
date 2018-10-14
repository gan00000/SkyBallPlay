//
//  HTDataHomeRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/11.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataHomeRequest.h"

@implementation HTDataHomeRequest

+ (void)requestWithType:(NSInteger)type successBlock:(void(^)(HTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock {
    [BJHTTPServiceEngine getRequestWithFunctionPath:type==1?API_PLAYER_RANK:API_TEAM_RANK params:nil successBlock:^(id responseData) {
        if (successBlock) {
            NSString *key = type==1?@"players":@"teams";
            HTDataHomeInfoModel *infoModel = [HTDataHomeInfoModel yy_modelWithJSON:responseData[key]];
            successBlock(infoModel);
        }
    } errorBlock:errorBlock];
}

+ (void)requestMoreDataWithType:(NSInteger)type
                        subType:(NSString *)subType
                   successBlock:(void (^)(NSArray<HTDataHomeModel *> *rankList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    NSDictionary *params = @{
                             @"type": subType,
                             @"sort_by": @"desc"
                             };
    [BJHTTPServiceEngine getRequestWithFunctionPath:type==1?API_PLAYER_RANK_ALL:API_TEAM_RANK_ALL params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSString *key = type==1?@"players_rank":@"teams_rank";
            NSArray<HTDataHomeModel *> *rankList = [NSArray yy_modelArrayWithClass:[HTDataHomeModel class] json:responseData[key]];
            successBlock(rankList);
        }
    } errorBlock:errorBlock];
}

@end

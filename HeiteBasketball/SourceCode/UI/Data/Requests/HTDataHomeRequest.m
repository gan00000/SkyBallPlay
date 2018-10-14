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
    NSDictionary *params = @{
                             @"fun": type==1?@"get_player_rank":@"get_team_rank"
                             };
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_DATA_HOME params:params successBlock:^(id responseData) {
        if (successBlock) {
            HTDataHomeInfoModel *infoModel = [HTDataHomeInfoModel yy_modelWithJSON:responseData];
            successBlock(infoModel);
        }
    } errorBlock:errorBlock];
}

+ (void)requestMoreDataWithType:(NSInteger)type
                        subType:(NSString *)subType
                   successBlock:(void (^)(NSArray<HTDataHomeModel *> *rankList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    NSDictionary *params = @{
                             @"fun": type==1?@"get_player_rank_all":@"get_team_rank_all",
                             @"type": subType,
                             @"sort": @"desc"
                             };
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_DATA_HOME params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSArray<HTDataHomeModel *> *rankList = [NSArray yy_modelArrayWithClass:[HTDataHomeModel class] json:responseData];
            successBlock(rankList);
        }
    } errorBlock:errorBlock];
}

@end

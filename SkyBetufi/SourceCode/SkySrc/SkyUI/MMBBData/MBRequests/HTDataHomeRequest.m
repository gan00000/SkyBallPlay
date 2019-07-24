//
//  HTDataHomeRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/11.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataHomeRequest.h"

@implementation HTDataHomeRequest

+ (void)skargrequestWithType:(NSInteger)type successBlock:(void(^)(HTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock {
    [BJHTTPServiceEngine getRequestWithFunctionPath:type==1?API_PLAYER_RANK:API_TEAM_RANK params:nil successBlock:^(id responseData) {
        if (successBlock) {
            NSString *key = type==1?@"players":@"teams";
            HTDataHomeInfoModel *infoModel = [HTDataHomeInfoModel yy_modelWithJSON:responseData[key]];
            successBlock(infoModel);
        }
    } errorBlock:errorBlock];
}

@end

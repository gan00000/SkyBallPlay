//
//  HTRankEastWestRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTRankEastWestRequest.h"

@implementation HTRankEastWestRequest

+ (void)skargrequestWithSuccessBlock:(void(^)(HTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [BJHTTPServiceEngine skarg_getRequestWithFunctionPath:API_RANK_EAST_WEST params:nil successBlock:^(id responseData) {
        HTRankEastWestModel *eastWestModel = [HTRankEastWestModel yy_modelWithJSON:responseData];
        if (successBlock) {
            successBlock(eastWestModel);
        }
    } errorBlock:errorBlock];
}

@end

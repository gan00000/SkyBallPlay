//
//  HTRankZoneRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTRankZoneRequest.h"

@implementation HTRankZoneRequest

+ (void)requestWithSuccessBlock:(void(^)(HTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [BJHTTPServiceEngine getRequestWithFunctionPath:API_RANK_ZONE params:nil successBlock:^(id responseData) {
        if (successBlock) {
            HTRankZoneModel *zoneModel = [HTRankZoneModel yy_modelWithJSON:responseData];
            successBlock(zoneModel);
        }
    } errorBlock:errorBlock];
}

@end

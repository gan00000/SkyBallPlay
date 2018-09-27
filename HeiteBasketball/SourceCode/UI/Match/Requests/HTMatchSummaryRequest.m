//
//  HTMatchSummaryRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/22.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchSummaryRequest.h"

@implementation HTMatchSummaryRequest

+ (void)requestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(void))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock {
    [BJHTTPServiceEngine getRequestWithFunctionPath:API_MATCH_SUMMARY params:@{@"game_id":game_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:errorBlock];
}

@end

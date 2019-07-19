//
//  HTMatchLiveFeedRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/22.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchLiveFeedRequest.h"

@implementation HTMatchLiveFeedRequest

+ (void)requestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<HTMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock {
    [BJHTTPServiceEngine getRequestWithFunctionPath:API_MATCH_LIVE_FEED params:@{@"game_id":game_id} successBlock:^(id responseData) {
        NSMutableArray *feedList = [NSMutableArray array];
        NSArray *data = responseData[@"live_feed"];
        if ([data isKindOfClass:[NSArray class]] && data.count > 0) {
            for (NSArray *q in data) {
                NSArray *quarter = [NSArray yy_modelArrayWithClass:[HTMatchLiveFeedModel class] json:q];
                [feedList addObjectsFromArray:quarter];
            }
        }        
        if (successBlock) {
            successBlock(feedList);
        }
    } errorBlock:errorBlock];
}

@end

//
//  HTNewsTopRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsTopRequest.h"

@implementation HTNewsTopRequest

+ (void)skargrequestWithSuccessBlock:(void(^)(NSArray<HTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [BJHTTPServiceEngine skarg_getRequestWithFunctionPath:API_NEWS_TOP params:nil successBlock:^(id responseData) {
        NSArray *newsList = [NSArray yy_modelArrayWithClass:[HTNewsModel class] json:responseData[@"posts"]];
        if (successBlock) {
            successBlock(newsList);
        }
    } errorBlock:errorBlock];
}

@end

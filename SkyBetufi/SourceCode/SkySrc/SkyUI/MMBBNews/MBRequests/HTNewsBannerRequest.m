//
//  HTNewsBannerRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsBannerRequest.h"

@implementation HTNewsBannerRequest

+ (void)skargrequestWithSuccessBlock:(void(^)(NSArray<HTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    
    [BJHTTPServiceEngine skarg_getRequestWithFunctionPath:API_NEWS_BANNER params:nil successBlock:^(id responseData) {
        NSArray *arr = [NSArray yy_modelArrayWithClass:[HTNewsModel class] json:responseData[@"topslideposts"][@"posts"]];
        if (successBlock) {
            successBlock(arr);
        }
    } errorBlock:errorBlock];
}

@end

//
//  HTNewsHomeRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJHTTPServiceEngine.h"
#import "HTNewsModel.h"

@interface HTNewsHomeRequest : NSObject

@property (nonatomic, assign) BOOL hasMore;

- (void)requestWithSuccessBlock:(void(^)(NSArray<HTNewsModel *> *newsList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;

- (void)loadNextPageWithSuccessBlock:(void(^)(NSArray<HTNewsModel *> *newsList))successBlock
                          errorBlock:(BJServiceErrorBlock)errorBlock;

@end

//
//  HTNewsBannerRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJHTTPServiceEngine.h"
#import "HTNewsModel.h"

@interface HTNewsBannerRequest : NSObject

+ (void)requestWithSuccessBlock:(void(^)(NSArray<HTNewsModel*> *bannerList))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;

@end

//
//  HTRankEastWestRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJHTTPServiceEngine.h"
#import "HTRankEastWestModel.h"

@interface HTRankEastWestRequest : NSObject

+ (void)requestWithSuccessBlock:(void(^)(HTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;

@end

//
//  HTMatchSummaryRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/22.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJHTTPServiceEngine.h"

@interface HTMatchSummaryRequest : NSObject

+ (void)requestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(void))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock;

@end

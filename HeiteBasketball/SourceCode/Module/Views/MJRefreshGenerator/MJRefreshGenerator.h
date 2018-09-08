//
//  MJRefreshGenerator.h
//  Exchange
//
//  Created by Marco on 2017/2/22.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"

@interface MJRefreshGenerator : NSObject

+ (MJRefreshStateHeader *)bj_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
+ (MJRefreshAutoStateFooter *)bj_foorterWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

@end

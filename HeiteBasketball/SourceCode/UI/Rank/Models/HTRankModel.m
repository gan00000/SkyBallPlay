//
//  HTRankModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTRankModel.h"

@implementation HTRankModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"rank_id": @"id"
             };
}

@end
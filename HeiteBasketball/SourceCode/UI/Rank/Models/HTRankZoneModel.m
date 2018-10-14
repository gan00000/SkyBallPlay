//
//  HTRankZoneModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTRankZoneModel.h"

@implementation HTRankZoneModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"EasternAtlantic": [HTRankModel class],
             @"EasternCentral": [HTRankModel class],
             @"EasternSoutheast": [HTRankModel class],
             @"WesternNorthwest": [HTRankModel class],
             @"WesternPacific": [HTRankModel class],
             @"WesternSouthwest": [HTRankModel class]
             };
}

@end

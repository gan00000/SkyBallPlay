//
//  HTDataHomeInfoModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/12.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataHomeInfoModel.h"

@implementation HTDataHomeInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pts": [HTDataHomeModel class],
             @"reb": [HTDataHomeModel class],
             @"ast": [HTDataHomeModel class],
             @"stl": [HTDataHomeModel class],
             @"blk": [HTDataHomeModel class],
             @"turnover": [HTDataHomeModel class]
             };
}

@end

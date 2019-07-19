//
//  HTRankEastWestModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTRankEastWestModel.h"

@implementation HTRankEastWestModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"Eastern": [HTRankModel class],
             @"Western": [HTRankModel class]
             };
}

- (void)setEastern:(NSArray<HTRankModel *> *)Eastern {
    _Eastern = [Eastern sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        HTRankModel *model1 = obj1;
        HTRankModel *model2 = obj2;
        
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}

- (void)setWestern:(NSArray<HTRankModel *> *)Western {
    _Western = [Western sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        HTRankModel *model1 = obj1;
        HTRankModel *model2 = obj2;
        
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}

@end

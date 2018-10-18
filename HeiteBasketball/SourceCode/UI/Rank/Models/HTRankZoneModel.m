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

- (void)setEasternAtlantic:(NSArray<HTRankModel *> *)EasternAtlantic {
    _EasternAtlantic = [EasternAtlantic sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        HTRankModel *model1 = obj1;
        HTRankModel *model2 = obj2;
        
        if (model1.winRate > model2.winRate) {
            return NSOrderedDescending;
        } else if (model1.winRate == model2.winRate) {
            return NSOrderedSame;
        }
        return NSOrderedAscending;
    }];
}

- (void)setEasternCentral:(NSArray<HTRankModel *> *)EasternCentral {
    _EasternCentral = [EasternCentral sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        HTRankModel *model1 = obj1;
        HTRankModel *model2 = obj2;
        
        if (model1.winRate > model2.winRate) {
            return NSOrderedAscending;
        } else if (model1.winRate == model2.winRate) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}

- (void)setEasternSoutheast:(NSArray<HTRankModel *> *)EasternSoutheast {
    _EasternSoutheast = [EasternSoutheast sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        HTRankModel *model1 = obj1;
        HTRankModel *model2 = obj2;
        
        if (model1.winRate > model2.winRate) {
            return NSOrderedAscending;
        } else if (model1.winRate == model2.winRate) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}

- (void)setWesternPacific:(NSArray<HTRankModel *> *)WesternPacific {
    _WesternPacific = [WesternPacific sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        HTRankModel *model1 = obj1;
        HTRankModel *model2 = obj2;
        
        if (model1.winRate > model2.winRate) {
            return NSOrderedAscending;
        } else if (model1.winRate == model2.winRate) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}

- (void)setWesternSouthwest:(NSArray<HTRankModel *> *)WesternSouthwest {
    _WesternSouthwest = [WesternSouthwest sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        HTRankModel *model1 = obj1;
        HTRankModel *model2 = obj2;
        
        if (model1.winRate > model2.winRate) {
            return NSOrderedAscending;
        } else if (model1.winRate == model2.winRate) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}

- (void)setWesternNorthwest:(NSArray<HTRankModel *> *)WesternNorthwest {
    _WesternNorthwest = [WesternNorthwest sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        HTRankModel *model1 = obj1;
        HTRankModel *model2 = obj2;
        
        if (model1.winRate > model2.winRate) {
            return NSOrderedAscending;
        } else if (model1.winRate == model2.winRate) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}

@end

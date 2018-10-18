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

- (CGFloat)winRate {
    if (_winRate == 0) {
        if (self.Losses) {
            _winRate = 100.0 * self.wins.integerValue / (self.wins.integerValue + self.Losses.integerValue);
        } else {
            _winRate = 100.0 * self.wins.integerValue / (self.wins.integerValue + self.losses.integerValue);
        }        
    }
    return _winRate;
}

@end

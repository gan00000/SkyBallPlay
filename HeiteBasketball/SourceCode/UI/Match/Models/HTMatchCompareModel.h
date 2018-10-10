//
//  HTMatchCompareModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMatchDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTMatchCompareModel : NSObject

@property (nonatomic, strong) NSArray<HTMatchDetailsModel *> *homeTeamDetails;
@property (nonatomic, strong) NSArray<HTMatchDetailsModel *> *awayTeamDetails;


@end

NS_ASSUME_NONNULL_END

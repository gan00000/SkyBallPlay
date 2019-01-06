//
//  HTMatchCompareModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMatchDetailsModel.h"

@interface HTMatchCompareModel : NSObject

@property (nonatomic, strong) NSArray<HTMatchDetailsModel *> *homeTeamDetails;
@property (nonatomic, strong) NSArray<HTMatchDetailsModel *> *awayTeamDetails;


@end

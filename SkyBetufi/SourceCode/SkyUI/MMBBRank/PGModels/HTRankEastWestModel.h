//
//  HTRankEastWestModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTRankModel.h"

@interface HTRankEastWestModel : NSObject

@property (nonatomic, strong) NSArray<HTRankModel *> *Eastern;
@property (nonatomic, strong) NSArray<HTRankModel *> *Western;

@end

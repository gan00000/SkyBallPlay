//
//  HTRankZoneModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTRankModel.h"

@interface HTRankZoneModel : NSObject

/// 大西洋賽區 - 東部
@property (nonatomic, strong) NSArray<HTRankModel *> *EasternAtlantic;
/// 中部賽區 - 東部
@property (nonatomic, strong) NSArray<HTRankModel *> *EasternCentral;
/// 東南賽區 - 東部
@property (nonatomic, strong) NSArray<HTRankModel *> *EasternSoutheast;
/// 西南賽區 - 西部
@property (nonatomic, strong) NSArray<HTRankModel *> *WesternNorthwest;
/// 太平洋賽區 - 西部
@property (nonatomic, strong) NSArray<HTRankModel *> *WesternPacific;
/// 西北賽區 - 西部
@property (nonatomic, strong) NSArray<HTRankModel *> *WesternSouthwest;

@end

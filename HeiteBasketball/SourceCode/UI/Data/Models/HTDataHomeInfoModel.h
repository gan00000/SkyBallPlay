//
//  HTDataHomeInfoModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/12.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTDataHomeModel.h"

@interface HTDataHomeInfoModel : NSObject

/// 得分
@property (nonatomic, strong) NSArray<HTDataHomeModel *> *pts;
/// 籃板
@property (nonatomic, strong) NSArray<HTDataHomeModel *> *reb;
/// 助攻
@property (nonatomic, strong) NSArray<HTDataHomeModel *> *ast;
/// 搶斷
@property (nonatomic, strong) NSArray<HTDataHomeModel *> *stl;
/// 蓋帽
@property (nonatomic, strong) NSArray<HTDataHomeModel *> *blk;
/// 失誤
@property (nonatomic, strong) NSArray<HTDataHomeModel *> *turnover;

@end

//
//  HTNewsHomeBannerCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTNewsModel.h"

@interface HTNewsHomeBannerCell : UITableViewCell

@property (nonatomic, copy) void(^onBannerTappedBlock)(HTNewsModel *newsModel);

- (void)skargsetupWithNewsModels:(NSArray *)bannerList;

@end
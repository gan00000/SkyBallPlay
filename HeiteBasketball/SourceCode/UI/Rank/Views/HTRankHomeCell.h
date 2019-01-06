//
//  HTRankHomeCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/13.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTRankModel.h"

@interface HTRankHomeCell : UITableViewCell

- (void)setupWithTitle:(NSString *)title rankList:(NSArray<HTRankModel *> *)rankList;

@end

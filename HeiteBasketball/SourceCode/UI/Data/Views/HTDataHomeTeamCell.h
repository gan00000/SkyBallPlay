//
//  HTDataHomeTeamCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTDataHomeModel.h"

@interface HTDataHomeTeamCell : UITableViewCell

@property (nonatomic, copy) void (^showMoreBlock)(void);

- (void)setupWithTitle:(NSString *)title datas:(NSArray<HTDataHomeModel *> *)datas;

@end

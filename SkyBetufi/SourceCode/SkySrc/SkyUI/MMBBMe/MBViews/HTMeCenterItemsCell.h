//
//  HTMeCenterItemsCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/5.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTMeCenterItemsCell : UITableViewCell

@property (nonatomic, copy) void (^onItemTappedBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END

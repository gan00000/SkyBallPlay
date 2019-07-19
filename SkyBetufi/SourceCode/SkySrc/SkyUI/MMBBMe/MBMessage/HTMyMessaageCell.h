//
//  HTMyMessaageCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/15.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMyMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTMyMessaageCell : UITableViewCell

- (void)refreshWithMyMessageModel:(HTMyMessageModel *)model;

@end

NS_ASSUME_NONNULL_END

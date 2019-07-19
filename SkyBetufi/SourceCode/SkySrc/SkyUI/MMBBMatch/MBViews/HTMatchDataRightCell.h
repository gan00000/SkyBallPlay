//
//  HTMatchDataRightCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/17.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMatchDetailsModel.h"

@interface HTMatchDataRightCell : UITableViewCell

- (void)refreshWithModel:(HTMatchDetailsModel *)model row:(NSInteger)row;

@end

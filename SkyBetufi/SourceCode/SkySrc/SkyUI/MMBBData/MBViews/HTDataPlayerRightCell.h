//
//  HTDataPlayerRightCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/19.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTDataPlayerRankModel.h"

@interface HTDataPlayerRightCell : UITableViewCell

- (void)skargrefreshWithPlayerModel:(HTDataPlayerRankModel *)playerModel row:(NSInteger)row;

@end

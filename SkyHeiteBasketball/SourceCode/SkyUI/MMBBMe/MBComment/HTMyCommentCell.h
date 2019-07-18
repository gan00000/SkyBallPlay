//
//  HTMyCommentCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/15.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTNewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTMyCommentCell : UITableViewCell

- (void)setupWithNewsModel:(HTNewsModel *)newsModel;

@end

NS_ASSUME_NONNULL_END

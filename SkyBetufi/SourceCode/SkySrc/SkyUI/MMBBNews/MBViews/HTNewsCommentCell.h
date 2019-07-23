//
//  HTNewsCommentCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/14.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTNewsCommentCell : UITableViewCell

@property (nonatomic, copy) void (^onReplyBlock)(HTCommentModel *commentModel);
@property (nonatomic, copy) dispatch_block_t onExpendBlock;

- (void)skargrefreshWithCommentModel:(HTCommentModel *)commentModel;

@end

NS_ASSUME_NONNULL_END

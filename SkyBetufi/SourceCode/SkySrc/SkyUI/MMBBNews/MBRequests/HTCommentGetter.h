//
//  HTComentGetter.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/13.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommentGetter : NSObject

@property (nonatomic, strong) NSMutableArray<HTCommentModel *> *hotComments;
@property (nonatomic, strong) NSMutableArray<HTCommentModel *> *normalComments;
@property (nonatomic, assign) BOOL hasMore;

- (instancetype)initWithPostId:(NSString *)post_id;

- (void)doRequestWithCompleteBlock:(dispatch_block_t)commentBlock;
- (void)reset;

@end

NS_ASSUME_NONNULL_END

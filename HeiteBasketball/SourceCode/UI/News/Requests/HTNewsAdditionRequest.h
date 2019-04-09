//
//  HTNewsAdditionRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/8.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJHTTPServiceEngine.h"
#import "HTNewsModel.h"
#import "HTCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTNewsAdditionRequest : NSObject

// 獲取普通評論
+ (void)requestNormalCommentWithOffset:(NSInteger)offset
                                newsId:(NSString *)newsId
                          successBlock:(void(^)(NSArray <HTCommentModel *> *commentList))successBlock
                             failBlock:(BJServiceErrorBlock)failBlock;

// 獲取熱門評論
+ (void)requestHotCommentWithOffset:(NSInteger)offset
                             newsId:(NSString *)newsId
                       successBlock:(void(^)(NSArray <HTCommentModel *> *commentList))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;

// 獲取全部評論
+ (void)requestAllCommentWithOffset:(NSInteger)offset
                             newsId:(NSString *)newsId
                       successBlock:(void(^)(NSArray <HTCommentModel *> *commentList))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;

// 點讚/取消點讚
+ (void)likePostWithPostId:(NSString *)post_id
                comment_id:(NSString *)comment_id
                      like:(BOOL)like
              successBlock:(dispatch_block_t)successBlock
                 failBlock:(BJServiceErrorBlock)failBlock;

// 發表評論
+ (void)postCommentWithComment_txt:(NSString *)comment_txt
                           post_id:(NSString *)post_id
                  reply_comment_id:(NSString *)reply_comment_id
                      successBlock:(dispatch_block_t)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;

@end

NS_ASSUME_NONNULL_END

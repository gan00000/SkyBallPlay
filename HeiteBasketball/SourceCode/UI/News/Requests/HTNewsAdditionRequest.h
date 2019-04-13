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
+ (void)requestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <HTCommentModel *> *commentList, NSArray<HTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;

// 新闻详情
+ (void)requestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(HTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END

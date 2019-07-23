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
+ (void)skargrequestNormalCommentWithOffset:(NSInteger)offset
                                newsId:(NSString *)newsId
                          successBlock:(void(^)(NSArray <HTCommentModel *> *commentList, NSInteger pages))successBlock
                             failBlock:(BJServiceErrorBlock)failBlock;

// 獲取熱門評論
+ (void)skargrequestHotCommentWithOffset:(NSInteger)offset
                             newsId:(NSString *)newsId
                       successBlock:(void(^)(NSArray <HTCommentModel *> *commentList, NSInteger pages))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;

// 獲取全部評論
+ (void)skargrequestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <HTCommentModel *> *commentList, NSArray<HTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock;

// 新闻详情
+ (void)skargrequestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(HTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END

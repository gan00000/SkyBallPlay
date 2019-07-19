//
//  HTNewsAdditionRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/8.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTNewsAdditionRequest.h"

@implementation HTNewsAdditionRequest

+ (void)requestNormalCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <HTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_COMMENTS params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<HTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[HTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}

+ (void)requestHotCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <HTCommentModel *> *commentList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_HOT_COMMENT params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *commentsData = responseData[@"result"][@"comments"];
            NSArray<HTCommentModel *> *comments = [NSArray yy_modelArrayWithClass:[HTCommentModel class] json:commentsData];
            NSInteger pages = [(NSNumber *)responseData[@"result"][@"pages"] integerValue];
            successBlock(comments, pages);
        }
    } errorBlock:failBlock];
}

+ (void)requestAllCommentWithPostId:(NSString *)postId
                       successBlock:(void(^)(NSArray <HTCommentModel *> *commentList, NSArray<HTCommentModel *> *hotComments))successBlock
                          failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_ALL_COMMENT params:@{@"post_id": postId} successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *comments = [NSArray yy_modelArrayWithClass:[HTCommentModel class] json:responseData[@"get_comments"][@"result"][@"comments"]];
            NSArray *hotComments = [NSArray yy_modelArrayWithClass:[HTCommentModel class] json:responseData[@"get_hot_comments"][@"result"][@"comments"]];
            successBlock(comments, hotComments);
        }
    } errorBlock:failBlock];
}

// 新闻详情
+ (void)requestDetailWithPostId:(NSString *)post_id
                   successBlock:(void(^)(HTNewsModel *newsModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_DETAIL params:@{@"post_id": post_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([HTNewsModel yy_modelWithJSON:responseData[@"post"]]);
        }
    } errorBlock:errorBlock];
}


@end

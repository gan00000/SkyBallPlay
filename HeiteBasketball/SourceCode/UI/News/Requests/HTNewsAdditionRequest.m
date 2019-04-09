//
//  HTNewsAdditionRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/8.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTNewsAdditionRequest.h"

@implementation HTNewsAdditionRequest

+ (void)requestNormalCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <HTCommentModel *> *commentList))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_COMMENTS params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([NSArray yy_modelArrayWithClass:[HTCommentModel class] json:responseData[@"result"][@"comments"]]);
        }
    } errorBlock:failBlock];
}

+ (void)requestHotCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <HTCommentModel *> *commentList))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_HOT_COMMENT params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([NSArray yy_modelArrayWithClass:[HTCommentModel class] json:responseData[@"result"][@"comments"]]);
        }
    } errorBlock:failBlock];
}

+ (void)requestAllCommentWithOffset:(NSInteger)offset newsId:(NSString *)newsId successBlock:(void(^)(NSArray <HTCommentModel *> *commentList))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_ALL_COMMENT params:@{@"offset": @(offset), @"post_id": newsId} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([NSArray yy_modelArrayWithClass:[HTCommentModel class] json:responseData[@"get_comments"][@"result"][@"comments"]]);
        }
    } errorBlock:failBlock];
}

+ (void)likePostWithPostId:(NSString *)post_id comment_id:(NSString *)comment_id like:(BOOL)like successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"post_id"] = post_id;
    params[@"comment_id"] = comment_id;
    params[@"like"] = @(like);
    
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_LIKE_ADD params:params successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}

+ (void)postCommentWithComment_txt:(NSString *)comment_txt post_id:(NSString *)post_id reply_comment_id:(NSString *)reply_comment_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"post_id"] = post_id;
    params[@"comment_txt"] = comment_txt;
    params[@"reply_comment_id"] = reply_comment_id;
    
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_NEWS_POST_COMMENT params:params successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}


@end

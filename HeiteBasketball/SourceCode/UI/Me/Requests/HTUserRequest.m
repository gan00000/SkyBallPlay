//
//  HTLoginRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/6.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTUserRequest.h"

@implementation HTUserRequest

+ (void)doLoginRequestWithAccessToken:(NSString *)accessToken
                                  sns:(NSInteger)sns
                         successBlock:(void(^)(NSString *userToken))successBlock
                            failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"sns_login"] = @(sns);
    param[@"access_token"] = accessToken;
    param[@"device_token"] = [HTUserManager deviceToken];
    param[@"device_type"] = @(1);
    
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_LOGIN params:param successBlock:^(id responseData) {
        if (successBlock) {
            successBlock(responseData[@"result"][@"user_token"]);
        }
    } errorBlock:failBlock];
}

+ (void)requestUserInfoWithSuccessBlock:(void(^)(NSDictionary *userInfo))successBlock
                              failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine getRequestWithFunctionPath:API_USER_INFO params:nil successBlock:^(id responseData) {
        if (successBlock) {
            successBlock(responseData[@"result"]);
        }
    } errorBlock:failBlock];
}

+ (void)updateUserInfoWithEmail:(NSString *)email
                    displayName:(NSString *)displayName
                           file:(NSString *)file
                   successBlock:(void(^)(NSDictionary *userInfo))successBlock
                      failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"email"] = email;
    param[@"display_name"] = displayName;
    param[@"file"] = file;
    
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_UPDATE params:param successBlock:^(id responseData) {
        if (successBlock) {
            successBlock(responseData[@"result"]);
        }
    } errorBlock:failBlock];
}

+ (void)requestCollectionListWithOffset:(NSInteger)offset successBlock:(void(^)(NSArray <HTNewsModel *> *newsList, NSInteger pages))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_SAVE_LIST params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([NSArray yy_modelArrayWithClass:[HTNewsModel class] json:responseData[@"savedposts"][@"posts"]], [(NSNumber *)responseData[@"savedposts"][@"pages"] integerValue]);
        }
    } errorBlock:failBlock];
}

+ (void)addCollectionWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_SAVE_ADD params:@{@"post_id": news_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}

+ (void)deleteCollectionWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_UNSAVE params:@{@"post_id": news_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}

+ (void)requestHistoryWithSuccessBlock:(void(^)(NSArray <HTNewsModel *> *newsList))successBlock
                             failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_HISTORY_LIST params:nil successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([NSArray yy_modelArrayWithClass:[HTNewsModel class] json:responseData[@"historyposts"][@"posts"]]);
        }
    } errorBlock:failBlock];
}

+ (void)addHistoryWithNewsId:(NSString *)news_id successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_HISTORY_ADD params:@{@"post_id": news_id} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}

+ (void)requestMyCommentWithOffset:(NSInteger)offset successBlock:(void(^)(NSArray <HTNewsModel *> *newsList))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_MY_COMMENT params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([NSArray yy_modelArrayWithClass:[HTNewsModel class] json:responseData[@"posts"]]);
        }
    } errorBlock:failBlock];
}

+ (void)requestMyLikeWithOffset:(NSInteger)offset successBlock:(void(^)(NSArray <HTNewsModel *> *newsList))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_MY_LIKE params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([NSArray yy_modelArrayWithClass:[HTNewsModel class] json:responseData[@"comments"]]);
        }
    } errorBlock:failBlock];
}

+ (void)requestUnReadMessageCountWithSuccessBlock:(void(^)(NSInteger count))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_MESSAGE_COUNT params:nil successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([(NSString *)responseData[@"result"][@"total_unread"] integerValue]);
        }
    } errorBlock:failBlock];
}

+ (void)requestMyMessageWithOffset:(NSInteger)offset successBlock:(void(^)(NSArray <HTMyMessageModel *> *messageList))successBlock failBlock:(BJServiceErrorBlock)failBlock {
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_MESSAGE_LIST params:@{@"offset": @(offset)} successBlock:^(id responseData) {
        if (successBlock) {
            successBlock([NSArray yy_modelArrayWithClass:[HTMyMessageModel class] json:responseData[@"result"][@"notification"]]);
        }
    } errorBlock:failBlock];
}

+ (void)likePostWithPostId:(NSString *)post_id comment_id:(NSString *)comment_id like:(BOOL)like successBlock:(dispatch_block_t)successBlock failBlock:(BJServiceErrorBlock)failBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"post_id"] = post_id;
    params[@"comment_id"] = comment_id;
    params[@"like"] = @(like);
    
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_LIKE_ADD params:params successBlock:^(id responseData) {
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
    
    [BJHTTPServiceEngine postRequestWithFunctionPath:API_USER_POST_COMMENT params:params successBlock:^(id responseData) {
        if (successBlock) {
            successBlock();
        }
    } errorBlock:failBlock];
}

@end

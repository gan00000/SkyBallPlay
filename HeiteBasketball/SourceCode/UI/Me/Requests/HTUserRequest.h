//
//  HTLoginRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/6.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJHTTPServiceEngine.h"
#import "HTNewsModel.h"
#import "HTMyMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTUserRequest : NSObject

+ (void)doLoginRequestWithAccessToken:(NSString *)accessToken
                                  sns:(NSInteger)sns
                         successBlock:(void(^)(NSString *userToken))successBlock
                            failBlock:(BJServiceErrorBlock)failBlock;

+ (void)requestUserInfoWithSuccessBlock:(void(^)(NSDictionary *userInfo))successBlock
                              failBlock:(BJServiceErrorBlock)failBlock;

+ (void)updateUserInfoWithEmail:(NSString *)email
                    displayName:(NSString *)displayName
                           file:(NSString *)file
                   successBlock:(void(^)(NSDictionary *userInfo))successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;

// 獲取我的收藏
+ (void)requestCollectionListWithOffset:(NSInteger)offset
                           successBlock:(void(^)(NSArray <HTNewsModel *> *newsList))successBlock
                              failBlock:(BJServiceErrorBlock)failBlock;

// 添加收藏
+ (void)addCollectionWithNewsId:(NSString *)news_id
                   successBlock:(dispatch_block_t)successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;

// 取消收藏
+ (void)deleteCollectionWithNewsId:(NSString *)news_id
                      successBlock:(dispatch_block_t)successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;

// 獲取瀏覽歷史
+ (void)requestHistoryWithSuccessBlock:(void(^)(NSArray <HTNewsModel *> *newsList))successBlock
                             failBlock:(BJServiceErrorBlock)failBlock;

// 添加瀏覽歷史
+ (void)addHistoryWithNewsId:(NSString *)news_id
                successBlock:(dispatch_block_t)successBlock
                   failBlock:(BJServiceErrorBlock)failBlock;

// 獲取我的留言
+ (void)requestMyCommentWithOffset:(NSInteger)offset
                      successBlock:(void(^)(NSArray <HTNewsModel *> *newsList))successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;

// 獲取我的點讚
+ (void)requestMyLikeWithOffset:(NSInteger)offset
                   successBlock:(void(^)(NSArray <HTNewsModel *> *newsList))successBlock
                      failBlock:(BJServiceErrorBlock)failBlock;

// 獲取未讀消息數
+ (void)requestUnReadMessageCountWithSuccessBlock:(void(^)(NSInteger count))successBlock
                                        failBlock:(BJServiceErrorBlock)failBlock;

// 獲取消息通知列表
+ (void)requestMyMessageWithOffset:(NSInteger)offset
                      successBlock:(void(^)(NSArray <HTMyMessageModel *> *messageList))successBlock
                         failBlock:(BJServiceErrorBlock)failBlock;

@end

NS_ASSUME_NONNULL_END

//
//  HTCommentModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/9.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommentModel : NSObject

@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *comment_author;
@property (nonatomic, copy) NSString *comment_date;
@property (nonatomic, copy) NSString *comment_content;
@property (nonatomic, copy) NSString *user_img;
@property (nonatomic, assign) NSInteger total_like;
@property (nonatomic, copy) NSString *reply_to_user_id;
@property (nonatomic, copy) NSString *reply_to_display_name;
@property (nonatomic, strong) NSArray<HTUserInfoModel *> *like;
@property (nonatomic, assign) BOOL my_like;
@property (nonatomic, assign) NSInteger total_reply;
@property (nonatomic, strong) NSArray<HTCommentModel *> *reply;

@property (nonatomic, strong) HTUserInfoModel *userModel;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat replyHeight;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isReply;
@property (nonatomic, assign) BOOL expend; // 展开

- (void)countHeight:(BOOL)isReply;

@end

NS_ASSUME_NONNULL_END

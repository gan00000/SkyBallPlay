//
//  HTCommentModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/9.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTCommentModel.h"

@interface HTCommentModel ()

@property (nonatomic, assign) CGFloat selfHeight;
@property (nonatomic, assign) CGFloat replyUnExpendHeight;
@property (nonatomic, assign) CGFloat replyAllHeight;

@end

@implementation HTCommentModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"like": [HTUserInfoModel class],
             @"reply": [HTCommentModel class]
             };
}

- (void)skargcountHeight:(BOOL)isReply {
    self.isReply = isReply;
    
    if (!isReply) {
        CGFloat contentHeight = [self.comment_content jx_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:SCREEN_WIDTH-71].height;
        self.selfHeight = contentHeight + 84;
        
        for (NSInteger i=0; i<self.reply.count; i++) {
            HTCommentModel *model = self.reply[i];
            [model skargcountHeight:YES];
            
            if (i < 3) {
                self.replyUnExpendHeight += model.cellHeight;
            }
            self.replyAllHeight += model.cellHeight;
        }
        
        if (self.reply.count > 3) {
            self.replyUnExpendHeight += 40;
            self.replyAllHeight += 40;
        }
        
        if (self.reply.count > 0) {
            self.selfHeight += 10;
        }
        
        self.replyHeight = self.replyUnExpendHeight;
        self.cellHeight = self.selfHeight + self.replyUnExpendHeight;
        
    } else {
        self.replyHeight = 0;
        CGFloat contentHeight = [self.comment_content jx_sizeWithFont:[UIFont systemFontOfSize:12] constrainedToWidth:SCREEN_WIDTH-113].height;
        self.cellHeight = contentHeight + 54;
    }
}

- (void)setIsReply:(BOOL)isReply {
    _isReply = isReply;
    
    if (isReply) {
        _comment_content = [NSString stringWithFormat:@"回復@%@:%@", self.reply_to_display_name, self.comment_content];
    }
}

- (void)setExpend:(BOOL)expend {
    _expend = expend;
    
    if (expend) {
        _cellHeight = self.selfHeight + self.replyAllHeight;
        _replyHeight = self.replyAllHeight;
    } else {
        _cellHeight = self.selfHeight + self.replyUnExpendHeight;
        _replyHeight = self.replyUnExpendHeight;
    }
}

- (HTUserInfoModel *)userModel {
    if (!_userModel) {
        _userModel = [[HTUserInfoModel alloc] init];
        _userModel.user_id = self.user_id;
        _userModel.display_name = self.comment_author;
        _userModel.user_img = self.user_img;
    }
    return _userModel;
}

- (NSDate *)date {
    if (!_date) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _date = [format dateFromString:self.comment_date];
    }
    return _date;
}

@end

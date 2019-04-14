//
//  HTComentGetter.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/13.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTCommentGetter.h"
#import "HTNewsAdditionRequest.h"

@interface HTCommentGetter ()

@property (nonatomic, assign) NSInteger hotOffset;
@property (nonatomic, assign) NSInteger normalOffset;
@property (nonatomic, assign) BOOL hasMoreHot;
@property (nonatomic, assign) BOOL hasMoreNormal;

@end

@implementation HTCommentGetter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hotComments = [NSMutableArray array];
        self.normalComments = [NSMutableArray array];
        self.hotOffset = 0;
        self.normalOffset = 0;
        self.hasMoreHot = YES;
        self.hasMoreNormal = YES;
        self.hasMore = YES;
    }
    return self;
}

- (void)doRequestWithCompleteBlock:(dispatch_block_t)commentBlock
                         failBlock:(dispatch_block_t)failBlock {
    
}

@end

//
//  HTMatchWordLiveViewController.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "PPXXBJBaseViewController.h"
#import "HTMatchLiveFeedModel.h"

@interface HTMatchWordLiveViewController : PPXXBJBaseViewController

@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);

- (void)skargrefreshWithLiveFeedList:(NSArray<HTMatchLiveFeedModel *> *)liveFeedList;

@end

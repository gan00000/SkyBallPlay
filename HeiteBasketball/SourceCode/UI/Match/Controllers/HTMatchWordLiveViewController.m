//
//  HTMatchWordLiveViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchWordLiveViewController.h"

#import "HTMatchLiveFeedRequest.h"

@interface HTMatchWordLiveViewController ()

@end

@implementation HTMatchWordLiveViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"MatchWordLive");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshWithLiveFeedList:(NSArray<HTMatchLiveFeedModel *> *)liveFeedList {
    
}

@end

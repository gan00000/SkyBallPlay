//
//  HTMatchDetailViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchDetailViewController.h"

@interface HTMatchDetailViewController ()

@end

@implementation HTMatchDetailViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"MatchDetail");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@ vs %@", self.matchModel.homeName, self.matchModel.awayName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

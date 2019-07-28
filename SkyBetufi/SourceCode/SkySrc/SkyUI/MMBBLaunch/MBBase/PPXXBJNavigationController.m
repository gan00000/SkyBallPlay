//
//  BJNavigationController.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "PPXXBJNavigationController.h"
#import "HTMatchHomeViewController.h"
#import "HTNewsHomeViewController.h"
#import "HTFilmHomeViewController.h"
#import "HTDataHomeViewController.h"
#import "HTRankHomeViewController.h"
#import "HTTabBarHomeViewController.h"
#import "HTNewsHomeOtherViewController.h"

@interface PPXXBJNavigationController ()

@end

@implementation PPXXBJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-64)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *barItemAttris = @{ NSFontAttributeName : [UIFont systemFontOfSize:15 weight:UIFontWeightLight] };
    [[UIBarButtonItem appearance] setTitleTextAttributes:barItemAttris forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    UIFont *font = [UIFont systemFontOfSize:18];
    NSShadow *shadow = [[NSShadow alloc] init];
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSShadowAttributeName : shadow,
                                  NSFontAttributeName : font };
    [self.navigationBar setTitleTextAttributes:attributes];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<Class> *)skargviewControllersNotHideTabBar {
    return @[[HTMatchHomeViewController class],
             [HTNewsHomeViewController class],
             [HTFilmHomeViewController class],
             [HTDataHomeViewController class],
             [HTRankHomeViewController class],
             [HTNewsHomeOtherViewController class],
             [HTTabBarHomeViewController class]];
}

@end

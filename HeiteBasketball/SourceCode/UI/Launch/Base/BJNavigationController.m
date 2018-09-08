//
//  BJNavigationController.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJNavigationController.h"
#import "HTMatchHomeViewController.h"
#import "HTNewsHomeViewController.h"
#import "HTVideoHomeViewController.h"
#import "HTDataHomeViewController.h"
#import "HTRankHomeViewController.h"

@interface BJNavigationController ()

@end

@implementation BJNavigationController

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

- (NSArray<Class> *)viewControllersNotHideTabBar {
    return @[[HTMatchHomeViewController class],
             [HTNewsHomeViewController class],
             [HTVideoHomeViewController class],
             [HTDataHomeViewController class],
             [HTRankHomeViewController class]];
}

@end

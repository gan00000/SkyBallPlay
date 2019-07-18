//
//  BJMainViewController.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJMainViewController.h"
#import "HTMatchHomeViewController.h"
#import "HTNewsHomeViewController.h"
#import "HTFilmHomeViewController.h"
#import "HTDataHomeViewController.h"
#import "HTRankHomeViewController.h"

@interface BJMainViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) BJNavigationController *nav1;
@property (nonatomic, strong) HTMatchHomeViewController *vc1;

@property (nonatomic, strong) BJNavigationController *nav2;
@property (nonatomic, strong) HTNewsHomeViewController *vc2;

@property (nonatomic, strong) BJNavigationController *nav3;
@property (nonatomic, strong) HTFilmHomeViewController *vc3;

@property (nonatomic, strong) BJNavigationController *nav4;
@property (nonatomic, strong) HTDataHomeViewController *vc4;

@property (nonatomic, strong) BJNavigationController *nav5;
@property (nonatomic, strong) HTRankHomeViewController *vc5;

@end

@implementation BJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBA_COLOR_HEX(0x999999)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"fc562e"]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage imageNamed:@"tab_bar_shadow"]];
    
    self.tabBar.translucent = NO;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (NSArray<NSString *> *)tabBarTitles {
    return @[@"比賽", @"新聞", @"影片", @"數據", @"排行"];
}

- (NSArray<UIImage *> *)tabBarIcons {
    return @[[[UIImage imageNamed:@"tab_icon_normal1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

- (NSArray<UIImage *> *)tabBarSelectedIcons {
    return @[[[UIImage imageNamed:@"tab_icon_selected1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

- (NSArray<UIViewController *> *)tabBarControllers {
    if (!self.vc1) {
        self.vc1 = [HTMatchHomeViewController viewController];
        self.nav1 = [[BJNavigationController alloc] initWithRootViewController:self.vc1];
    }
    if (!self.vc2) {
        self.vc2 = [HTNewsHomeViewController viewController];
        self.nav2 = [[BJNavigationController alloc] initWithRootViewController:self.vc2];
    }
    if (!self.vc3) {
        self.vc3 = [HTFilmHomeViewController viewController];
        self.nav3 = [[BJNavigationController alloc] initWithRootViewController:self.vc3];
    }
    if (!self.vc4) {
        self.vc4 = [HTDataHomeViewController viewController];
        self.nav4 = [[BJNavigationController alloc] initWithRootViewController:self.vc4];
    }
    if (!self.vc5) {
        self.vc5 = [HTRankHomeViewController viewController];
        self.nav5 = [[BJNavigationController alloc] initWithRootViewController:self.vc5];
    }
    return @[self.nav1, self.nav2, self.nav3, self.nav4, self.nav5];
}

#pragma MARK -- UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    self.currentSelectedIndex = self.selectedIndex;
}

@end

//
//  BJBaseViewController.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/23.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJBaseViewController.h"

@interface BJBaseViewController ()

@end

@implementation BJBaseViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    self.title = self.tabBarItem.title;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end

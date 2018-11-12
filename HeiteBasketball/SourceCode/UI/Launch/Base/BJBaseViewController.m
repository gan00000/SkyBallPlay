//
//  BJBaseViewController.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/23.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJBaseViewController.h"
#import <LTNavigationBar/UINavigationBar+Awesome.h>
#import "HTSettingViewController.h"

@interface BJBaseViewController ()

@end

@implementation BJBaseViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
    if (self.navigationController.viewControllers.count == 1) {
        UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon_title"]];
        self.navigationItem.titleView = titleView;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_set"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettingVc)];
    }
}

- (void)showSettingVc {
    HTSettingViewController *setvc = [HTSettingViewController viewController];
    [self.navigationController pushViewController:setvc animated:YES];
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

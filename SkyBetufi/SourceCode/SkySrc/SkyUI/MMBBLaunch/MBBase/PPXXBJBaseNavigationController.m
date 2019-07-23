//
//  BJNavigationController.m
//  zhugelicai
//
//  Created by Marco on 2017/5/19.
//  Copyright © 2017年 Marco. All rights reserved.
//

#import "PPXXBJBaseNavigationController.h"
#import "HTMatchHomeViewController.h"
#import "HTNewsHomeViewController.h"
#import "HTFilmHomeViewController.h"
#import "HTDataHomeViewController.h"
#import "HTRankHomeViewController.h"

@interface UINavigationController (UINavigationControllerPopHooker)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(nonnull UINavigationItem *)item;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implemention"
@implementation UINavigationController (UINavigationControllerPopHooker)
@end
#pragma clang diagnostic pop

@interface PPXXBJBaseNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@end

@implementation PPXXBJBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

#pragma mark -- 横屏在delegate中处理，这里先屏蔽
//- (BOOL)shouldAutorotate {
//    return self.topViewController.shouldAutorotate;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return self.topViewController.supportedInterfaceOrientations;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return self.topViewController.preferredInterfaceOrientationForPresentation;
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    for(Class vcClass in [self skargviewControllersNotHideTabBar]) {
        if ([viewController isKindOfClass:vcClass]) {
            [super pushViewController:viewController animated:animated];
            return;
        }
    }
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    
    if (self.viewControllers.count > 1 ||
        (![self isKindOfClass:[HTMatchHomeViewController class]] &&
         ![self isKindOfClass:[HTNewsHomeViewController class]] &&
         ![self isKindOfClass:[HTFilmHomeViewController class]] &&
         ![self isKindOfClass:[HTDataHomeViewController class]] &&
         ![self isKindOfClass:[HTRankHomeViewController class]])) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_back"]
                                                                                           style:UIBarButtonItemStylePlain
                                                                                          target:self
                                                                                          action:@selector(backAction:)];
        viewController.navigationItem.hidesBackButton = YES;
    }
}

#pragma mark -
- (NSArray<Class> *)skargviewControllersNotHideTabBar {
    return nil;
}

#pragma mark - Back Action
- (void)backAction:(UIButton *)button {
    UIViewController *viewController = self.topViewController;
    
    if ([viewController respondsToSelector:@selector(skarg_shouldHandlePopActionMySelfskarg_shouldHandlePopActionMySelf)]) {
        if ([(id<BJNavigationDelegate>)viewController skarg_shouldHandlePopActionMySelf]) {
            if ([viewController respondsToSelector:@selector(skarg_handlePopActionMySelfskarg_handlePopActionMySelf)]) {
                [(id<BJNavigationDelegate>)viewController skarg_handlePopActionMySelf];
            }
            return; //自定义返回按钮点击事件
        }
    }
    if (self.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count == 1) {
        return NO;
    }
    UIViewController *viewController = self.topViewController;
    if ([viewController respondsToSelector:@selector(skarg_shouldForbidSlideBackActionskarg_shouldForbidSlideBackActionskarg_shouldForbidSlideBackAction)]) {
        BJLog(@"can slide back: %d", ![(id<BJNavigationDelegate>)viewController skarg_shouldForbidSlideBackAction]);
        return ![(id<BJNavigationDelegate>)viewController skarg_shouldForbidSlideBackAction];
    } else {
        return YES;
    }
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL hidde = NO;
    if ([viewController respondsToSelector:@selector(skarg_shouldHideNavigationBar)]) {
        hidde = [(id<BJNavigationDelegate>)viewController skarg_shouldHideNavigationBar];
    }
    [self setNavigationBarHidden:hidde animated:YES];
}

@end

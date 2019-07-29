//
//  BJLaunchViewController.m
//  BenjiaPro
//
//  Created by Stone.Feng on 2017/12/11.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "PPXXBJLaunchViewController.h"
#import "PPXXBJMainViewController.h"
#import "AppDelegate.h"
#import "BJHTTPServiceEngine.h"

@interface PPXXBJLaunchViewController () <CAAnimationDelegate>

@property (nonatomic, strong) PPXXBJMainViewController *tabBarController;

@end

@implementation PPXXBJLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BJLog(@"getRequestCommon start");
    [BJHTTPServiceEngine skarg_getRequestCommon:@"ios_config.json" params:nil successBlock:^(id responseData) {
        
        NSDictionary *configDictionary = responseData; //[NSDictionary dictionaryWithDictionary:responseData];
        if (configDictionary) {
            NSString *version = configDictionary[@"version"];
            NSString *status = configDictionary[@"status"];
            NSString *examine = configDictionary[@"examine"];
            if ([examine isEqualToString:@"1"]) {
                [HTUserManager manager].appInView = YES;
                BJLog(@"getRequestCommon in view");
                
            }else{
                BJLog(@"getRequestCommon not in view");
                [HTUserManager manager].appInView = NO;
            }
        }
        
        [[UIApplication sharedApplication].delegate.window insertSubview:self.tabBarController.view atIndex:0];
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.1f;//间隔时间
        animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
        animation.type = kCATransitionFade;
        
        [[UIApplication sharedApplication].delegate.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        [[UIApplication sharedApplication].delegate.window.layer addAnimation:animation forKey:@"animation"];

        
    } errorBlock:^(BJError *error) {
        
        BJLog(@"ERROR:%@",error);
        
        [[UIApplication sharedApplication].delegate.window insertSubview:self.tabBarController.view atIndex:0];
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.1f;//间隔时间
        animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
        animation.type = kCATransitionFade;
        
        [[UIApplication sharedApplication].delegate.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        [[UIApplication sharedApplication].delegate.window.layer addAnimation:animation forKey:@"animation"];

        
    }];
    
    NSString *imageName = [NSString stringWithFormat:@"%ldx%ld", (long)(SCREEN_WIDTH*SCREEN_SCALE), (long)(SCREEN_HEIGHT*SCREEN_SCALE)];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *launchImageView = [[UIImageView alloc] init];
    launchImageView.image = image;
    [self.view addSubview:launchImageView];
    
    [launchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
    
//    [[UIApplication sharedApplication].delegate.window insertSubview:self.tabBarController.view atIndex:0];
//    CATransition *animation = [CATransition animation];
//    animation.delegate = self;
//    animation.duration = 0.3f;//间隔时间
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
//    animation.type = kCATransitionFade;
//
//    [[UIApplication sharedApplication].delegate.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
//    [[UIApplication sharedApplication].delegate.window.layer addAnimation:animation forKey:@"animation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [UIApplication sharedApplication].delegate.window.rootViewController = self.tabBarController;
}

#pragma mark - getters
- (PPXXBJMainViewController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[PPXXBJMainViewController alloc] init];
    }
    return _tabBarController;
}

@end

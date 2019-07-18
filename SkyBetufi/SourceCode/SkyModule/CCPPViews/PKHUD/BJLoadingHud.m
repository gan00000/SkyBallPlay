//
//  BJLoadingHud.m
//  Exchange
//
//  Created by Marco on 2017/3/8.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import "BJLoadingHud.h"
#import "MBProgressHUD.h"
#import "BJHUDView.h"

@implementation BJLoadingHud

+ (void)showHUDInView:(UIView *)view {
    //[MBProgressHUD showHUDAddedTo:view animated:YES];
    [self hideHUDInView:view];
    
    BJHUDView *customView = [[NSBundle mainBundle] loadNibNamed:@"BJHUDView" owner:nil options:nil].firstObject;
    customView.frame = view.bounds;
    customView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [view addSubview:customView];
    [view bringSubviewToFront:customView];
    customView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        customView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

+ (void)showHUDWithText:(NSString *)text inView:(UIView *)view {
    
    [self hideHUDInView:view];
    
    BJHUDView *customView = [[NSBundle mainBundle] loadNibNamed:@"BJHUDView" owner:nil options:nil].firstObject;
    customView.frame = view.bounds;
    customView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [view addSubview:customView];
    [view bringSubviewToFront:customView];
    
    customView.loadingLabel.text = text;
    
    customView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        customView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}

+ (void)hideHUDInView:(UIView *)view {
    //[MBProgressHUD hideHUDForView:view animated:YES];
    for (UIView *sv in view.subviews) {
        if ([sv isKindOfClass:[BJHUDView class]]) {
            [UIView animateWithDuration:0.3 animations:^{
                sv.alpha = 0;
            } completion:^(BOOL finished) {
                [sv removeFromSuperview];
            }];
            break;
        }
    }
}

@end

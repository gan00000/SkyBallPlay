//
//  HTPushAlertView.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/13.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTPushAlertView.h"
#import <BlocksKit/UIView+BlocksKit.h>
#import "HTNewsDetailViewController.h"

@interface HTPushAlertView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (nonatomic, copy) NSString *postId;

@end

@implementation HTPushAlertView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 9;
    self.layer.masksToBounds = YES;
    
    kWeakSelf
    [self bk_whenTapped:^{
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.y = -weakSelf.height;
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            HTNewsDetailViewController *detailVc = [HTNewsDetailViewController viewController];
            detailVc.post_id = weakSelf.postId;
            UIViewController *vc = [BJViewControllerCenter currentViewController];
            if (vc.navigationController) {
                [vc.navigationController pushViewController:detailVc animated:YES];
            }
        }];
    }];
}

+ (void)showPushViewWithUserInfo:(NSDictionary *)userInfo {
    HTPushAlertView *alert = kLoadXibWithName(NSStringFromClass([self class]));
    [alert setupWithUserInfo:userInfo];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
    [UIView animateWithDuration:0.3 animations:^{
        alert.y = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    }];
}

- (void)setupWithUserInfo:(NSDictionary *)userInfo {
    self.postId = [userInfo objectForKey:@"postId"];
    NSDictionary *alert = userInfo[@"aps"][@"alert"];
    NSString *detail = alert[@"body"];
    self.titleLabel.text = alert[@"title"];
    
    CGFloat height = [detail jx_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:SCREEN_WIDTH-40].height + 60;
    if (height > 110) {
        height = 110;
    }
    self.frame = CGRectMake(10, -height, SCREEN_WIDTH-20, height);
}

@end

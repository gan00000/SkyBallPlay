//
//  BJBaseViewController.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/23.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJBaseViewController.h"
#import "HTMeHomeViewController.h"
#import "BJNavigationController.h"

@interface BJBaseViewController ()

@property (nonatomic, strong) UIButton *meCenterButton;

@end

@implementation BJBaseViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
    if (self.navigationController.viewControllers.count == 1 && ![self isKindOfClass:[HTMeHomeViewController class]]) {
        UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon_title"]];
        self.navigationItem.titleView = titleView;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.meCenterButton];
        [self setupMeCenterButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setupMeCenterButton)
                                                     name:kUserLogStatusChagneNotice
                                                   object:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showMeCenter {
    HTMeHomeViewController *meVc = [HTMeHomeViewController viewController];
    BJNavigationController *nav = [[BJNavigationController alloc] initWithRootViewController:meVc];
    [nav.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)setupMeCenterButton {
    if ([HTUserManager isUserLogin]) {
        [self.meCenterButton setImage:[self fixImageSize:[HTUserManager userInfo].avatar] forState:UIControlStateNormal];
    } else {
        [self.meCenterButton setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    }
}

- (UIButton *)meCenterButton {
    if (!_meCenterButton) {
        _meCenterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
        _meCenterButton.clipsToBounds = YES;
        _meCenterButton.layer.cornerRadius = 18;
        [_meCenterButton addTarget:self action:@selector(showMeCenter) forControlEvents:UIControlEventTouchUpInside];
    }
    return _meCenterButton;
}

- (UIImage *)fixImageSize:(UIImage *)image {
    CGSize size = image.size;
    if (size.width == size.height) {
        return [self yp_imageWithOriginalImage:image withScaleSize:CGSizeMake(36, 36)];
    } else {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        CGFloat inset = (size.height - size.width) / 2;
        CGRect newRect = CGRectInset(rect, inset < 0? fabs(inset) : 0, inset > 0? inset : 0);
        UIImage *subImage = [self yp_imagecutWithOriginalImage:image withCutRect:newRect];
        return [self yp_imageWithOriginalImage:subImage withScaleSize:CGSizeMake(36, 36)];
    }
}


- (UIImage *)yp_imagecutWithOriginalImage:(UIImage *)originalImage withCutRect:(CGRect)rect {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(originalImage.CGImage, rect);
    CGRect smallRect = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(smallRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallRect, subImageRef);
    UIImage * image = [UIImage imageWithCGImage:subImageRef];
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    CGImageRelease(subImageRef);
    return image;
}

- (UIImage *)yp_imageWithOriginalImage:(UIImage *)originalImage withScaleSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end

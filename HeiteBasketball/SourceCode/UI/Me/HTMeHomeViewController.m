//
//  HTMeHomeViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/3/31.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTMeHomeViewController.h"
#import "HTSettingViewController.h"


@interface HTMeHomeViewController ()

@end

@implementation HTMeHomeViewController

+ (instancetype)viewController {
    return [[HTMeHomeViewController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_back"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(dismiss)];
    [self setupNav];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setupNav];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupNav {
    CALayer *layer = [CALayer layer];
    layer.frame = self.navigationController.navigationBar.bounds;
    layer.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"fc562e"].CGColor;
    
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, NO, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

@end

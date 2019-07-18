//
//  BJViewControllerCenter.h
//  BenjiaPro
//
//  Created by Marco on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJMainViewController.h"

@interface BJViewControllerCenter : NSObject

+ (BJMainViewController *)mainViewController;
+ (UIViewController *)currentViewController;

@end

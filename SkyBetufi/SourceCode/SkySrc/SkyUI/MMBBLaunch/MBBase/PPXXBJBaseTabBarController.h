//
//  BJTabBarController.h
//  zhugelicai
//
//  Created by Marco on 2017/5/19.
//  Copyright © 2017年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPXXBJBaseTabBarController : UITabBarController

- (NSArray<UIImage *> *)skargtabBarIcons;
- (NSArray<UIImage *> *)skargtabBarSelectedIcons;
- (NSArray<NSString *> *)skargtabBarTitles;
- (NSArray<UIViewController *> *)skargtabBarControllers;

@end

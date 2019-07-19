//
//  BJMainViewController.h
//  BenjiaPro
//
//  Created by Marco on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "PPXXBJBaseTabBarController.h"

typedef NS_ENUM(NSInteger, BJMainTabIndex) {
    BJMainTabIndexMatch= 0,
    BJMainTabIndexNews,
    BJMainTabIndexFilm,
    BJMainTabIndexData,
    BJMainTabIndexRank
};

@interface PPXXBJMainViewController : PPXXBJBaseTabBarController

@property (nonatomic, assign) NSInteger currentSelectedIndex;

@end

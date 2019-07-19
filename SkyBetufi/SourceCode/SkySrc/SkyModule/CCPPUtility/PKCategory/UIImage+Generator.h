//
//  UIImage+Generator.h
//  BenjiaPro
//
//  Created by Marco on 2017/6/6.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Generator)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageFromLayer:(CALayer *)layer;

@end

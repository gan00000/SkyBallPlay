//
//  HTSvgLogoUtil.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTSvgLogoUtil : NSObject

+ (instancetype)sharedInstance;
- (NSString *)htmlWithSrc:(NSString *)img_url;

@end
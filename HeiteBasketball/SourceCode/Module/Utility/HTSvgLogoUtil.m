//
//  HTSvgLogoUtil.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTSvgLogoUtil.h"

@interface HTSvgLogoUtil ()

@property (nonatomic, copy) NSString *html;

@end

@implementation HTSvgLogoUtil

+ (instancetype)sharedInstance {
    static HTSvgLogoUtil *util;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[HTSvgLogoUtil alloc] init];
    });
    return util;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"logo_load" ofType:@"html"];
        _html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }
    return self;
}

- (NSString *)htmlWithSrc:(NSString *)img_url {
    return [NSString stringWithFormat:self.html, img_url];
}

@end

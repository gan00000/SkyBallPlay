//
//  HTHtmlLoadUtil.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTHtmlLoadUtil.h"

@interface HTHtmlLoadUtil ()

@property (nonatomic, copy) NSString *svgHtml;
@property (nonatomic, copy) NSString *iframeHtml;

@end

@implementation HTHtmlLoadUtil

+ (instancetype)sharedInstance {
    static HTHtmlLoadUtil *util;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[HTHtmlLoadUtil alloc] init];
    });
    return util;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *svgPath = [[NSBundle mainBundle] pathForResource:@"logo_load" ofType:@"html"];
        _svgHtml = [NSString stringWithContentsOfFile:svgPath encoding:NSUTF8StringEncoding error:nil];
        
        NSString *iframePath = [[NSBundle mainBundle] pathForResource:@"iframe_load" ofType:@"html"];
        _iframeHtml = [NSString stringWithContentsOfFile:iframePath encoding:NSUTF8StringEncoding error:nil];
    }
    return self;
}

- (NSString *)svgHtmlWithUrl:(NSString *)img_url {
    return [NSString stringWithFormat:self.svgHtml, img_url];
}

- (NSString *)iframHtmlWithContent:(NSString *)iframe_content {
    return [NSString stringWithFormat:self.iframeHtml, SCREEN_WIDTH, iframe_content];
}

@end

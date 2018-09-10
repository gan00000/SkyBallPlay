//
//  HTMatchHomeModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchHomeModel.h"
#import "HTSvgLogoUtil.h"

@implementation HTMatchHomeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"game_id": @"id"
             };
}

- (void)setHomeLogo:(NSString *)homeLogo {
    _homeLogo = homeLogo;
    
    if ([RX(@".svg") isMatch:homeLogo]) {
//        _img_home_logo = [NSString stringWithFormat:@"<!DOCTYPE html><html><body><p><img src=\"%@\"></p></body></html>", homeLogo];
        _img_home_logo = [[HTSvgLogoUtil sharedInstance] htmlWithSrc:homeLogo];
    }
}

- (void)setAwayLogo:(NSString *)awayLogo {
    _awayLogo = awayLogo;
    
    if ([RX(@".svg") isMatch:awayLogo]) {
//        _img_away_logo = [NSString stringWithFormat:@"<!DOCTYPE html><html><body><p><img src=\"%@\"></p></body></html>", awayLogo];
        _img_away_logo = [[HTSvgLogoUtil sharedInstance] htmlWithSrc:awayLogo];
    }
}

@end

//
//  HTMatchSummaryModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchSummaryModel.h"
#import "HTHtmlLoadUtil.h"

@implementation HTMatchSummaryModel

- (void)setHomeLogo:(NSString *)homeLogo {
    _homeLogo = homeLogo;
    
    if ([RX(@".svg$") isMatch:homeLogo]) {
        _img_home_logo = [[HTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:homeLogo width:60];
    }
}

- (void)setAwayLogo:(NSString *)awayLogo {
    _awayLogo = awayLogo;
    
    if ([RX(@".svg$") isMatch:awayLogo]) {
        _img_away_logo = [[HTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:awayLogo width:60];
    }
}

@end

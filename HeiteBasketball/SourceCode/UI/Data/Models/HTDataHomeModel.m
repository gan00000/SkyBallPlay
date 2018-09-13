//
//  HTDataHomeModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/11.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataHomeModel.h"
#import "HTHtmlLoadUtil.h"

@implementation HTDataHomeModel

- (void)setTeam_logo:(NSString *)team_logo {
    _team_logo = team_logo;
    
    if ([RX(@".svg$") isMatch:team_logo]) {
        _html_team_logo = [[HTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:team_logo];
    }
}

@end

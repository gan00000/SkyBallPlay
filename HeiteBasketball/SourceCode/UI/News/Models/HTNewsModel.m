//
//  HTNewsModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsModel.h"
#import "BJDateFormatUtility.h"

@implementation HTNewsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"news_id": @"id"
             };
}

- (NSString *)time {
    if (!_time) {
        _time = [BJDateFormatUtility dateToShowFromDateString:self.date];
    }
    return _time;
}

- (NSString *)view_count {
    if (!_view_count) {
        NSInteger sum = 1000;
        NSArray *views = self.custom_fields[@"views"];
        for (NSString *view in views) {
            sum += view.integerValue;
        }
        _view_count = [NSString stringWithFormat:@"%ld", sum];
    }
    return _view_count;
}

- (NSString *)img_url {
    if (!_img_url) {
        NSString *firstImg = [[RX(@"<img(.*?)src=\"(.*?)\"") matches:self.content] firstObject];
        if (firstImg) {
            _img_url = [[[firstImg componentsSeparatedByString:@"src=\""] lastObject] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        }    
    }
    return _img_url;
}

@end

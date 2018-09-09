//
//  HTNewsModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsModel.h"
#import "BJDateFormatUtility.h"

// TODO: 在set方法中xxxx...
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

- (CGFloat)detailHeaderHeight {
    if (!_detailHeaderHeight) {
        CGFloat titleHeight = [self.title jx_sizeWithFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium] constrainedToWidth:SCREEN_WIDTH-30].height;
        _detailHeaderHeight = titleHeight + 70;
    }
    return _detailHeaderHeight;
}

- (NSString *)news_type {
    if (!_news_type) {
        _news_type = @"新聞";
        if ([RX(@"<iframe>(.*?)</iframe>") isMatch:self.content]) {
            _news_type = @"影片";
        }
    }
    return _news_type;
}

@end

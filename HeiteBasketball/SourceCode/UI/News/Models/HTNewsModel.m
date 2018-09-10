//
//  HTNewsModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsModel.h"
#import "BJDateFormatUtility.h"

@interface HTNewsModel ()

@property (nonatomic, copy) NSString *clearContent;

@end

// TODO: 在set方法中xxxx...
@implementation HTNewsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"news_id": @"id"
             };
}

- (void)setContent:(NSString *)content {
    _content = content;
    
    NSString *firstImg = [[RX(@"<img(.*?)src=\"(.*?)\"") matches:content] firstObject];
    if (firstImg) {
        _img_url = [[[firstImg componentsSeparatedByString:@"src=\""] lastObject] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    }
    
    _iframe = [[RX(@"<iframe>(.*?)</iframe>") matches:content] firstObject];
    _news_type = @"新聞";
    _filmCellHeight = 200;
    if (_iframe) {
        _news_type = @"影片";
        NSInteger width = [[[RX(@"\\d+") matches:[[RX(@"width=\"\\d+\"") matches:_iframe] firstObject]] firstObject] integerValue];
        NSInteger height = [[[RX(@"\\d+") matches:[[RX(@"height=\"\\d+\"") matches:_iframe] firstObject]] firstObject] integerValue];
        _filmCellHeight = SCREEN_WIDTH * height / width;
    }
}

- (void)setDate:(NSString *)date {
    _date = date;
    
    _time = [BJDateFormatUtility dateToShowFromDateString:date];
}

- (void)setCustom_fields:(NSDictionary *)custom_fields {
    _custom_fields = custom_fields;
    
    NSInteger sum = 1000;
    NSArray *views = custom_fields[@"views"];
    for (NSString *view in views) {
        sum += view.integerValue;
    }
    _view_count = [NSString stringWithFormat:@"%ld", sum];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    CGFloat titleHeight = [title jx_sizeWithFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium] constrainedToWidth:SCREEN_WIDTH-30].height;
    _detailHeaderHeight = titleHeight + 70;
}

- (void)getClearContentWithBlock:(void(^)(BOOL success, NSString *content))block {
    block(YES, self.content);
}

@end

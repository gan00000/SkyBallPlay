//
//  HTNewsModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsModel.h"
#import "BJDateFormatUtility.h"
#import "BJHTTPServiceEngine.h"
#import "HTHtmlLoadUtil.h"

@interface HTNewsModel () <NSURLConnectionDelegate>

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
    
    NSString *iframe = [[RX(@"<iframe(.*?)</iframe>") matches:content] firstObject];
    _news_type = @"新聞";
    if (iframe) {
        _news_type = @"影片";
        
        NSInteger width = 0;
        NSString *widthStr = [[RX(@"width\\s*=\\s*\"(.*?)\"|width\\s*:\\s*\\d+") matches:iframe] firstObject];
        if (widthStr) {
            width = [[[RX(@"\\d+") matches:widthStr] firstObject] integerValue];
        }
        
        NSInteger height = 0;
        NSString *heightStr = [[RX(@"height\\s*=\\s*\"(.*?)\"|height\\s*:\\s*\\d+") matches:iframe] firstObject];
        if (heightStr) {
            height = [[[RX(@"\\d+") matches:heightStr] firstObject] integerValue];
        }
        
        if (height == 0 || width == 0) {
            height = 2;
            width = 3;
        }
        
        _iframe_height = SCREEN_WIDTH * height / width;
        CGFloat titleHeiht = [self.title jx_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:SCREEN_WIDTH-30].height;
        _filmCellHeight = _iframe_height + titleHeiht + 75;
        
        iframe = [iframe stringByReplacingOccurrencesOfString:widthStr
                                                   withString:[NSString stringWithFormat:@"width=%ld", (NSInteger)SCREEN_WIDTH]];
        iframe = [iframe stringByReplacingOccurrencesOfString:heightStr
                                                   withString:[NSString stringWithFormat:@"height=%ld", (NSInteger)_iframe_height]];
        
        _iframe = [[HTHtmlLoadUtil sharedInstance] iframHtmlWithContent:iframe];
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
    if (!block) {
        return;
    }
    
    if (self.clearContent) {
        block(YES, self.clearContent);
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:self.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            block(NO, nil);
            return;
        }
        
        NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"onelist\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"next-prev-posts clearfix\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"id=\"footer\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"id=\"header\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"sidebar sidebar-right\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"
                                               withString:@"#"];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"heateorSssSharingRound\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"adsbygoogle\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"to-top\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"post_icon\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"post-content\""
                                               withString:@"class=\"post-content app-hidden-ads\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"post-entry-categories\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"class=\"post-title\""
                                               withString:@" style=\" display: none\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"id=\"recommendedrPosts\""
                                               withString:@"id=\"recommendedrPostsApps\""];
        
        html = [html stringByReplacingOccurrencesOfString:@"plugins/wp-polls"
                                               withString:@"#"];
        
        html = [html stringByReplacingOccurrencesOfString:@"plugins/popups"
                                               withString:@"#"];
        
        html = [html stringByReplacingOccurrencesOfString:@"plugins/adrotate"
                                               withString:@"#"];
        
        html = [html stringByReplacingOccurrencesOfString:@"content-cjtz-mini"
                                               withString:@"app_ad_hidden"];
        
        self.clearContent = html;
        block(YES, self.clearContent);
        
    }];
    [task resume];



}


@end

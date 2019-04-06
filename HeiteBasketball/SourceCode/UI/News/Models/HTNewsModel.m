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
#import <UShareUI/UShareUI.h>
#import <SDWebImage/SDWebImageManager.h>
#import "BJViewControllerCenter.h"

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
        _share_thub = [UIImage imageNamed:@"image_app_icon"];
        if (_img_url.length > 0) {
            _share_thub = _img_url;
        }
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
        
        CGFloat ifram_width = SCREEN_WIDTH - 30;
        _iframe_height = ifram_width * height / width;
        CGFloat titleHeiht = [self.title jx_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:ifram_width].height;
        _filmCellHeight = _iframe_height + titleHeiht + 75;
        
        NSString *newWidhtStr = [RX(@"\\d+") stringByReplacingMatchesInString:widthStr options:kNilOptions range:NSMakeRange(0, widthStr.length) withTemplate:[NSString stringWithFormat:@"%ld", (NSInteger)ifram_width]];
        NSString *newHeightStr = [RX(@"\\d+") stringByReplacingMatchesInString:heightStr options:kNilOptions range:NSMakeRange(0, heightStr.length) withTemplate:[NSString stringWithFormat:@"%ld", (NSInteger)_iframe_height]];
        
        iframe = [iframe stringByReplacingOccurrencesOfString:widthStr
                                                   withString:newWidhtStr];
        iframe = [iframe stringByReplacingOccurrencesOfString:heightStr
                                                   withString:newHeightStr];
        
        NSLog(@"iframe = %@", iframe);
        _iframe = [[HTHtmlLoadUtil sharedInstance] iframHtmlWithContent:iframe];
        NSLog(@"iframe = %@", _iframe);
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
        dispatch_async(dispatch_get_main_queue(), ^{
            block(YES, self.clearContent);
        });
    }];
    [task resume];
}

+ (BOOL)canShare {
    return ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Facebook] && [[UMSocialManager defaultManager] isSupport:UMSocialPlatformType_Facebook]) ||
    ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_FaceBookMessenger] && [[UMSocialManager defaultManager] isSupport:UMSocialPlatformType_FaceBookMessenger]) ||
    ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Line] && [[UMSocialManager defaultManager] isSupport:UMSocialPlatformType_Line]);
}

- (void)share {
    kWeakSelf
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewTitleString = @"分享至";
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        if (platformType == UMSocialPlatformType_Line) {
            //设置文本
            messageObject.text = [NSString stringWithFormat:@"%@\n链接：%@", weakSelf.title, weakSelf.url];
            if (weakSelf.img_url) {
                [BJLoadingHud showHUDInView:[BJViewControllerCenter currentViewController].view];
                [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:weakSelf.img_url] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                    if (image) {
                        //创建图片内容对象
                        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
                        //如果有缩略图，则设置缩略图
                        [shareObject setShareImage:image];
                        //分享消息对象设置分享内容对象
                        messageObject.shareObject = shareObject;
                        [weakSelf doShareToPlatform:platformType withMessage:messageObject];
                    } else {
                        [weakSelf doShareToPlatform:platformType withMessage:messageObject];
                    }
                    [BJLoadingHud hideHUDInView:[BJViewControllerCenter currentViewController].view];
                }];
            } else {
                [weakSelf doShareToPlatform:platformType withMessage:messageObject];
            }
        } else if (platformType == UMSocialPlatformType_Facebook) {
            //创建网页内容对象
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:weakSelf.title descr:nil thumImage:weakSelf.share_thub];
            //设置网页地址
            shareObject.webpageUrl = weakSelf.url;
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            
            [self doShareToPlatform:platformType withMessage:messageObject];
        }
    }];
}

- (void)doShareToPlatform:(UMSocialPlatformType)platformType withMessage:(UMSocialMessageObject *)messageObject {
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[BJViewControllerCenter currentViewController] completion:^(id result, NSError *error) {
        BJLog(@"result = %@", error);
    }];
}


@end

//
//  HTNewsModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTNewsModel : NSObject

@property (nonatomic, copy) NSString *news_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *title_plain;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSDictionary *custom_fields;

@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *view_count;
@property (nonatomic, assign) CGFloat detailHeaderHeight;
@property (nonatomic, copy) NSString *news_type;
@property (nonatomic, copy) NSString *iframe;
@property (nonatomic, assign) CGFloat filmCellHeight;

/// 新闻详情页使用
- (void)getClearContentWithBlock:(void(^)(BOOL success, NSString *content))block;

@end

//
//  BJAPIAddress.h
//  BenjiaPro
//
//  Created by Marco on 2017/6/6.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#ifndef BJAPIAddress_h
#define BJAPIAddress_h

#import "BJServiceConfigurator.h"

#pragma mark - 比賽
#define API_MATCH_HOME                  @"api/get_game_schedule"
#define API_MATCH_LIVE_FEED             @"api/get_live_feed"
#define API_MATCH_SUMMARY               @"api/get_match_summary"

#pragma mark - 新聞
#define API_NEWS_HOME                   @"news"
#define API_NEWS_BANNER                 @"?json=get_app_index"
#define API_NEWS_TOP                    @"api/get_top_posts"
#define API_NEWS_CONTENT                @"news/%@.html"

#pragma mark - 影片
#define API_FILM_HOME                   @"highlight"

#pragma mark - 数据
#define API_DATA_HOME                   @"api/index.php"

#endif








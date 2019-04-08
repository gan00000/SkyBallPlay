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
#define API_MATCH_PROGRESS              @"api/get_match_progress"
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
#define API_PLAYER_RANK                 @"api/get_player_rank"
#define API_PLAYER_RANK_ALL             @"api/get_player_rank_all"
#define API_TEAM_RANK                   @"api/get_team_rank"
#define API_TEAM_RANK_ALL               @"api/get_team_rank_all"

#pragma mark - 排行
#define API_RANK_EAST_WEST              @"api/get_east_west_rank"
#define API_RANK_ZONE                   @"api/get_zone_rank"

#pragma mark - 我的
#define API_USER_LOGIN                  @"api/app_login"
#define API_USER_INFO                   @"api/get_profile"
#define API_USER_UPDATE                 @"api/change_profile"

#endif








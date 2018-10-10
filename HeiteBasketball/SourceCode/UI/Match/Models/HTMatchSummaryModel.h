//
//  HTMatchSummaryModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMatchDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

/*
 "homeLogo": "https://upload.wikimedia.org/wikipedia/en/5/5d/Oklahoma_City_Thunder.svg",
 "homeName": "雷霆",
 "awayName": "雄鹿",
 "awayLogo": "https://upload.wikimedia.org/wikipedia/en/4/4a/Milwaukee_Bucks_logo.svg",
 "homeTeam": "18",
 "awayTeam": "15",
 "date": "2018-10-09",
 "scheduleStatus": "F/OT",
 "away_pts": "115",
 "home_pts": "119",
 "away_quarter_scores": "30,18,24,35,8",
 "home_quarter_scores": "27,28,24,28,12",
 "game_status": "1",
 "quarter": "OT",
 "minutes": "0",
 "seconds": "59",
 "time": "00:59"
 */

@interface HTMatchSummaryModel : NSObject

@property (nonatomic, copy) NSString *homeLogo;
@property (nonatomic, copy) NSString *awayLogo;
@property (nonatomic, copy) NSString *homeName;
@property (nonatomic, copy) NSString *awayName;
@property (nonatomic, copy) NSString *homeTeam;
@property (nonatomic, copy) NSString *awayTeam;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *scheduleStatus;
@property (nonatomic, copy) NSString *away_pts;
@property (nonatomic, copy) NSString *home_pts;
@property (nonatomic, copy) NSString *away_quarter_scores;
@property (nonatomic, copy) NSString *home_quarter_scores;
@property (nonatomic, assign) NSInteger game_status;
@property (nonatomic, copy) NSString *quarter;
@property (nonatomic, copy) NSString *minutes;
@property (nonatomic, copy) NSString *seconds;
@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *img_home_logo;
@property (nonatomic, copy) NSString *img_away_logo;

/// 主队篮板
@property (nonatomic, copy) NSString *home_team_reb;
/// 客队篮板
@property (nonatomic, copy) NSString *away_team_reb;
/// 主隊助攻
@property (nonatomic, copy) NSString *home_team_ast;
/// 客隊助攻
@property (nonatomic, copy) NSString *away_team_ast;
/// 主隊蓋帽
@property (nonatomic, copy) NSString *home_team_blk;
/// 客隊蓋帽
@property (nonatomic, copy) NSString *away_team_blk;
/// 主隊搶斷
@property (nonatomic, copy) NSString *home_team_stl;
/// 客隊搶斷
@property (nonatomic, copy) NSString *away_team_stl;
/// 主隊命中率
@property (nonatomic, copy) NSString *home_team_fgmade;
/// 可以命中率
@property (nonatomic, copy) NSString *away_team_fgmade;
/// 主隊3分命中率
@property (nonatomic, copy) NSString *home_team_fg3ptmade;
/// 客隊3分命中率
@property (nonatomic, copy) NSString *away_team_fg3ptmade;
/// 主隊罰籃命中率
@property (nonatomic, copy) NSString *home_team_ftmade;
/// 客隊罰籃命中率
@property (nonatomic, copy) NSString *away_team_ftmade;

/// 主隊得分最高球員
@property (nonatomic, weak) HTMatchDetailsModel *home_team_pts_most;
/// 客隊得分最高球員
@property (nonatomic, weak) HTMatchDetailsModel *away_team_pts_most;
/// 主隊助攻最高球員
@property (nonatomic, weak) HTMatchDetailsModel *home_team_ast_most;
/// 客隊助攻最高球員
@property (nonatomic, weak) HTMatchDetailsModel *away_team_ast_most;
/// 主隊籃板最高球員
@property (nonatomic, weak) HTMatchDetailsModel *home_team_reb_most;
/// 客隊籃板最高球員
@property (nonatomic, weak) HTMatchDetailsModel *away_team_reb_most;

@end

NS_ASSUME_NONNULL_END

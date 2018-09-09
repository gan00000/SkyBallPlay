//
//  HTMatchHomeModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMatchHomeModel : NSObject

@property (nonatomic, copy) NSString *game_id;
@property (nonatomic, copy) NSString *scheduleStatus;
@property (nonatomic, copy) NSString *originalDate;
@property (nonatomic, copy) NSString *originalTime;
@property (nonatomic, copy) NSString *delayedOrPostponedReason;
@property (nonatomic, copy) NSString *gametime;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *awayTeam;
@property (nonatomic, copy) NSString *homeTeam;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *season_name;
@property (nonatomic, assign) NSInteger game_status;
@property (nonatomic, copy) NSString *homeLogo;
@property (nonatomic, copy) NSString *homeName;
@property (nonatomic, copy) NSString *awayName;
@property (nonatomic, copy) NSString *awayLogo;
@property (nonatomic, copy) NSString *homeAbbr;
@property (nonatomic, copy) NSString *awayAbbr;
@property (nonatomic, copy) NSString *away_pts;
@property (nonatomic, copy) NSString *home_pts;
@property (nonatomic, copy) NSString *gamedate;

@end


/*
 "id": "12425",
 "scheduleStatus": "Final",
 "originalDate": "",
 "originalTime": "",
 "delayedOrPostponedReason": "",
 "gametime": "07:00AM",
 "date": "2018-04-27",
 "time": "07:00PM",
 "awayTeam": "10",
 "homeTeam": "1",
 "location": "",
 "season_name": "2018POST",
 "game_status": "1",
 "homeLogo": "https://upload.wikimedia.org/wikipedia/en/0/02/Washington_Wizards_logo.svg",
 "homeName": "巫師",
 "awayName": "暴龍",
 "awayLogo": "https://upload.wikimedia.org/wikipedia/en/thumb/3/36/Toronto_Raptors_logo.svg/200px-Toronto_Raptors_logo.svg.png",
 "homeAbbr": "",
 "awayAbbr": "",
 "away_pts": "102",
 "home_pts": "92",
 "gamedate": "2018-04-28"
 */

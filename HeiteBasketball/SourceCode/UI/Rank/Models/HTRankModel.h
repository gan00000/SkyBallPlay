//
//  HTRankModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "rank": "1",
 "teamId": "10",
 "division": "1",
 "pts": "1070",
 "wins": "4",
 "losses": "6",
 "ptsagainst": "1120",
 "gamesplayed": "10",
 "season_name": "2018",
 "id": "10",
 "name": "Raptors",
 "ch_name": "暴龍",
 "city": "Toronto",
 "ch_city": null,
 "logo": null,
 "abbreviation": "",
 "team_logo": "https://upload.wikimedia.org/wikipedia/en/thumb/3/36/Toronto_Raptors_logo.svg/200px-Toronto_Raptors_logo.svg.png",
 "teamName": "暴龍",
 "homewin": "3",
 "homelose": "2",
 "awaywin": "1",
 "awaylose": "4"
 
 
 "division": "1",
 "teamId": "10",
 "rank": "1",
 "pts": "1070",
 "wins": "4",
 "Losses": "6",
 "PtsAgainst": "1120",
 "GamesPlayed": "10",
 "season_name": "2018",
 "id": "10",
 "name": "Raptors",
 "ch_name": "暴龍",
 "city": "Toronto",
 "ch_city": null,
 "logo": null,
 "abbreviation": "",
 "team_logo": "https://upload.wikimedia.org/wikipedia/en/thumb/3/36/Toronto_Raptors_logo.svg/200px-Toronto_Raptors_logo.svg.png",
 "teamName": "暴龍",
 "homewin": "3",
 "homelose": "2",
 "awaywin": "1",
 "awaylose": "4"
 */

@interface HTRankModel : NSObject

@property (nonatomic, copy) NSString *division;
@property (nonatomic, copy) NSString *teamId;
@property (nonatomic, copy) NSString *rank;
@property (nonatomic, copy) NSString *pts;
@property (nonatomic, copy) NSString *wins;
@property (nonatomic, copy) NSString *Losses;
@property (nonatomic, copy) NSString *PtsAgainst;
@property (nonatomic, copy) NSString *GamesPlayed;
@property (nonatomic, copy) NSString *season_name;
@property (nonatomic, copy) NSString *rank_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ch_name;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *ch_city;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *abbreviation;
@property (nonatomic, copy) NSString *team_logo;
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *homewin;
@property (nonatomic, copy) NSString *homelose;
@property (nonatomic, copy) NSString *awaywin;
@property (nonatomic, copy) NSString *awaylose;

@end

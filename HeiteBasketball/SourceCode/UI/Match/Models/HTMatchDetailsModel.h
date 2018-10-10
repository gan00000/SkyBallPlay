//
//  HTMatchDetailsModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 "gameId": "13755",
 "playerId": "20001822",
 "teamId": "8",
 "fgatt": "16",  // 投籃次數
 "pts": "19",
 "fg3ptmade": "3",
 "fg3ptatt": "5",
 "minseconds": "2393",
 "fgmade": "8",
 "ast": "4",
 "reb": "5",
 "ftatt": "0",
 "ftmade": "0",
 "offreb": "5",
 "defreb": "0",
 "fouls": "4",
 "blk": "1",
 "stl": "1",
 "blkagainst": "2",
 "plusminus": "10",
 "id": "20001822",
 "lastname": "Diallo",
 "firstname": "Hamidou",
 "jerseynumber": "",
 "position": "SG",
 "height": "77",
 "weight": "197",
 "birthdate": "1998-07-31T00:00:00",
 "age": "",
 "birthcity": "",
 "birthcountry": "",
 "isrookie": "",
 "isroster": null,
 "isactive": null,
 "officialImagesrc": "https://s3-us-west-2.amazonaws.com/static.fantasydata.com/headshots/nba/low-res/0.png",
 "isStarter": "1"
 */

@interface HTMatchDetailsModel : NSObject

@property (nonatomic, copy) NSString *gameId;
@property (nonatomic, copy) NSString *playerId;
@property (nonatomic, copy) NSString *teamId;
@property (nonatomic, copy) NSString *pts;
@property (nonatomic, copy) NSString *minseconds;
@property (nonatomic, copy) NSString *ast;
@property (nonatomic, copy) NSString *reb;
@property (nonatomic, copy) NSString *offreb;
@property (nonatomic, copy) NSString *defreb;
@property (nonatomic, copy) NSString *fouls;
@property (nonatomic, copy) NSString *blk;
@property (nonatomic, copy) NSString *stl;
@property (nonatomic, copy) NSString *blkagainst;
@property (nonatomic, copy) NSString *plusminus;
@property (nonatomic, copy) NSString *detail_id;
@property (nonatomic, copy) NSString *lastname;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *jerseynumber;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *birthdate;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *birthcity;
@property (nonatomic, copy) NSString *birthcountry;
@property (nonatomic, copy) NSString *isrookie;
@property (nonatomic, copy) NSString *isroster;
@property (nonatomic, copy) NSString *isactive;
@property (nonatomic, copy) NSString *officialImagesrc;
@property (nonatomic, copy) NSString *isStarter;

// 投籃
@property (nonatomic, copy) NSString *fgatt;
@property (nonatomic, copy) NSString *fgmade;
/// 投籃
@property (nonatomic, copy) NSString *fgmade_show;
// 三分
@property (nonatomic, copy) NSString *fg3ptatt;
@property (nonatomic, copy) NSString *fg3ptmade;
/// 三分
@property (nonatomic, copy) NSString *fg3ptmade_show;
// 發球
@property (nonatomic, copy) NSString *ftatt;
@property (nonatomic, copy) NSString *ftmade;
/// 發球
@property (nonatomic, copy) NSString *ftmade_show;
@property (nonatomic, copy) NSString *name;


@end

NS_ASSUME_NONNULL_END

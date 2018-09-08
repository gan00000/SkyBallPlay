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

#pragma mark - 本家艺学会 API

#define API_HOME_INFO                                     @"home"
#define API_HOME_FREE                                     @"freezone"
#define API_HOME_FREE_MORE                                @"freelist"
#define API_HOME_SEARCH                                   @"searchallcourse"

// 已购
#define API_BUY_COURSE                                    @"getbuycourse"
#define API_BUY_VOICE                                     @"getbuyvoice"
#define API_GET_VOICE                                     @"getvoice"

//大咖问答
#define API_QA_EXPERTS                                    @"qaexperts"
#define API_HOTQALIST                                     @"hotqalist"
#define API_LOADMORE_EXPERTS                              @"loadmoreexperts"
#define API_GETEXPERTINFO                                 @"getexpertinfo"
#define API_EXLERT_QALIST                                 @"expertsqalist"
#define API_ATTENTIONTO                                   @"attentionto"
#define API_ASKQUESTIONS                                  @"askquestions"
#define API_EXPERTS_SEARCH                                @"searchallqa"
#define API_EXPERTS_ANSWER                                @"expertsanswer"

#define API_LIVE_LIST                                     @"LiveList"
#define API_LIVE_DETAIL                                   @"LiveDetail"
#define API_LIVE_CONFIG                                   @"GetLiveConfig"
#define API_LIVE_CHANNEL_LIST                             @"GetLiveChannelsList"

#define API_VIDEO_INFO                                    @"GetVideoConfig"
#define API_VIDEO_SERCH                                   @"SearchVideoList"

// 专栏
#define API_CLASS_FICATION                                @"classification"
#define API_AUTHORITY                                     @"authority"

//用户
#define API_SENDSMS                                      @"SendSMS"
#define API_LOGIN                                        @"Login"
#define API_LOGOUT                                       @"logout"
#define API_TOKENTOLOGIN                                 @"tokentologin"
#define API_UPLOADINFO                                   @"updateinfo"
#define API_UPDATEPHONE                                  @"updatephone"
#define API_GETMYBALANCE                                 @"getmybalance"
#define API_GETMYCOLLECTION                              @"getmycollection"
#define API_DELMYCOLLECTION                              @"delmycollection"
#define API_GETMYLISTENTO                                @"getmylistento"
#define API_GET_TOPUP_LIST                               @"gettopuplist"
#define API_TOPUP                                        @"topup"
#define API_GETMYQARECIRD                                @"getmyqarecord"
#define API_DELMYLISTENTO                                @"delmylistento"

//音，视屏
#define API_GETALBUNINFO                                  @"getalbuminfo"
#define API_GETCOURSELIST                                 @"getcourselist"
#define API_GETVIDEOPLAYAUTH                              @"getvideoplayauth"
#define API_PLAYPAGE                                      @"playpage"
#define API_COMMENTS                                      @"comments"
#define API_SEND_COMMENTS                                 @"sendcomments"
#define API_GETALBUMBYTEACHERID                           @"getalbumbyteacherid"
#define API_BUYALBUM                                      @"buyalbum"
#define API_COLLECTION                                    @"collection"

//内购证书认证接口
#define API_VALIDATEAPPLEPAY                              @"validateapplepay"
#define API_ADDAPPLEPAY                                   @"addapplepay"


#pragma mark - H5页面地址
#define H5ADDRESS(address) [NSString stringWithFormat:@"%@%@", [[BJServiceConfigurator sharedInstance] h5BaseUrl], address]


#endif /* BJAPIAddress_h */








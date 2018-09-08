//
//  BJDateFormatUtility.h
//  BenjiaPro
//
//  Created by JZ_Stone on 2017/9/18.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Core.h"

@interface BJDateFormatUtility : NSObject

/*
 *  得到用于显示的时间，如 12:33， 昨天10:21， 9月18日 10:31
 *
 *  @param date 来自后台需要转换的原始时间
 *  @return 用于显示的时间
 */
+ (NSString *)dateToShowFromDate:(NSDate *)date;

/*
 *  得到用于显示的时间，如 12:33， 昨天10:21， 9月18日 10:31
 *
 *  @param date 来自后台需要转换的原始时间字符串
 *  @param dateFormat 来自后台时间的时间格式 如 MM/dd/YYYY HH:mm:ss
 *  @return 用于显示的时间
 */
+ (NSString *)dateToShowFromDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

/*
 *  得到用于显示的时间，如 12:33， 昨天10:21， 9月18日 10:31
 *
 *  @param date 来自后台需要转换的原始时间
 *  @return 用于显示的时间
 */
+ (NSString *)dateToShowFromTimeInterval:(NSTimeInterval)timeInterval;

@end

//
//  BJDateFormatUtility.m
//  BenjiaPro
//
//  Created by JZ_Stone on 2017/9/18.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJDateFormatUtility.h"

@implementation BJDateFormatUtility

/*
 *  得到用于显示的时间，如 12:33， 昨天10:21， 9月18日 10:31
 *
 *  @param date 来自后台需要转换的原始时间
 *  @return 用于显示的时间
 */
+ (NSString *)dateToShowFromDate:(NSDate *)date {
    if (!date || ![date isKindOfClass:[NSDate class]]) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if(date.isThisYear)
    {
        if (date.isToday)
        {
            // 当前时间
            NSDate *nowDate = [NSDate date];
            // 日历对象
            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:nowDate options:0];
            if (cmps.hour >= 1) // 时间间隔 >= 1个小时
            {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }
            else if (cmps.minute >= 1) // 1个小时 > 时间间隔 >= 1分钟
            {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            }
            else
            {
                return @"刚刚";
            }
        }
        else if (date.isYesterday)
        {
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:date];
        }
        else
        {
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:date];
        }
    }
    else
    {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [formatter stringFromDate:date];
    }
}

/*
 *  得到用于显示的时间，如 12:33， 昨天10:21， 9月18日 10:31
 *
 *  @param date 来自后台需要转换的原始时间
 *  @param dateFormat 来自后台时间的时间格式 如 MM/dd/YYYY HH:mm:ss
 *  @return 用于显示的时间
 */
+ (NSString *)dateToShowFromDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    return [BJDateFormatUtility dateToShowFromDate:[formatter dateFromString:dateString]];
}

/*
 *  得到用于显示的时间，如 12:33， 昨天10:21， 9月18日 10:31
 *
 *  @param date 来自后台需要转换的原始时间
 *  @return 用于显示的时间
 */
+ (NSString *)dateToShowFromTimeInterval:(NSTimeInterval)timeInterval {
    return [BJDateFormatUtility dateToShowFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

@end

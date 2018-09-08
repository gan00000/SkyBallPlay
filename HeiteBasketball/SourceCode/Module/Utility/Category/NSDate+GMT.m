//
//  NSDate+GMT.m
//  Exchange
//
//  Created by Marco on 2017/3/21.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import "NSDate+GMT.h"

@implementation NSDate (GMT)

- (NSString *)dateStringOfEast8WithFormat:(NSString *)format {
    NSTimeZone *GTMZone = [NSTimeZone timeZoneForSecondsFromGMT:60 * 60 * 8];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:GTMZone];
    return [dateFormatter stringFromDate:self];
}

@end

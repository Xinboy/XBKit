//
//  NSDate+XBCategory.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/28.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSDate *)endDayAfterNowWithIntervals:(CGFloat)intervals {
    NSDate * date = [NSDate date];
    
    if (intervals == 0) {
        return date;
    }
    NSTimeInterval timeInterval = 24 * 60 * 60 * 1;
    date = [date initWithTimeIntervalSinceNow:timeInterval * intervals];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay| NSCalendarUnitWeekday fromDate:date];
    
    return date;
}

+ (NSInteger)fetchWeekDay:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay| NSCalendarUnitWeekday fromDate:date];
    
    return components.weekday - 1;
}
+ (NSDateComponents *)fetchComponent:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay| NSCalendarUnitWeekday fromDate:date];
    return components;
}

#pragma mark - **************** 时间戳相关
//获得时间戳
+ (NSString *)stringWithTimeStamp {
    NSDate *date = [NSDate date];
    return [NSString stringWithFormat:@"%ld",(NSInteger)[date timeIntervalSince1970]];
}

//数据库时间字段转时间戳
+ (NSString *)timeStampWithTimeString:(NSString *)timeString {
    if (timeString.length > 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *versionData = [formatter dateFromString:timeString];
        return [NSString stringWithFormat:@"%ld",(NSInteger)[versionData timeIntervalSince1970]];
    } else {
        return @"";
    }
}
//时间戳转时间字符串
+  (NSString *)timeStringWithTimeStmap:(NSString *)timeStamp {
    if (timeStamp.length > 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp.integerValue];
        return [formatter stringFromDate:date];
    } else {
        return @"";
    }
    
}

@end

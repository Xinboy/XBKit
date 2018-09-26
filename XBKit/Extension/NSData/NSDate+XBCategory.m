//
//  NSDate+XBCategory.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/28.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "NSDate+XBCategory.h"

@implementation NSDate (XBCategory)

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

@end

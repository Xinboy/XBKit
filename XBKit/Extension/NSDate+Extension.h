//
//  NSDate+XBCategory.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/28.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDate (Extension)

+ (NSDate *)endDayAfterNowWithIntervals:(CGFloat)intervals;

+ (NSInteger)fetchWeekDay:(NSDate *)date;

+ (NSDateComponents *)fetchComponent:(NSDate *)date;


/**
 时间戳：将当前时间转换为时间戳
 
 @return 当前时间的时间戳字符串
 */
+ (NSString *)stringWithTimeStamp;

/**
 时间戳：根据传入时间字符串转换为时间戳
 
 @param timeString 时间字符串
 @return 传入时间字符串对应的时间戳
 */
+ (NSString *)timeStampWithTimeString:(NSString *)timeString;

/**
 时间戳：根据传入时间戳字符串转换为时间字符串（格式：yyyy-MM-dd HH:mm:ss）
 
 @param timeStamp 时间戳字符串
 @return 传入 时间戳字符串对应的时间字符串
 */
+ (NSString *)timeStringWithTimeStmap:(NSString *)timeStamp;
@end

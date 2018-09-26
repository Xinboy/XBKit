//
//  NSDate+XBCategory.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/28.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDate (XBCategory)

+ (NSDate *)endDayAfterNowWithIntervals:(CGFloat)intervals;

+ (NSInteger)fetchWeekDay:(NSDate *)date;

+ (NSDateComponents *)fetchComponent:(NSDate *)date;
@end

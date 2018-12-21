//
//  NSDate+GF.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LATER_DATE(a, b)            a = a?[a laterDate:b]:b

@interface NSDate (GF)

@property (readonly) NSTimeInterval timeIntervalToNow;

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                    hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)week;
- (NSInteger)weekDay;

- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;

- (BOOL)sameYearTo:(NSDate *)date;
- (BOOL)sameMonthTo:(NSDate *)date;
- (BOOL)sameDayTo:(NSDate *)date;

- (long)secondsSince1970;

- (NSDate *)startDateOfThisDay;

- (NSDate *)endDateOfThisDay;

@end

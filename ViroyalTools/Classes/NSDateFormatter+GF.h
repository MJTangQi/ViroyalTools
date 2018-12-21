//
//  NSDateFormatter+GF.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (GF)

- (NSString *)shortDayStringFromDate:(NSDate *)date;

- (NSString *)shortTimeStringFromDate:(NSDate *)date;

- (NSString *)shortDayTimeStringFromDate:(NSDate *)date;

- (NSString *)shortTimeStringFromTimeInterval:(NSTimeInterval)interval;

- (NSString *)clockTimeStringFromTimeInterval:(NSTimeInterval)interval;

- (NSString *)smartDayTimeStringFromDate:(NSDate *)date;

@end

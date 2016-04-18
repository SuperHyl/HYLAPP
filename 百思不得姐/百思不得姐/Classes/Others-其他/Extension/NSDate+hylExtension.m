//
//  NSDate+hylExtension.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/13.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "NSDate+hylExtension.h"

@implementation NSDate (hylExtension)

/**
 *  比较fromDate和self的时间差值
 */
- (NSDateComponents *)differTimeFromDate:(NSDate *)fromDate
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:fromDate toDate:self options:0];
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
    
}

/**
 *  是否为今天
 */
- (BOOL)isToday
{
    /*
//    // 日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |
//    NSCalendarUnitDay;
//    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
//    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
//    
//    return nowComponents.year == selfComponents.year
//    && nowComponents.month == selfComponents.month
//    && nowComponents.day == selfComponents.day;
    */
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [formatter stringFromDate:[NSDate date]];
    NSString *selfString = [formatter stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    // 日期格式化类
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]];
    
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

    NSDateComponents *components = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    //
//    NSDateComponents *components = [[NSDate date] differTimeFromDate:self];
    
    return components.year == 0 && components.month == 0 && components.day == 1;
}

@end

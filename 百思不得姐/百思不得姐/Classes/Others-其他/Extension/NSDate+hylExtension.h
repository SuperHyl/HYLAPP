//
//  NSDate+hylExtension.h
//  百思不得姐
//
//  Created by SuperHyl on 16/4/13.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (hylExtension)

/**
 *  比较startTime和self的时间差值
 */
- (NSDateComponents *)differTimeFromDate:(NSDate *)fromDate;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;


@end

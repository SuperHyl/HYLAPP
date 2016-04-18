//
//  hylRecommendCategory.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/2.
//  Copyright © 2016年 hyl. All rights reserved.
//  推荐关注，左边的数据模型

#import "hylRecommendCategory.h"
#import <MJExtension.h>

@implementation hylRecommendCategory

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    if ([key isEqualToString:@"id"]) {
//        self.ID = value;
//    }
//}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)userArray {
    if (!_userArray) {
        self.userArray = [NSMutableArray array];
    }
    return _userArray;
}

@end

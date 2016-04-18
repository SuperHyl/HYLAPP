//
//  hylRecommendUser.h
//  百思不得姐
//
//  Created by SuperHyl on 16/4/5.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hylRecommendUser : NSObject

@property (copy, nonatomic) NSString *header; // 头像
@property (assign, nonatomic) NSInteger fans_count; // 粉丝数
@property (copy, nonatomic) NSString *screen_name; // 昵称

@end

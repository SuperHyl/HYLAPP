//
//  hylRecommendCategory.h
//  百思不得姐
//
//  Created by SuperHyl on 16/4/2.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hylRecommendCategory : NSObject

@property (assign, nonatomic) NSInteger ID; // id
@property (assign, nonatomic) NSInteger count; // 数量
@property (copy, nonatomic) NSString *name; // 名字

@property (strong, nonatomic) NSMutableArray *userArray; // 对应类别的左边用户数组

//@property (assign, nonatomic) NSInteger total_page; // 总页数
@property (assign, nonatomic) NSInteger total; // 总数
@property (assign, nonatomic) NSInteger currentPage; // 当前页码

@end

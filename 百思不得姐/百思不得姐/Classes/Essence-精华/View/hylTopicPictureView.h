//
//  hylTopicPictureView.h
//  百思不得姐
//
//  Created by SuperHyl on 16/4/14.
//  Copyright © 2016年 hyl. All rights reserved.
//  图片帖子中间的内容

#import <UIKit/UIKit.h>
@class hylTopic;

@interface hylTopicPictureView : UIView

+ (instancetype)pictureView;

@property (strong, nonatomic) hylTopic *topic; // 帖子数据模型

@end

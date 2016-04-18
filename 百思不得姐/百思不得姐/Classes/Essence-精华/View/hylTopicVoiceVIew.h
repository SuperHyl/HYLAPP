//
//  hylTopicVoiceVIew.h
//  百思不得姐
//
//  Created by SuperHyl on 16/4/18.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class hylTopic;

@interface hylTopicVoiceVIew : UIView

+ (instancetype)voiceView;

@property (strong, nonatomic) hylTopic *topic; // 帖子数据模型

@end

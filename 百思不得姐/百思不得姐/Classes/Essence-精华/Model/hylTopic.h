//
//  hylTopic.h
//  百思不得姐
//
//  Created by SuperHyl on 16/4/12.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hylTopic : NSObject

@property (copy, nonatomic) NSString *name; // 用户名
@property (copy, nonatomic) NSString *profile_image; // 头像的URL
@property (copy, nonatomic) NSString *created_at; // 发贴时间
@property (copy, nonatomic) NSString *text; // 文字内容
@property (copy, nonatomic) NSString *small_image; // 小图片的URL
@property (copy, nonatomic) NSString *large_image; // 大图片的URL
@property (copy, nonatomic) NSString *middle_image; // 中图片的URL
@property (assign, nonatomic) NSInteger voicetime; // 音频时长
@property (assign, nonatomic) NSInteger playcount; // 播放次数
@property (assign, nonatomic) NSInteger videotime; // 视频时长

@property (assign, nonatomic) NSInteger ding; // 顶的数量
@property (assign, nonatomic) NSInteger cai; // 踩的数量
@property (assign, nonatomic) NSInteger repost; // 转发的数量
@property (assign, nonatomic) NSInteger comment; // 评论的数量
@property (assign, nonatomic) CGFloat width; // 图片的宽度
@property (assign, nonatomic) CGFloat height; // 图片的高度
@property (assign, nonatomic) HYLTopicType type; // 帖子的类型
@property (assign, nonatomic, getter=isSina_v) BOOL sina_v; // 是否为新浪的加V用户

// 额外的辅助属性
@property (assign, nonatomic, readonly) CGFloat cellHeight; // cell的高度
@property (assign, nonatomic, readonly) CGRect pictureViewFrame; // 图片控件的frame

@property (assign, nonatomic, getter=isBigPicture) BOOL bigPicture; // 图片是否过长
@property (assign, nonatomic) CGFloat pictureProress; // 图片的下载进度

@property (assign, nonatomic, readonly) CGRect voiceViewFrame; // 声音控件的frame
@property (assign, nonatomic, readonly) CGRect videoViewFrame; // 视频控件的frame

@end

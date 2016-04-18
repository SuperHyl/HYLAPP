//
//  hylTopic.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/12.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylTopic.h"
#import <MJExtension.h>

@implementation hylTopic

{
    CGFloat _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

- (NSString *)created_at
{
    // 日期格式类
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年, M:月, d:日, H:小时, m:分钟, s:秒)
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 发帖时间
    NSDate *createTime = [formatter dateFromString:_created_at];
    
    if (createTime.isThisYear) { // 今年
        
        if (createTime.isToday) { // 今天
            NSDateComponents *components = [[NSDate date] differTimeFromDate:createTime];
            if (components.minute <= 1) { // 时间差 <= 1分钟
                return @"刚刚";
            } else if (components.hour < 1) { // 时间差 < 1小时
                return [NSString stringWithFormat:@"%zd分钟前", components.minute];
            } else { // 时间差 > 1小时
                return [NSString stringWithFormat:@"%zd小时前", components.hour];
            }
        } else if (createTime.isYesterday) { // 昨天
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:createTime];
        } else { // 其他
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:createTime];
        }
    } else { // 其他年
        formatter.dateFormat = @"yyyy-MM-dd";
        return [formatter stringFromDate:createTime];
    }
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * HYLTopicCellMargin, MAXFLOAT);
        // 计算文字的高度
        CGFloat textHeight = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        // cell的高度
        // 文字部分的高度
        _cellHeight = HYLTopicCellTextY + textHeight + HYLTopicCellMargin;
        
        // 根据段子的类型来计算cell的高度
        if (self.type == HYLTopicTypePicture) { // 图片
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            // 图片显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            
            if (pictureH >= HYLTopicCellPictureMaxH) { // 图片过长
                pictureH = HYLTopicCellPictureH;
                self.bigPicture = YES;
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = HYLTopicCellMargin;
            CGFloat pictureY = HYLTopicCellTextY + textHeight + HYLTopicCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);

            _cellHeight += pictureH + HYLTopicCellMargin;
            
        } else if (self.type == HYLTopicTypeVoice) { // 声音帖子
            CGFloat voiceX = HYLTopicCellMargin;
            CGFloat voiceY = HYLTopicCellTextY + textHeight + HYLTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceViewFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + HYLTopicCellMargin;
            
        } else if (self.type == HYLTopicTypeVideo) { // 视频帖子
            CGFloat videoX = HYLTopicCellMargin;
            CGFloat videoY = HYLTopicCellTextY + textHeight + HYLTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoViewFrame = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + HYLTopicCellMargin;
            
        }
        
        // 底部按钮工具条的高度
        _cellHeight += HYLTopicCellMargin + HYLTopicCellBottomBarH;
    }

    return _cellHeight;
}

@end

//
//  hylTopicCell.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/12.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylTopicCell.h"
#import "hylTopic.h"
#import <UIImageView+WebCache.h>
#import "hylTopicPictureView.h"
#import "hylTopicVoiceVIew.h"
#import "hylTopicVideoView.h"

@interface hylTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView; // 头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; // 用户名
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel; // 发表时间
@property (weak, nonatomic) IBOutlet UIButton *dingButton; // 顶
@property (weak, nonatomic) IBOutlet UIButton *caiButton; // 踩
@property (weak, nonatomic) IBOutlet UIButton *shareButton; // 分享
@property (weak, nonatomic) IBOutlet UIButton *commentButton; // 评论
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView; // 新浪加V
@property (weak, nonatomic) IBOutlet UILabel *text_label; // 帖子的文字内容
@property (weak, nonatomic) hylTopicPictureView *pictureView; // 图片帖子中间的图片
@property (weak, nonatomic) hylTopicVoiceVIew *voiceView; // 声音帖子中间的图片
@property (weak, nonatomic) hylTopicVideoView *videoView; // 视频帖子中间的图片

@end


@implementation hylTopicCell

- (hylTopicPictureView *)pictureView
{
    if (!_pictureView) {
        hylTopicPictureView *pictureView = [hylTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (hylTopicVoiceVIew *)voiceView
{
    if (!_voiceView) {
        hylTopicVoiceVIew *voiceView = [hylTopicVoiceVIew voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (hylTopicVideoView *)videoView
{
    if (!_videoView) {
        hylTopicVideoView *videoView = [hylTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib
{
    // 设置cell的背景图片
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    
    self.backgroundView = bgView;
}

- (void)setTopic:(hylTopic *)topic
{
    _topic = topic;
    
    // 设置新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    // 设置用户名
    self.nameLabel.text = topic.name;
    
    // 设置发帖时间
    self.createTimeLabel.text = topic.created_at;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
  
    // 设置帖子的文字内容
    self.text_label.text = topic.text;
    
    /*
//    [self.dingButton setTitle:[NSString stringWithFormat:@"%zd", topic.ding] forState:UIControlStateNormal];
//    [self.caiButton setTitle:[NSString stringWithFormat:@"%zd", topic.cai] forState:UIControlStateNormal];
//    [self.shareButton setTitle:[NSString stringWithFormat:@"%zd", topic.repost] forState:UIControlStateNormal];
//    [self.commentButton setTitle:[NSString stringWithFormat:@"%zd", topic.comment] forState:UIControlStateNormal]; */
    
    // 根据模型类型(贴子类型)添加对应的图片内容到cell的中间
    if (topic.type == HYLTopicTypePicture) { // 图片帖子
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
    } else if (topic.type == HYLTopicTypeVoice) { // 声音帖子
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceViewFrame;
    } else if (topic.type == HYLTopicTypeVideo) { // 视频帖子
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoViewFrame;
    }
    
    
}

/*
//- (void)testDate:(NSString *)create_time
//{
//    // 日期格式类
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    // 设置日期格式(y:年, M:月, d:日, H:小时, m:分钟, s:秒)
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    
//    // 当前时间
//    NSDate *now = [NSDate date];
//    // 发帖时间
//    NSDate *create = [formatter dateFromString:create_time];
//    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    // 得到相差的时间(以秒为单位)
//    NSTimeInterval delta = [now timeIntervalSinceDate:create];
//} */

// 设置button的title的方法
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    /*
//    NSString *title = nil;
//    if (count > 10000) {
//        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
//    } else {
//        title = [NSString stringWithFormat:@"%zd", count];
//    }
//    [button setTitle:title forState:UIControlStateNormal];
    */
     
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count){
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = HYLTopicCellMargin;
    frame.origin.y += HYLTopicCellMargin;
    frame.size.width -= 2 * HYLTopicCellMargin;
    frame.size.height -= HYLTopicCellMargin;
    
    [super setFrame:frame];
}

- (void)testDate:(NSString *)create_time
{
    // 日期格式类
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年, M:月, d:日, H:小时, m:分钟, s:秒)
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // 当前时间
    NSDate *nowTime = [NSDate date];
    // 发帖时间
    NSDate *createTime = [formatter dateFromString:create_time];
    
    
    
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *comps = [calendar components:unit fromDate:createTime toDate:nowTime options:0];
    
    /*
    // 获取NSDate的每一个元素
    //    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:now];
    //    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:create];
    //    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:now];
    
    //    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
    */
     
    HYLLog(@"%zd 年 %zd 月 %zd 日", comps.year, comps.month, comps.day);
    
}

@end

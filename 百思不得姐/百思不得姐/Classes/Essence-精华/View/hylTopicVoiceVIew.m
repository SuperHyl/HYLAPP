//
//  hylTopicVoiceVIew.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/18.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylTopicVoiceVIew.h"
#import "hylTopic.h"
#import <UIImageView+WebCache.h>
#import "hylshowPictureViewController.h"

@interface hylTopicVoiceVIew()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end

@implementation hylTopicVoiceVIew

+(instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加点击方法
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    hylshowPictureViewController *showPicture = [[hylshowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    // 在不是控制器的View中推出控制器，要先回到根视图控制器
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(hylTopic *)topic
{
    _topic = topic;
    
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd次播放", topic.playcount];
    // 声音时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}

@end

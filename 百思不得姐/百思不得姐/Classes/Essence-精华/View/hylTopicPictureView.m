//
//  hylTopicPictureView.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/14.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylTopicPictureView.h"
#import "hylTopic.h"
#import <UIImageView+WebCache.h>
#import <M13ProgressViewRing.h>
#import "hylshowPictureViewController.h"

@interface hylTopicPictureView()

@property (strong, nonatomic) IBOutlet UIImageView *ImageView; // 图片
@property (strong, nonatomic) IBOutlet UIImageView *gifView; // GIF标识
@property (strong, nonatomic) IBOutlet UIButton *seeBigButton; // 查看大图按钮
@property (strong, nonatomic) IBOutlet M13ProgressViewRing *progressView; // 进度条控件

@end

@implementation hylTopicPictureView

+(instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 设置progressView的属性
//    self.progressView.roundedCorners = 10;
//    self.progressView.progressLabel.font = [UIFont systemFontOfSize:13];
//    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    // 给图片添加点击方法
    self.ImageView.userInteractionEnabled = YES;
    [self.ImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
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
    
    // 立马显示最新的进度值(防止因为网速慢，导致显示的是重用的其他的图片的下载进度)
    [self.progressView setProgress:topic.pictureProress animated:NO];
    
    // 设置图片
//    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        // 计算进度值
        topic.pictureProress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:topic.pictureProress animated:YES];
        
//        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress *100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        // 如果是大图片，才需要进行绘图处理
        if (topic.isBigPicture == NO) return;
        
        // 开启图形上下文
//        UIGraphicsBeginImageContextWithOptions(topic.pictureViewFrame.size, YES, 0.0);
//        // 将下载完的image对象绘制到图形上下文
//        CGFloat width = topic.pictureViewFrame.size.width;
//        CGFloat height = width * image.size.height / image.size.width;
//        [image drawAsPatternInRect:CGRectMake(0, 0, width, height)];
//        // 获取图片
//        self.ImageView.image = UIGraphicsGetImageFromCurrentImageContext();
//        // 结束图形上下文
//        UIGraphicsEndImageContext();
    }];
    
    
    // 判断是否为GIF类型图片
    NSString *extension = topic.large_image.pathExtension; // 得到字符串的扩展名
    /**
     * 在不知道图片扩展名的情况下, 如何知道图片的真实类型?
       取出图片数据的第一个字节, 就可以判断出图片的真实类型
    */
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否要显示点击放大图片
    if (!topic.isBigPicture) { // 非大图
        self.seeBigButton.hidden = YES;
        self.ImageView.contentMode = UIViewContentModeScaleToFill;
    } else { // 大图
        self.seeBigButton.hidden = NO;
        self.ImageView.contentMode = UIViewContentModeTop;
    }
}

@end

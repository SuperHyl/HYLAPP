//
//  hylshowPictureViewController.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/15.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylshowPictureViewController.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <M13ProgressViewPie.h>
#import "hylTopic.h"

@interface hylshowPictureViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView; // 显示的图片
@property (strong, nonatomic) IBOutlet M13ProgressViewPie *progressView; // 下载进度图片

@end

@implementation hylshowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    
    // 添加图片的点方法
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    
    self.imageView = imageView;
    [self.scrollView addSubview:imageView];
    
    // 屏幕宽高
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    // 图片宽高
    CGFloat pictureW = screenW - 10;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if (pictureH > screenH) { // 图片显示高度超过一个屏幕,需要滚动查看
        imageView.frame = CGRectMake(5, 20, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH + 40);
        
    } else {
        imageView.size = CGSizeMake(pictureW + 10, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
    // 马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProress animated:NO];
    
    // 下载显示图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden =NO;
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save
{
    // 将图片存入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    if (error) {
        [SVProgressHUD showSuccessWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}


@end

//
//  hylVerticalButton.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/9.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylVerticalButton.h"

@implementation hylVerticalButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

// 应用代码创建button时的设置
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

// 应用xib创建button时的设置
- (void)awakeFromNib {
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end

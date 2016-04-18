//
//  hylTabBar.m
//  百思不得姐
//
//  Created by SuperHyl on 16/3/31.
//  Copyright © 2016年 hyl. All rights reserved.
//
 #import "hylTabBar.h"

@interface hylTabBar()

// 发布按钮
@property (weak, nonatomic) UIButton *publishButton;

@end


@implementation hylTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置tabBar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        // 设置发布按钮的基础属性
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        // 添加
        [self addSubview:publishButton];
        
        self.publishButton = publishButton;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的frame
//    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
//    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.size = self.publishButton.currentBackgroundImage.size;
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH =  height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 计算按钮的X值
        CGFloat buttonX = buttonW * (index > 1 ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
    } 
}

@end

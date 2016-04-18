//
//  UIBarButtonItem+hylExtension.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/1.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "UIBarButtonItem+hylExtension.h"

@implementation UIBarButtonItem (hylExtension)

+ (instancetype)itemWithImage:(NSString *)image clickImage:(NSString *)clickImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom]; // 自定义的按钮
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal]; // 常态图片
    [button setBackgroundImage:[UIImage imageNamed:clickImage] forState:UIControlStateHighlighted]; //点中时的图片
    button.size = button.currentBackgroundImage.size; // PCH文件宏定义size属性
    // 为按钮添加点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end

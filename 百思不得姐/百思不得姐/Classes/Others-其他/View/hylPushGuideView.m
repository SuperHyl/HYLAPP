//
//  hylPushGuideView.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/11.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylPushGuideView.h"

@implementation hylPushGuideView

// 从xib文件中加载View的方法
+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

// 显示推送引导
+ (void)show
{
    // 获取当前的版本号
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获取沙盒中存储的版本号
    NSString *boxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:boxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        // 从xib文件中加载View
        hylPushGuideView *guideView = [hylPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        // 现在就存
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


// 关闭方法
- (IBAction)close
{
    [self removeFromSuperview];
}

@end

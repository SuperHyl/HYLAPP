//
//  hylNavigationController.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/1.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylNavigationController.h"

@implementation hylNavigationController

// 第一次使用这个类时会调用一次这个方法
+ (void)initialize {
    // 当导航栏用在hylNavigationController中，appearance才会生效
//    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    UINavigationBar *bar = [UINavigationBar appearance];
    // 设置导航栏背景图片
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    HYLLogFunc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 这个方法可以拦截所有push进来的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        // 自定义按钮基础设置
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button sizeToFit]; // 按钮内容自适应
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0); // 按钮内容偏移
        // 按钮添加点击事件
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置自定义按钮为导航栏的左按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 在后面push，出来的控制器还可以自定义左按钮将上面的设置覆盖
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end

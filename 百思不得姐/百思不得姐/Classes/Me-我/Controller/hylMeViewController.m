//
//  hylMeViewController.m
//  百思不得姐
//
//  Created by SuperHyl on 16/3/31.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylMeViewController.h"

@interface hylMeViewController ()

@end

@implementation hylMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景色
    self.view.backgroundColor = HYLGlobalBackgroundColor;
    
    // 设置导航栏内容
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" clickImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" clickImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    // Do any additional setup after loading the view. 
}

- (void)settingClick {
    HYLLogFunc;
}

- (void)moonClick {
    HYLLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

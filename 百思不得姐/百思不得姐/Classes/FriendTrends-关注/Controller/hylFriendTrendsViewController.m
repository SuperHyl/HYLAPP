//
//  hylFriendTrendsViewController.m
//  百思不得姐
//
//  Created by SuperHyl on 16/3/31.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylFriendTrendsViewController.h"
#import "hylRecommendViewController.h"
#import "hylloginRegisterViewController.h"

@interface hylFriendTrendsViewController ()

@end

@implementation hylFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏内容
    self.navigationItem.title = @"我的关注";
    // 设置背景色
    self.view.backgroundColor = HYLGlobalBackgroundColor;
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" clickImage:@"friendsRecommentIcon-click" target:self action:@selector(leftClick)];
    
    // Do any additional setup after loading the view.
}

- (void)leftClick {
    
    hylRecommendViewController *recomVC = [[hylRecommendViewController alloc] init];
    
    [self.navigationController pushViewController:recomVC animated:YES];
}

- (IBAction)loginRegister {
    hylloginRegisterViewController *loginRegisterVC = [[hylloginRegisterViewController alloc] init];
    [self presentViewController:loginRegisterVC animated:YES completion:nil];
}




@end

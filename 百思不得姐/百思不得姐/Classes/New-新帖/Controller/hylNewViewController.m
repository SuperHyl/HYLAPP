//
//  hylNewViewController.m
//  百思不得姐
//
//  Created by SuperHyl on 16/3/31.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylNewViewController.h"

@interface hylNewViewController ()

@end

@implementation hylNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景色
    self.view.backgroundColor = HYLGlobalBackgroundColor;
    
    // 设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" clickImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // Do any additional setup after loading the view.
}

- (void)tagClick {
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

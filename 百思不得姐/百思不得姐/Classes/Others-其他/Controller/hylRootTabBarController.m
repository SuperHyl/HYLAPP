//
//  hylRootTabBarController.m
//  百思不得姐
//
//  Created by SuperHyl on 16/3/31.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylRootTabBarController.h"
#import "hylEssenceViewController.h"
#import "hylNewViewController.h"
#import "hylFriendTrendsViewController.h"
#import "hylMeViewController.h"
#import "hylTabBar.h"
#import "hylNavigationController.h"

@interface hylRootTabBarController ()

@end

@implementation hylRootTabBarController

+ (void)initialize {
    
    // 通过appearance属性统一设置所用UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSMutableDictionary *slectAttrs = [NSMutableDictionary dictionary];
    slectAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    slectAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:slectAttrs forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    [self setupChildVC:[[hylEssenceViewController alloc] init] Title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVC:[[hylNewViewController alloc] init] Title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVC:[[hylFriendTrendsViewController alloc] init] Title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVC:[[hylMeViewController alloc] init] Title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 更换tabBar
    // 利用KVC将只读的tabBar属性自定义
    [self setValue:[[hylTabBar alloc] init] forKeyPath:@"tabBar"];
    
    // Do any additional setup after loading the view.
}

// 初值化子控制器
-(void)setupChildVC:(UIViewController *)VC Title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置文字和图片 背景颜色
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:image];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航视图控制器，添加为TabBarController的子视图控制器
    hylNavigationController *NAVC = [[hylNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:NAVC];
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

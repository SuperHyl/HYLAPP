//
//  hylEssenceViewController.m
//  百思不得姐
//
//  Created by SuperHyl on 16/3/31.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylEssenceViewController.h"
#import "hylRecommendTagsViewController.h"
#import "hylTopicViewController.h"

@interface hylEssenceViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) UIView *titlesView; // 顶部的所有标签
@property (weak, nonatomic) UIScrollView *contentView; // 底部的所有内容
@property (weak, nonatomic) UIView *indicatorView; // 标签栏底部的红色指示器
@property (weak, nonatomic) UIButton *selectedButton; // 当前选中的按钮

@end

@implementation hylEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setupNAVC];
    
    // 初始化子控制器
    [self setupChildVC];
    
    // 设置顶部的标签栏
    [self setupTitlesView];
    
    // 底部的scrollView
    [self setupContentView];
}

// 设置导航栏
- (void)setupNAVC
{
    // 设置背景色
    self.view.backgroundColor = HYLGlobalBackgroundColor;
    
    // 设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" clickImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

- (void)tagClick
{
    hylRecommendTagsViewController *tagsVC = [[hylRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tagsVC animated:YES];
}

// 初始化子控制器
- (void)setupChildVC
{
    
    hylTopicViewController *wordVC = [[hylTopicViewController alloc] init];
    wordVC.title = @"段子";
    wordVC.type = HYLTopicTypeWord;
    [self addChildViewController:wordVC];
    
    hylTopicViewController *allVC = [[hylTopicViewController alloc] init];
    allVC.title = @"全部";
    allVC.type = HYLTopicTypeAll;
    [self addChildViewController:allVC];
    
    hylTopicViewController *videoVC = [[hylTopicViewController alloc] init];
    videoVC.title = @"视频";
    videoVC.type = HYLTopicTypeVideo;
    [self addChildViewController:videoVC];
    
    hylTopicViewController *voiceVC = [[hylTopicViewController alloc] init];
    voiceVC.title = @"声音";
    voiceVC.type = HYLTopicTypeVoice;
    [self addChildViewController:voiceVC];
    
    hylTopicViewController *pictureVC = [[hylTopicViewController alloc] init];
    pictureVC.title = @"图片";
    pictureVC.type = HYLTopicTypePicture;
    [self addChildViewController:pictureVC];
    
}

//  设置顶部的标签栏
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = HYLTitlesViewH;
    titlesView.y = HYLTitlesViewY;
    
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 4;
    indicatorView.y = titlesView.height - indicatorView.width - 4;
    indicatorView.tag = -1;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        UIViewController *VC = self.childViewControllers[i];
        [button setTitle:VC.title forState:UIControlStateNormal];
//        [button layoutIfNeeded]; // 强制布局（强制更新子控件的frame）
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
//            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
            self.indicatorView.width = button.titleLabel.width + 14;
            self.indicatorView.centerX = button.centerX;
        }
    }
    // 保证指示器在最前面
    [titlesView addSubview:indicatorView];
}

// 标签按钮的点击方法
- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.width = button.titleLabel.width + 14;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

// 底部的scrollView
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    
    contentView.pagingEnabled = YES;
    
    contentView.delegate = self;
    
    [self.view insertSubview:contentView atIndex:0];
    // 滚动范围
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    
    self.contentView = contentView;
    
    // 添加第一个控制器的View
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark --- UIScrollViewDelegate方法 ----
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 添加子控制器的View
    // 取到当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *VC = self.childViewControllers[index];
    VC.view.x = scrollView.contentOffset.x;
    VC.view.y = 0; // 控制器的view的y值默认为20
    VC.view.height = scrollView.height; // 默认比屏幕高度少20
    
    [scrollView addSubview:VC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 指示器随着变动相当于点击了按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end

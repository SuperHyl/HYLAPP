//
//  hylRecommendTagsViewController.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/8.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylRecommendTagsViewController.h"
#import "hylRecommendTag.h"
#import "hylRecommendTagCell.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface hylRecommendTagsViewController ()

@property (strong, nonatomic) NSMutableArray *tagArray;

@end

static NSString * const HYLTagId = @"tag";

@implementation hylRecommendTagsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐标签";

    self.view.backgroundColor = HYLGlobalBackgroundColor;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([hylRecommendTagCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:HYLTagId];
    
    self.tableView.rowHeight = 80;
    
    [self loadTags];
}

// 数据请求与加载数组
- (void)loadTags
{
    [SVProgressHUD showWithStatus:@"正在加载标签数据"];
    
    // 请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionaryWithCapacity:0];
    parames[@"a"] = @"tag_recommend ";
    parames[@"action"] = @"sub";
    parames[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [SVProgressHUD dismiss];
         
         self.tagArray = [hylRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
         
         [self.tableView reloadData];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [SVProgressHUD showErrorWithStatus:@"数据请求失败"];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tagArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    hylRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:HYLTagId];
    
    cell.recommendTag = self.tagArray[indexPath.row];
    
    return cell;
}


@end

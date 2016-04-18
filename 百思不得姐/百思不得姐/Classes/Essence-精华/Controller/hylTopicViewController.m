//
//  hylWordViewController.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/12.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylTopicViewController.h"

#import <MJExtension.h>
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

#import "hylTopic.h"
#import "hylTopicCell.h"

@interface hylTopicViewController ()

@property (strong, nonatomic) NSMutableArray *topics; // 帖子数据
@property (assign, nonatomic) NSInteger page; // 当前页码
@property (copy, nonatomic) NSString *maxtime; // 加载下一页数据时要的参数
@property (strong, nonatomic) NSDictionary *params; // 请求参数的字典
@end

@implementation hylTopicViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        self.topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化视图
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
}

static NSString *const HYLTopicCellId = @"topic";

// 设置列表视图
- (void) setupTableView
{
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = HYLTitlesViewY + HYLTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 设置cell的分割线为空
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HYLGlobalBackgroundColor;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([hylTopicCell class]) bundle:nil] forCellReuseIdentifier:HYLTopicCellId];
}

// 添加刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark --- 数据处理 ----
/**
 *  加载新的帖子数据
 */
- (void)loadNewTopics
{
    // 结束上拉刷新
    [self.tableView.mj_footer endRefreshing];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典转模型
        self.topics = [hylTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        
        // 清空页码
        self.page = 0;
        
        // 将得到的数据转换成plist文件存储到指定的位置
        //        [responseObject writeToFile:@"/Users/lanou/Desktop/duanzi.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 *  加载更多的帖子数据
 */
- (void)loadMoreTopics
{
    // 结束下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典转模型
        NSArray *newTopics = [hylTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        // 更新页码
        self.page++;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    hylTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:HYLTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    /*
    //    cell.textLabel.text = topic.name;
    //    cell.detailTextLabel.text = topic.text;
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
     */
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 取出帖子模型
    hylTopic *topic = self.topics[indexPath.row];
    
    // 返回对应模型的cell高度
    return topic.cellHeight;
}

@end

//
//  hylRecommendViewController.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/2.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylRecommendViewController.h"
// 第三方
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
// 模型
#import "hylRecommendCategory.h"
#import "hylRecommendUser.h"
// 两种cell
#import "hylCategoryCell.h"
#import "hylUserCell.h"
// 左半边表格中被选中的对象
#define HYLSelectedCategory self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row]

@interface hylRecommendViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *categoryArray; // 左边类别数组

@property (strong, nonatomic) IBOutlet UITableView *categoryTableView; // 左边列别表格
@property (strong, nonatomic) IBOutlet UITableView *userTableView; // 右边用户表格

@property (strong, nonatomic) NSMutableDictionary *parames; // 请求参数

@property (strong, nonatomic) AFHTTPSessionManager *manager; // AFN的请求管理者

@end

@implementation hylRecommendViewController

static NSString *const hylCategoryId = @"catrgory";
static NSString *const hylUserId = @"user";

/* // 左边类别数组的懒加载方法
//- (NSMutableArray *)categoryArray {
//    if (!_categoryArray) {
//        _categoryArray = [[NSMutableArray alloc] init];
//    }
//    return _categoryArray;
//}
//// 左边用户数组的懒加载方法
//- (NSMutableArray *)userArray {
//    if (!_userArray) {
//        _userArray = [[NSMutableArray alloc] init];
//    }
//    return _userArray;
//} */

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        self.manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = HYLGlobalBackgroundColor;
    
    // 控件初始化
    [self setupTableView];
    
    // 加载右侧的类别数据
    [self loadCategories];
    
    // 添加刷新控件
    [self setupRefresh];
}

#pragma mark --- 加载数据、添加控件 ----
// 控件初始化
- (void)setupTableView
{
    // 注册左边类别表格视图的Cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([hylCategoryCell class]) bundle:nil] forCellReuseIdentifier:hylCategoryId];
    // 注册右边用户表格视图的Cell
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([hylUserCell class]) bundle:nil] forCellReuseIdentifier:hylUserId];
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    // 设置每行的行高
    self.userTableView.rowHeight = 70;
}


// 加载右侧的类别数据
- (void)loadCategories
{
    // 显示指示器
    [SVProgressHUD showWithStatus:@"正在请求数据\n请稍等片刻！"];
    
    // 请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"a"] = @"category";
    parames[@"c"] = @"subscribe";
    
    //发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         // 解析方法的错误操作
         {// 回到主线程在做操作
             //        dispatch_async(dispatch_get_main_queue(), ^{
             // 解析服务器返回的数据
             //            for (NSDictionary *dict in responseObject[@"list"]) {
             //                hylRecommendCategory *model = [[hylRecommendCategory alloc] init];
             //                [model setValuesForKeysWithDictionary:dict];
             //                [self.categoryArray addObject:model];
             //            }
             //        });
         }
         
         // 隐藏指示器
         [SVProgressHUD dismiss];
         
         // 使用第三方控件MJExtension将获取的JSON数据转换成数组
         // 解析数据添加到临时数组中
         self.categoryArray = [hylRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
         
         // 刷新表格
         [self.categoryTableView reloadData];
         
         // 默认选中首行
         [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
         
         // 让用户表格进入下拉刷新状态
         [self.userTableView.mj_header beginRefreshing];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         // 显示失败信息
         [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
     }];
    
}

// 添加刷新控件
- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

#pragma mark --- 刷新控件的加载数据方法 ----
// 时刻监测footer的状态
- (void)checkFooterState
{
    hylRecommendCategory *category = HYLSelectedCategory;
    
    // 每次刷新右边的数据时，都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (category.userArray.count == 0);
    
    //让底部控件结束刷新
    if (category.userArray.count == category.total) { // 全部加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没加载完毕，结束加载，等待下一此刷新
        [self.userTableView.mj_footer endRefreshing];
    }
}

// 下拉刷新数据
- (void)loadNewUsers
{
    
    hylRecommendCategory *category = HYLSelectedCategory;
    
    // 设置当前的页码为1
    category.currentPage = 1;
    
    // 请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"a"] = @"list";
    parames[@"c"] = @"subscribe";
    parames[@"category_id"] = @(category.ID);
    parames[@"page"] = @(category.currentPage);
    
    self.parames = parames;
    
    // 发送请求给服务器，加载右边的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
//        HYLLog(@"%@", responseObject);
        // 清除所有的旧数据
        [category.userArray removeAllObjects];
        
        // 解析数据添加到数组中
        category.userArray = [hylRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 保存总数
        category.total = [responseObject[@"total"] integerValue];
        
        // 如果不是最后一次请求，不要刷新表格，直接return
        if (self.parames != parames) return;
        
        // 刷新右边得表格
        [self.userTableView reloadData];
        
        // 让顶部控件结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        //让底部控件结束刷新
//        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parames != parames) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
    

}

// 上拉加载更多数据
- (void)loadMoreUsers
{
    hylRecommendCategory *category = HYLSelectedCategory;
    
    // 请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"a"] = @"list";
    parames[@"c"] = @"subscribe";
    parames[@"category_id"] = @(category.ID);
    parames[@"page"] = @(++category.currentPage);
    
    self.parames = parames;
    
    // 发送请求给服务器，加载右边的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        // 解析数据添加到临时数组中
        NSArray *userArray = [hylRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        // 添加到当前类别对应的用户数组中
        [category.userArray addObjectsFromArray:userArray];
        
        if (self.parames != parames) return;
        
        // 刷新右边得表格
        [self.userTableView reloadData];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        if (self.parames != parames) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}

#pragma mark ----UITableViewDataSource代理方法----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categoryArray.count;
    } else {
        // 监测footer的状态
        [self checkFooterState];
        
        return [HYLSelectedCategory userArray].count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        hylCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:hylCategoryId];
        cell.category = self.categoryArray[indexPath.row];
        
        return cell;
    } else {
        hylUserCell *cell = [tableView dequeueReusableCellWithIdentifier:hylUserId];
        
        cell.user = [HYLSelectedCategory userArray][indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        [self.userTableView.mj_footer endRefreshing];
        
        hylRecommendCategory *category = self.categoryArray[indexPath.row];
        
        if (category.userArray.count) {
            // 刷新显示以前的数据
            [self.userTableView reloadData];
        } else {
//            HYLLog(@"正在请求数据！");
            // 赶紧刷新数据，目的是显示当前的category的用户数据，不让用户看到上一个category的残留数据
            [self.userTableView reloadData];
            
            // 进入下拉刷新状态
            [self.userTableView.mj_header beginRefreshing];
            
            // 测试操作，一秒后再刷新
            //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //        });
            
        }
    }
}

#pragma mark --- 控制器的销毁 ----
- (void)dealloc
{
    // 停止所有的操作
    [self.manager.operationQueue cancelAllOperations];
}


@end

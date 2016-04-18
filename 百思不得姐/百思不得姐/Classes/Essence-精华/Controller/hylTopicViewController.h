//
//  hylTopicViewController.h
//  百思不得姐
//
//  Created by SuperHyl on 16/4/13.
//  Copyright © 2016年 hyl. All rights reserved.
//  最基本的帖子类

#import <UIKit/UIKit.h>

@interface hylTopicViewController : UITableViewController

@property (assign, nonatomic) HYLTopicType type; // 贴子的类型(交给子类去实现)

@end

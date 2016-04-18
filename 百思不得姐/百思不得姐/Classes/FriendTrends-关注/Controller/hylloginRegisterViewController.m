//
//  hylloginRegisterViewController.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/9.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylloginRegisterViewController.h"

@interface hylloginRegisterViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;
//@property (strong, nonatomic) IBOutlet UITextField *phoneField;
//@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin; // 登录框距离View左边的间距

@end

@implementation hylloginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.layer.cornerRadius = 5;
//    button.layer.masksToBounds = YES;
    
    [self.view insertSubview:self.backgroundView atIndex:0];
//
//    // 文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    
//    // NSAttributedString : 带有属性的文字(富文本技术)
//    NSAttributedString *phonePlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
//    self.phoneField.attributedPlaceholder = phonePlaceholder;
//    
//    NSAttributedString *passwordPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:attrs];
//    self.passwordField.attributedPlaceholder = passwordPlaceholder;
}
- (IBAction)showLoginOrRegister:(UIButton *)sender
{
    // 退出键盘
    [self.view endEditing:YES];
    if (self.loginViewLeftMargin.constant == 0) { // 显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
        sender.selected = YES;
//        [sender setTitle:@"已有账号？" forState:UIControlStateNormal];
    } else { // 显示登录界面
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;
//        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  让控制器对应的导航栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

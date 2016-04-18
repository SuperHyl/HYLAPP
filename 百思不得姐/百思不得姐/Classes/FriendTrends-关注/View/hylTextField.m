//
//  hylTextField.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/11.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylTextField.h"
#import <objc/runtime.h>

static NSString *const HYLPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation hylTextField

//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    // 可以在这里面画占位文字，定义它的位置和颜色
//}

/**
 *  首次调用这个类时会走这个方法
 */
//+ (void)initialize
//{
//    unsigned int count = 0;
//    // 拷贝出所有的成员变量列表
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int i = 0; i < count; i++) {
//        // 取出所有的成员变量
////        Ivar ivar = *(ivars + i);
//        Ivar ivar = ivars[i];
//        // 打印成员表量名字
//        HYLLog(@"%s", ivar_getName(ivar));
//    }
//    
//    // 释放
//    free(ivars);
//}

- (void)awakeFromNib
{
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 *  当前文本框聚焦是会调用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:HYLPlacerholderColorKeyPath];
    
    return [super becomeFirstResponder];
}

/**
 *  当前文本失去焦点时会调用
 */
- (BOOL)resignFirstResponder
{
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:HYLPlacerholderColorKeyPath];
    
    return [super resignFirstResponder];
}

@end

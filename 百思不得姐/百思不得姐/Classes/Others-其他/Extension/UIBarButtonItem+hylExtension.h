//
//  UIBarButtonItem+hylExtension.h
//  百思不得姐
//
//  Created by SuperHyl on 16/4/1.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (hylExtension)

+ (instancetype)itemWithImage:(NSString *)image clickImage:(NSString *)clickImage target:(id)target action:(SEL)action;

@end

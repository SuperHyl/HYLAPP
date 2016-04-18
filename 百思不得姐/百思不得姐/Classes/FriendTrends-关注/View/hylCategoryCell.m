//
//  hylCategoryCell.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/2.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylCategoryCell.h"
#import "hylRecommendCategory.h"

@interface hylCategoryCell()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel; 
@property (strong, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation hylCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = HYLGlobalBackgroundColor;
    self.selectedIndicator.backgroundColor = HYLRGBColor(219, 21, 26);
    
    // 当cell的selection为None时，即使cell被选中，内不断的子控件也不会进入高亮状态
//    self.titleLabel.highlightedTextColor = HYLRGBColor(219, 21, 26);
}

// 在设置模型的方法里设置属性
- (void)setCategory:(hylRecommendCategory *)category {
    _category = category;
    self.titleLabel.text = category.name;
}

/**
 *  可以在这个方法中监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // 设置未被选中时选中指示视图隐藏
    self.selectedIndicator.hidden = !selected;
    // 选中时的文字颜色发生变化
    self.titleLabel.textColor = selected ? self.selectedIndicator.backgroundColor : HYLRGBColor(78, 78, 78);
    // Configure the view for the selected state
}



@end

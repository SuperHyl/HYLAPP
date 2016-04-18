//
//  hylRecommendTagCell.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/8.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylRecommendTagCell.h"
#import "hylRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface hylRecommendTagCell()

@property (strong, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (strong, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation hylRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommendTag:(hylRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list]];
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    } else {
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
    
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 2;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

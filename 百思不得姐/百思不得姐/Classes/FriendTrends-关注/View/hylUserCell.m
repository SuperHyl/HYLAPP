//
//  hylUserCell.m
//  百思不得姐
//
//  Created by SuperHyl on 16/4/5.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import "hylUserCell.h"
#import "hylRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface hylUserCell()

@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation hylUserCell

- (void)awakeFromNib {
    self.backgroundColor = HYLGlobalBackgroundColor;
}

- (void)setUser:(hylRecommendUser *)user {
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    } else {
        fansCount = [NSString stringWithFormat:@"%.1f万人订阅", user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

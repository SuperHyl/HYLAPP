//
//  hylConst.h
//  百思不得姐
//
//  Created by SuperHyl on 16/4/12.
//  Copyright © 2016年 hyl. All rights reserved.
//

#import <UIKit/UIKit.h>

// 贴子的类型枚举类型
typedef enum {
    HYLTopicTypeAll = 1,
    HYLTopicTypePicture = 10,
    HYLTopicTypeWord = 29,
    HYLTopicTypeVoice = 31,
    HYLTopicTypeVideo = 41
} HYLTopicType;

// 精华-顶部标题的高度
UIKIT_EXTERN CGFloat const HYLTitlesViewH;
// 精华-顶部标题的Y
UIKIT_EXTERN CGFloat const HYLTitlesViewY;

// 精华-cell-间距
UIKIT_EXTERN CGFloat const HYLTopicCellMargin;
// 精华-cell-文字内容的Y值
UIKIT_EXTERN CGFloat const HYLTopicCellTextY;
// 精华-cell-底部工具条的高度
UIKIT_EXTERN CGFloat const HYLTopicCellBottomBarH;
// 精华-cell-图片帖子的最大高度
UIKIT_EXTERN CGFloat const HYLTopicCellPictureMaxH;
// 精华-cell-图片帖子的高度一旦超过最大高度，使用这个高度
UIKIT_EXTERN CGFloat const HYLTopicCellPictureH;








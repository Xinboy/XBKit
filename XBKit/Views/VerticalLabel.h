//
//  VerticalLabel.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/6/14.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger ,LabelVerticalAlignment){
    LabelVerticalAlignmentTop = 0,
    LabelVerticalAlignmentMiddle,
    LabelVerticalAlignmentBottom
};

@interface VerticalLabel : UILabel


@property (nonatomic, assign) LabelVerticalAlignment verticalAlignment;


/**
 修改垂直方式、左侧间距、上下间距
 默认垂直方式：中间居中
 默认左侧间距：11.0
 默认上下间距：20.0
 */
- (void)setVerticalAlignment:(LabelVerticalAlignment)verticalAlignment
                   leftSpace:(CGFloat)leftSpace
               verticalSpace:(CGFloat)verticalSpace;

@end

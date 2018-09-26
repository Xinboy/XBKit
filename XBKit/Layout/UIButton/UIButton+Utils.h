//
//  UIButton+Utils.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/16.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SubviewsAlignment) {
    /** 默认*/
    SubviewsAlignmentDefault = 0,
    /** 文字左边 图片右边 左对齐*/
    SubviewsAlignmentTitleLeft,
    /** 文字左边 图片右边 两端对齐*/
    SubviewsAlignmentTitleJustified,
    /** 文字左边 图片右边 右对齐*/
    SubviewsAlignmentTitleRight,
    /** 图片左边 文字右边 左对齐*/
    SubviewsAlignmentImageLeft,
    /** 图片左边 文字右边 两端对齐*/
    SubviewsAlignmentImageJustified,
    /** 图片左边 文字右边 右对齐*/
    SubviewsAlignmentImageRight,
    /** 图片左边 文字右边 居中对齐*/
    SubviewsAlignmentImageCenterLeft,
    /** 文字左边 图片右边 居中对齐*/
    SubviewsAlignmentImageCenterRight,
    /** 文字下边 图片上边 居中对齐*/
    SubviewsAlignmentImageCenterTop,
    /** 文字上边 图片下边 居中对齐*/
    SubviewsAlignmentImageCenterBottom,
};

@interface UIButton (Utils)

- (void)resetSubviewsAlignment:(SubviewsAlignment)Alignment Interval:(CGFloat)interval;
- (void)resetSubviewsAlignment:(SubviewsAlignment)Alignment;

//防止重复响应
@property (nonatomic, assign) NSTimeInterval timeInterval;

@property (nonatomic, assign, getter=isIgnoreEvent) BOOL ignoreEvent;
@end

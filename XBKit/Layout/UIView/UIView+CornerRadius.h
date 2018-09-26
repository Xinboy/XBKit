//
//  UIView+CornerRadius.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/6/12.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)

/**
给view设置圆角

@param value 圆角大小
@param rectCorner 圆角位置
*/
- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner;

/**
 设置阴影和圆角,支持UILabel
 
 @param shadowOffset 阴影偏移量
 @param radius 圆角半径
 
 */
- (CALayer *)setshadowOffset:(CGSize)shadowOffset cornerRadius:(CGFloat)radius;
@end

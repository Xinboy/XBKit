//
//  UIAlertController+Units.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/7/3.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 富文本信息*/
UIKIT_EXTERN NSString *const kAlertControllerAttributedMessage;
/** 富文本标题*/
UIKIT_EXTERN NSString *const kAlertControllerAttributedTitle;

@interface UIAlertController (Extension)

/**
 设置 Message 的对齐方式
 */
- (void)setAlertControllerMessageAlignment:(UIAlertController *)alert textAligment:(NSTextAlignment)alignment;

/**
 设置 Title 的对齐方式
 */
- (void)setAlertControllerTitleAlignment:(UIAlertController *)alert textAligment:(NSTextAlignment)alignment;

@end

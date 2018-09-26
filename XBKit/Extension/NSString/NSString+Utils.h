//
//  NSString+Attributed.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/5/29.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Utils)

//千分位+ 保留两位小数点
+ (NSString *)positiveFloatFormat:(NSString *)text;
//千分位 整数
+ (NSString *)positiveIntFormat:(NSString *)text;

+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font;

+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font;
@end

//
//  UIColor+XBCategory.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2017/12/1.
//  Copyright © 2017年 X-Core Co,. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XBCategory)

+ (UIColor *)XBColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 十六进制整型与透明度组合转颜色

 @param hexNumber 十六进制，格式为0xffffff
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)colorWithHexInt:(int)hexNumber alpha:(CGFloat)alpha;


/**
 十六进制整型转颜色，透明度默认为1.0f

 @param hexNumber 十六进制整型
 @return 颜色
 */
+ (UIColor *)colorWithHexInt:(int)hexNumber;

/**
 十六进制字符串与透明度组合转颜色

 @param hexString 字符串支持0xffffff/#ffffff/ffffff
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;


/**
 十六进制字符串转颜色，透明度默认为1.0f

 @param hexString 十六进制字符串
 @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 识别点击位置的颜色
 
 @param point 点击坐标
 @return 颜色
 */
+ (UIColor *)colorAtPoint:(CGPoint)point inImage:(UIImage *)image;
@end

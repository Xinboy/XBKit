//
//  UIImage+Extension.h
//  SmartHome
//
//  Created by xinbo on 16/3/10.
//  Copyright © 2016年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CircleHeading) {
    CircleHeadingLeft = 0,
    CircleHeadingRight,
    CircleHeadingTop,
    CircleHeadingBottom,
};

@interface UIImage (Extension)
/**
 图片按照一个半径裁剪左右边框
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

/**
 重新设定图片大小
 */
+ (UIImage *)resizableImage:(NSString *)imageName top:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right;

/**
 根据颜色生成纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 根据颜色生成纯色圆角图片
 */
+ (UIImage *)imageWithCornerRadiusSize:(CGSize)size BackgroundColor:(UIColor *)color;

/**
 图片裁剪成圆形
 */
+ (UIImage *)cutCircleWithImage:(UIImage *)image;

/**
 缩放图片
 */
+ (UIImage *)resizedImage:(NSString *)name scale:(CGFloat)scale;

/**
 缩放图片: 更低层的ImageIO接口
 */
+ (UIImage *)scaledImageWithData:(NSData *)data withSize:(CGSize)size scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;

#pragma mark - **************** 二维码生成

/**
 二维码生成（无logo）
 
 @param string 写入二维码的字符串
 @param imageSide 图片大小
 @return 二维码图片
 */
+ (UIImage *)qrImageForString:(NSString *)string ImageSide:(CGFloat)imageSide;


/**
 二维码中间添加logo图片
 
 @param qrImage 二维码图片
 @param logoImage logo图片
 @param logoSide logo大小
 @return 生成的新二维码图片
 */
+ (UIImage *)qrImage:(UIImage *)qrImage WithAddLogoImage:(UIImage *)logoImage LogoImageSide:(CGFloat)logoSide;

#pragma mark - **************** 
/**
 *  此点区域的色值
 *
 *  @param point CGPoint
 *
 *  @return 色值
 */
- (UIColor *)colorAtPoint:(CGPoint)point;


/**
 图片圆角的朝向

 @param heading 朝向位置：上下左右
 @param rect 尺寸大小
 @param fillColor 填充颜色
 */
+ (UIImage *)imageForCircleHeading:(CircleHeading)heading Rect:(CGRect)rect color:(UIColor *)fillColor;
@end

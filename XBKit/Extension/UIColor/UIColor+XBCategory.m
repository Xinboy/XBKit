//
//  UIColor+XBCategory.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2017/12/1.
//  Copyright © 2017年 X-Core Co,. All rights reserved.
//

#import "UIColor+XBCategory.h"

@implementation UIColor (XBCategory)

+ (UIColor *)XBColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red / 255.0 green:green  / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (UIColor *)colorWithHexInt:(int)hexNumber alpha:(CGFloat)alpha {
    if (hexNumber > 0xFFFFFF) {
        return nil;
    }
    CGFloat rFloat = ((hexNumber >> 16) & 0xFF) / 255.0;
    CGFloat gFloat = ((hexNumber >> 8) & 0xFF) / 255.0;
    CGFloat bFloat = (hexNumber & 0xFF) / 255.0;
    return [UIColor colorWithRed:rFloat green:gFloat blue:bFloat alpha:alpha];
}

+ (UIColor *)colorWithHexInt:(int)hexNumber {
    return [UIColor colorWithHexInt:hexNumber alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    UIColor *defaultColor = [UIColor clearColor];
    
    if (hexString.length < 6) {
        return defaultColor;
    }
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    if ([hexString hasPrefix:@"0X"] || [hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    if (hexString.length != 6) {
        return defaultColor;
    }
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned int hexNumber;
    if (![scanner scanHexInt:&hexNumber]) {
        return defaultColor;
    }
    
    return [UIColor colorWithHexInt:hexNumber alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [UIColor colorWithHexString:hexString alpha:1.0f];
}

/** 此点区域的色值*/
+ (UIColor *)colorAtPoint:(CGPoint)point inImage:(UIImage *)image{
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0, 0, image.size.width, image.size.height), point)) {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = image.CGImage;
    NSUInteger width = image.size.width;
    NSUInteger height = image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end

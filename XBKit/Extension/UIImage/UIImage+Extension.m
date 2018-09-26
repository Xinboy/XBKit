//
//  UIImage+Extension.m
//  SmartHome
//
//  Created by xinbo on 16/3/10.
//  Copyright © 2016年 xigu. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)resizableImage:(NSString *)imageName top:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right {
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    return image;
}

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithCornerRadiusSize:(CGSize)size BackgroundColor:(UIColor *)color {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = color;
    
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    image = [image imageWithCornerRadius:size.height * 0.5];
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0.0f,0.0f,self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//将图片裁剪成圆形
+ (UIImage *)cutCircleWithImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    //获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //设置圆形
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextAddEllipseInRect(ref, rect);
    //裁剪
    CGContextClip(ref);
    
    [image drawInRect:rect];
    
    UIGraphicsEndImageContext();
    
    return image;
}


/** 缩放图片*/
+ (UIImage *)resizedImage:(NSString *)name scale:(CGFloat)scale {
    
    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width *scale topCapHeight:image.size.height * scale];
}

/** 缩放图片*/
+ (UIImage *)scaledImageWithData:(NSData *)data withSize:(CGSize)size scale:(CGFloat)scale orientation:(UIImageOrientation)orientation {
    CGFloat maxPixedSize = MAX(size.width, size.height);
    
    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
    NSDictionary *options = @{(__bridge id)kCGImageSourceCreateThumbnailFromImageAlways: (__bridge id)kCFBooleanTrue, (__bridge id)kCGImageSourceThumbnailMaxPixelSize: [NSNumber numberWithFloat: maxPixedSize]};

    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(sourceRef, 0, (__bridge CFDictionaryRef)options);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:scale orientation:orientation];
    CGImageRelease(imageRef);
    CFRelease(sourceRef);
    
    return resultImage;
}

#pragma mark - **************** 二维码生成
//二维码生成
+ (UIImage *)qrImageForString:(NSString *)string ImageSide:(CGFloat)imageSide {
    
    // 1.生成二维码;
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *outPutCIImage = [filter outputImage];
    
    // 2.创建bitmap;
    CGRect extent = CGRectIntegral(outPutCIImage.extent);
    CGFloat scale = MIN(imageSide / CGRectGetWidth(extent), imageSide / CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outPutCIImage fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 3.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    
    return outputImage;
}

+ (UIImage *)qrImage:(UIImage *)qrImage WithAddLogoImage:(UIImage *)logoImage LogoImageSide:(CGFloat)logoSide {
    if (qrImage == nil || logoImage == nil) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(qrImage.size, NO, [[UIScreen mainScreen] scale]);
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    [logoImage drawInRect:CGRectMake((qrImage.size.width - logoSide) / 2, (qrImage.size.height - logoSide) / 2, logoSide, logoSide)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - **************** 
- (UIColor *)colorAtPoint:(CGPoint)point {
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
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

+ (UIImage *)imageForCircleHeading:(CircleHeading)heading Rect:(CGRect)rect color:(UIColor *)fillColor {
    CGFloat radius = 0;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    switch (heading) {
        case CircleHeadingTop:
            radius = rect.size.width * 0.5;
            CGContextMoveToPoint(ctx, 0, rect.size.height);
            CGContextAddLineToPoint(ctx, 0, radius);
            CGContextAddArc(ctx, radius, radius, radius, -M_PI_2, -(M_PI + M_PI_2), true);
            CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
            break;
        case CircleHeadingBottom:
            radius = rect.size.width * 0.5;
            CGContextMoveToPoint(ctx, 0, 0);
            CGContextAddLineToPoint(ctx, 0, rect.size.height - radius);
            CGContextAddArc(ctx, radius, rect.size.height - radius, radius, -M_PI_2, -(M_PI + M_PI_2), true);
            CGContextAddLineToPoint(ctx, rect.size.width, 0);
            break;
        case CircleHeadingLeft:
            radius = rect.size.height * 0.5;
            CGContextMoveToPoint(ctx, rect.size.width, 0);
            CGContextAddLineToPoint(ctx, radius, 0);
            CGContextAddArc(ctx, radius, radius, radius, -M_PI_2, -(M_PI + M_PI_2), true);
            CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
            break;
        case CircleHeadingRight:
            radius = rect.size.height * 0.5;
            CGContextMoveToPoint(ctx, 0, 0);
            CGContextAddLineToPoint(ctx, rect.size.width - radius, 0);
            CGContextAddArc(ctx, rect.size.width - radius, radius, radius, -M_PI_2, -(M_PI + M_PI_2), false);
            CGContextAddLineToPoint(ctx, 0, rect.size.height);
            break;
        default:
            break;
    }
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end

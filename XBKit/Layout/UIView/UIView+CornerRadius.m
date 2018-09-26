//
//  UIView+CornerRadius.m
//  XBKit
//
//  Created by Xinbo Hong on 2018/6/12.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)

- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner {
    
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    
}

- (CALayer *)setshadowOffset:(CGSize)shadowOffset cornerRadius:(CGFloat)radius {
    
    CALayer *shadowlayer =[CALayer layer];
    shadowlayer.shadowOffset = CGSizeMake(0, 3);
    shadowlayer.shadowRadius = 5.0;
    shadowlayer.shadowColor = [UIColor blackColor].CGColor;
    shadowlayer.shadowOpacity = 0.1;
    shadowlayer.cornerRadius = radius;
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = true;
    [shadowlayer addSublayer:self.layer];
    
    return  shadowlayer;
    
}



@end

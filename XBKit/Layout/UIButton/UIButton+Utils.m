//
//  UIButton+Utils.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/16.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "UIButton+Utils.h"
#import <objc/runtime.h>

static const char *kTimeIntervalKey = "kTimeIntervalKey";
static const char *kIngoreEventKey = "kIngoreEventKey";
static const CGFloat kDefaultTimeInterval = 0.5;

@implementation UIButton (Utils)

- (void)resetSubviewsAlignment:(SubviewsAlignment)Alignment Interval:(CGFloat)interval {
    if (self.imageView.image != nil && self.titleLabel.text != nil) {
        //先还原
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        
        CGFloat labelX = self.titleLabel.frame.origin.x;
        CGFloat labelWidth = self.titleLabel.frame.size.width;
        CGFloat labelHeight = self.titleLabel.frame.size.height;
        CGFloat imageX = self.imageView.frame.origin.x;
        CGFloat imageViewWidth = self.imageView.frame.size.width;
        CGFloat imageViewHeight = self.imageView.frame.size.height;
        CGFloat buttonWidth = self.frame.size.width;
        
        switch (Alignment) {
            case SubviewsAlignmentDefault:
                break;
            case SubviewsAlignmentImageLeft:
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -imageX + interval, 0, imageX + interval);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageX + interval, 0, imageX + interval);
                break;
            case SubviewsAlignmentImageJustified:
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -(imageX - interval), 0, (imageX - interval));
                self.titleEdgeInsets = UIEdgeInsetsMake(0, buttonWidth - (labelX + labelWidth + interval), 0, -(buttonWidth - (labelX + labelWidth + interval)));
                break;
            case SubviewsAlignmentImageRight:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, buttonWidth - (labelX + labelWidth + interval), 0, -(buttonWidth - (labelX + labelWidth + interval)));
                self.titleEdgeInsets = UIEdgeInsetsMake(0, buttonWidth - (labelX + labelWidth + interval), 0, -(buttonWidth - (labelX + labelWidth + interval)));
                break;
                
            case SubviewsAlignmentTitleLeft:
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(labelX - interval), 0, (labelX - interval));
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -(imageX - interval) + labelWidth, 0, (imageX - interval) - labelWidth);
                break;
            case SubviewsAlignmentTitleJustified:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, buttonWidth - (imageX + imageViewWidth + interval), 0, -(buttonWidth - (imageX + imageViewWidth + interval)));
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(labelX - interval), 0, (labelX - interval));
                break;
            case SubviewsAlignmentTitleRight:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, buttonWidth - imageX - imageViewWidth - interval, 0, -(buttonWidth - imageX - imageViewWidth - interval));
                self.titleEdgeInsets = UIEdgeInsetsMake(0, buttonWidth - (labelX + labelWidth + interval + 5) - imageViewWidth, 0, -(buttonWidth - (labelX + labelWidth + interval + 5)) + imageViewWidth);
                break;
            case SubviewsAlignmentImageCenterLeft:
                self.titleEdgeInsets = UIEdgeInsetsMake(0, interval, 0, 0);
                break;
            case SubviewsAlignmentImageCenterRight:
                self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + interval, 0, -labelWidth);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageViewWidth + interval), 0, +imageViewWidth);
                break;
            case SubviewsAlignmentImageCenterTop:
                self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth / 2, labelHeight + interval, -labelWidth / 2);
                self.titleEdgeInsets = UIEdgeInsetsMake(imageViewHeight + interval, -imageViewWidth, 0, 0);
                break;
            case SubviewsAlignmentImageCenterBottom:
                self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth / 2, -(labelHeight + interval), -labelWidth / 2);
                self.titleEdgeInsets = UIEdgeInsetsMake(-(imageViewHeight + interval), -imageViewWidth, 0, 0);
                break;
        }
    } else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

- (void)resetSubviewsAlignment:(SubviewsAlignment)Alignment {
    return [self resetSubviewsAlignment:Alignment Interval:5.0];
}


#pragma mark --- 防止重复点击 ---
- (NSTimeInterval)timeInterval {
    return [objc_getAssociatedObject(self, &kTimeIntervalKey) doubleValue];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    objc_setAssociatedObject(self, kTimeIntervalKey, @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isIgnoreEvent {
    return [objc_getAssociatedObject(self, &kIngoreEventKey) boolValue];
}

- (void)setIgnoreEvent:(BOOL)ignoreEvent {
    objc_setAssociatedObject(self, kIngoreEventKey, @(ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)resetStatus {
    [self setIgnoreEvent:false];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(mySendAction:to:forEvent:);
        
        Method methodA = class_getInstanceMethod(self, selA);
        Method methodB = class_getInstanceMethod(self, selB);
        
        //将methodB的实现添加到系统方法中也就是说将methodA方法指针添加成方法methodB的返回值表示是否添加成功
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        //添加成功了说明本类中不存在methodB所以此时必须将方法b的实现指针换成方法A的，否则b方法将没有实现。
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        } else {
            method_exchangeImplementations(methodA, methodB);
        }
        
    });
}


- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event {
    self.timeInterval = self.timeInterval == 0 ? kDefaultTimeInterval : self.timeInterval;
    if (self.isIgnoreEvent) {
        return;
    } else if (self.timeInterval > 0) {
        [self performSelector:@selector(resetStatus) withObject:nil afterDelay:self.timeInterval];
    }
    self.ignoreEvent = true;
    [self mySendAction:action to:target forEvent:event];
}
@end

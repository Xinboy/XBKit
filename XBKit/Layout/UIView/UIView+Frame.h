//
//  UIView+Frame.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2017/12/13.
//  Copyright © 2017年 X-Core Co,. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
/** (x + width) / 2*/
@property (nonatomic, assign, readonly) CGFloat midX;
/** (x + width)*/
@property (nonatomic, assign, readonly) CGFloat maxX;
/** (y + height) / 2*/
@property (nonatomic, assign, readonly) CGFloat midY;
/** (y + height)*/
@property (nonatomic, assign, readonly) CGFloat maxY;
/** height / 2*/
@property (nonatomic, assign, readonly) CGFloat midHeight;
/** width / 2*/
@property (nonatomic, assign, readonly) CGFloat midWidth;


@end

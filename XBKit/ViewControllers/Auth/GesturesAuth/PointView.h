//
//  PointView.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/3/20.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

/*
 *  控件名称:    手势解锁的点视图
 *  控件完成情况: 未完成
 *  最后记录时间: 2018/4/11
 */

#import <UIKit/UIKit.h>

@interface PointView : UIView

@property (nonatomic, copy, readonly) NSString *ID;

@property (nonatomic, assign, getter=isSelected) BOOL selected;

@property (nonatomic, assign, getter=isError) BOOL error;

@property (nonatomic, assign, getter=isSuccess) BOOL success;

@property (nonatomic, strong) UIColor *selectedColor;

- (instancetype)initWithFrame:(CGRect)frame WithID:(NSString *)ID;

@end

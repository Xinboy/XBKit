//
//  GesturesView.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/3/20.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

/*
 *  控件名称:    手势解锁视图
 *  控件完成情况: 未完成
 *  最后记录时间: 2018/4/11
 */

#import <UIKit/UIKit.h>

typedef void(^GestureBlock)(NSArray *selectedID);

typedef void(^UnlockBlock)(BOOL isSuccess);

typedef void(^SettingBlock)(void);

@interface GesturesView : UIView

/** 设置密码时，返回设置的手势密码*/
@property (nonatomic, copy) GestureBlock gestureBlock;

/** 返回解锁成功还是失败状态*/
@property (nonatomic, copy) UnlockBlock unlockBlock;

/** 判断手势密码时候设置成功（手势密码不得少于四个点）*/
@property (nonatomic, copy) SettingBlock settingBlock;

/** 判断是设置手势还是手势解锁*/
@property (nonatomic, assign, getter=isSettingGesture) BOOL settingGesture;

@property (nonatomic, strong) UIColor *selectedColor;

@end

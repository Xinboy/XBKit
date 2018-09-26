//
//  UIView+placeholderView2.h
//  PlaceholderView
//
//  Created by Xinbo Hong on 2017/10/8.
//  Copyright © 2017年 Xinbo Hong. All rights reserved.
//

/*
 *  控件名称:    无数据/意外情况显示页（无第三方控件）
 *  控件完成情况: 完成，后期跟随技术提升进行优化
 *  最后记录时间: 2018/1/21
 */
/****************** 原生代码 ******************/

#import <UIKit/UIKit.h>

typedef void(^reloadButtonAction)(void);

@interface UIView (placeholderView)

/** UIView的占位图类型 */
typedef NS_ENUM(NSInteger, PlaceholderViewType) {
    /** 没网 */
    PlaceholderViewTypeNoNetwork,
    /** 其他 */
    PlaceholderViewTypeOther
};


- (void)showPlaceholerViewWithType:(PlaceholderViewType)type reloadBlock:(reloadButtonAction)reloadBlock;

- (void)showPlaceholderView;

- (void)removePlaceholderView;

@end

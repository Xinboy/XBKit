//
//  PopMenuView.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/3/9.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

/*
 *  控件名称:    菜单导航栏
 *  控件完成情况: 未完成
 *  最后记录时间: 2018/4/11
 */

#import <UIKit/UIKit.h>

@interface PopMenuView : UIView

@property (nonatomic, assign) NSInteger menuCount;

@property (nonatomic, strong) NSArray *itemsArray;

@property (nonatomic, strong) UIImage *buttonNormalImage;

@property (nonatomic, strong) UIImage *buttonSelectedImage;

@property (nonatomic, strong) NSArray *itemDataArray;

@end

//
//  ShadowBgView.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/7/13.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

//未完成
#import <UIKit/UIKit.h>

@interface ShadowBgView : UIView

@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGFloat shadowOpacity;
@property (nonatomic, assign) CGFloat shadowRadius;
@property (nonatomic, assign) CGFloat cornerRadius;

@end

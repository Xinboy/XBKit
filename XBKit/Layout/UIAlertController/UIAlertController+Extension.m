//
//  UIAlertController+Units.m
//  XBKit
//
//  Created by Xinbo Hong on 2018/7/3.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "UIAlertController+Extension.h"

NSString *const kAlertControllerAttributedMessage = @"attributedMessage";

NSString *const kAlertControllerAttributedTitle = @"attributedTitle";
@implementation UIAlertController (Extension)

- (void)setAlertControllerMessageAlignment:(UIAlertController *)alert textAligment:(NSTextAlignment)alignment {
    UIView *subView1 = alert.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    UILabel *message = subView5.subviews[1];
    message.textAlignment = alignment;
}


- (void)setAlertControllerTitleAlignment:(UIAlertController *)alert textAligment:(NSTextAlignment)alignment {
    UIView *subView1 = alert.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    UILabel *title = subView5.subviews[0];
    title.textAlignment = alignment;
}

@end

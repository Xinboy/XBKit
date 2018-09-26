//
//  GlobalTools.m
//  XBKit
//
//  Created by Xinbo Hong on 2018/5/31.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "GlobalTools.h"


@implementation GlobalTools
singleton_implementation(GlobalTools)

// 递归获取子视图
- (void)getSub:(UIView *)view andLevel:(int)level {
    NSArray *subviews = [view subviews];
    // 如果没有子视图就直接返回
    if ([subviews count] == 0) return;
    
    for (UIView *subview in subviews) {
        // 根据层级决定前面空格个数，来缩进显示
        NSString *blank = @"";
        for (int i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"  %@", blank];
        }
        // 打印子视图类名
        NSLog(@"%@%d: %@", blank, level, subview.class);
        // 递归获取此视图的子视图
        [self getSub:subview andLevel:(level+1)];
        
    }
}

- (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to {
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

- (void)showAllFonts {
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ) {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ) {
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
}

- (UIViewController *)currentViewController {
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc visibleViewController];
        }
        else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}

- (UINavigationController *)currentNavigationController {
    return [self currentViewController].navigationController;
}

@end

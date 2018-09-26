//
//  Contants.h
//  SearchToilet
//
//  Created by Xinbo Hong on 2017/11/1.
//  Copyright © 2017年 Xinbo Hong. All rights reserved.
//

#ifndef Contants_h
#define Contants_h

static const NSString *kDataBaseName = @"DataBaseName";

#define iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

#define iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
#define iOS8_10 (iOS8 && ([[UIDevice currentDevice].systemVersion doubleValue] <= 10.0))

#define NSLog(FORMAT, ...) fprintf(stderr, "%f %s:%zd\t%s\n",CFAbsoluteTimeGetCurrent(), [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);

NS_INLINE NSString *kRegularPingFang() {
    return @"PingFangSC-Regular";
}

NS_INLINE NSString *kMediumPingFang() {
    return @"PingFangSC-Medium";
}

NS_INLINE NSString *kSemiboldPingFang() {
    return @"PingFangSC-Semibold";
}

NS_INLINE NSDateFormatter *kDateFormatter() {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return formatter;
    
}

NS_INLINE NSUserDefaults *kUserDef() {
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark - **************** 普通以及iPhone X的导航栏和菜单栏高度
//状态栏高度
NS_INLINE CGFloat kStatusBarHeight() {
    return ([[UIDevice stringWithDeviceType] isEqualToString:@"iPhone X"] ? 44 : 20);
}
NS_INLINE CGFloat kNavigationBarHeight() {
    return 44;
}
//底部危险区域高度
NS_INLINE CGFloat kBottomDangerArea() {
    return ([[UIDevice stringWithDeviceType] isEqualToString:@"iPhone X"] ? 44 : 20);
}
//底部菜单高度
NS_INLINE CGFloat kTabBarHeight() {
    return 49;
}

//顶部状态栏和导航栏的高度之和
NS_INLINE CGFloat kTopBarHeight() {
    return (kStatusBarHeight() + kNavigationBarHeight());
}
//底部菜单和危险区域的高度之和
NS_INLINE CGFloat kBottomBarHeight() {
    return (kTabBarHeight() + kBottomDangerArea());
}
NS_INLINE CGFloat kScreenHeiht() {
    return [UIScreen mainScreen].bounds.size.height;
}

NS_INLINE CGFloat kScreenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}

NS_INLINE CGFloat kScreenWidthScale() {
    return [UIScreen mainScreen].bounds.size.width  / 375;
}

NS_INLINE CGFloat kScreenHeightScale() {
    return [UIScreen mainScreen].bounds.size.height  / 667;
}

NS_INLINE CGFloat kScreenSideScale() {
    return (kScreenHeiht() / kScreenWidth()) / 1.779;
}

#endif /* Contants_h */

//
//  ToolClass.h
//  XBProjectModule
//
//  Created by Xinbo Hong on 2018/1/1.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface ToolClass : NSObject



/**
 十进制数转16进账
 
 @param DecimalNumber 十进制数
 @return 十六进制数
 */
+ (NSString *)stringWithDecimalNumber:(NSUInteger)DecimalNumber;

/**
 十六进制转十进制
 
 @param hexString 十六进制数
 @return 十进制数
 */
+ (NSInteger)numberWithHexString:(NSString *)hexString;


/**
 将像素单位的大小（px）转为磅单位的大小（pt）

 @param px 像素单位的大小
 @return 磅单位的大小
 */
+ (NSInteger)ptWithPX:(NSInteger)px;

/**
 获得整型[x,y)之间随机数
 
 @param from 起始整型数
 @param to 结束整型数
 @return 随机数
 */
+ (int)intWithRandomFrom:(int)from To:(int)to;

/**
 获得浮点[x,y)之间随机数
 
 @param from 起始浮点数
 @param to 结束浮点数
 @return 随机数
 */
+ (double)doubleWithRandomFrom:(double)from To:(double)to;
#pragma mark - **************** 检查App 版本
/**
 检查本地 App 版本
 
 @return 本地 App 版本号
 */
+ (NSString *)stringWithAppLocalVersion;

/**
 检查 App Store 版本, 不依赖各种第三方, 采用原生
 弹出提示框强制更新
 
 @param appUrl app 在商店的 url
 */
+ (void)showHasNewVersionUpdateWithAppURL:(NSString *)appUrl;
#pragma mark - **************** CoreData 相关
/**
 CoreData：根据相关条件，从对应的实例中获取数据数组
 
 @param predicate 判断条件
 @param entityName 对应的实例名
 @return 匹配的数据数组
 */
+ (NSArray *)arrayWithDataFromCoreDataWithPredicate:(NSPredicate *)predicate andEntityName:(NSString *)entityName;

/**
 CoreData：保存数据
 */
+ (void)save:(NSError **)error;

/**
 CoreData：删除数据
 */
+ (void)deleteObject:(NSManagedObject *)object;

#pragma mark - **************** 时间戳相关
/**
 时间戳：将当前时间转换为时间戳
 
 @return 当前时间的时间戳字符串
 */
+ (NSString *)stringWithTimeStamp;

/**
 时间戳：根据传入时间字符串转换为时间戳
 
 @param timeString 时间字符串
 @return 传入时间字符串对应的时间戳
 */
+ (NSString *)timeStampWithTimeString:(NSString *)timeString;

/**
 时间戳：根据传入时间戳字符串转换为时间字符串（格式：yyyy-MM-dd HH:mm:ss）
 
 @param timeStamp 时间戳字符串
 @return 传入 时间戳字符串对应的时间字符串
 */
+ (NSString *)timeStringWithTimeStmap:(NSString *)timeStamp;


#pragma mark - **************** 二维码生成

/**
 二维码生成（无logo）
 
 @param string 写入二维码的字符串
 @param imageSide 图片大小
 @return 二维码图片
 */
+ (UIImage *)qrImageForString:(NSString *)string ImageSide:(CGFloat)imageSide;


/**
 二维码中间添加logo图片
 
 @param qrImage 二维码图片
 @param logoImage logo图片
 @param logoSide logo大小
 @return 生成的新二维码图片
 */
+ (UIImage *)qrImage:(UIImage *)qrImage WithAddLogoImage:(UIImage *)logoImage LogoImageSide:(CGFloat)logoSide;

@end

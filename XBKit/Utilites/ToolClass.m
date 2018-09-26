//
//  ToolClass.m
//  XBProjectModule
//
//  Created by Xinbo Hong on 2018/1/1.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "ToolClass.h"
#import <sys/utsname.h>

#define ARC4RANDOM_MAX 0x100000000

@implementation ToolClass

#pragma mark - **************** 数值转换
+ (NSString *)stringWithDecimalNumber:(NSUInteger)DecimalNumber {
    
    char hexChar[6];
    sprintf(hexChar, "%x", (int)DecimalNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    
    return hexString;
}

+ (NSInteger)numberWithHexString:(NSString *)hexString {
    
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    
    int decimalNumber;
    
    sscanf(hexChar, "%x", &decimalNumber);
    
    return (NSInteger)decimalNumber;
}

+ (NSInteger)ptWithPX:(NSInteger)px {
    return ceilf(18 / 96.0 * 72.0);
}

+ (int)intWithRandomFrom:(int)from To:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

+ (double)doubleWithRandomFrom:(double)from To:(double)to {
    from = from * 100000000;
    to = to * 100000000;
    double val = from + floor(((double)arc4random() / ARC4RANDOM_MAX) * (to - from));
    return val / 100000000;
}

#pragma mark - **************** 检查App 版本
+ (NSString *)stringWithAppLocalVersion {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    return version;
}

//检查 App Store 版本, 不依赖各种第三方, 采用原生
+ (void)showHasNewVersionUpdateWithAppURL:(NSString *)appUrl {
    
    //获取本地版本
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    NSDictionary *infoDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    //去掉.
    NSString *oldStr = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    //    下载链接
    //    https://itunes.apple.com/us/app/iqup/id1149168206?mt=8
    NSString *appURLStr = @"http://itunes.apple.com/lookup?id=";
    NSString *appIDStr = appUrl;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", appURLStr, appIDStr];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSError *err = nil;
            NSDictionary *appInfoDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
            if (err) {
                NSLog(@"%@",err);
                return;
            }
            NSArray *resultArray = [appInfoDict objectForKey:@"results"];
            if (![resultArray count]) {
                NSLog(@"error : resultArray == nil");
                return;
            }
            NSDictionary *infoDict = [resultArray objectAtIndex:0];
            NSString *newStr = [[infoDict objectForKey:@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
            
            if ([newStr intValue] > [oldStr intValue]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有新版本可供更新" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms://itunes.apple.com/gb/app/yi-dong-cai-bian/id%@?mt=8",appIDStr]]];
                    
                }];
                [alertController addAction:okAction];
                //!!!!!!!后期加入可获取的 是否强制更新变量
                if (1) {
                    //选择更新
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertController addAction:cancelAction];
                }
                //强制更新
                [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers.lastObject presentViewController:alertController animated:YES completion:nil];
            }
            
        }];
        [task resume];
    });
    
}

#pragma mark - **************** CoreData 相关
//+ (NSArray *)arrayWithDataFromCoreDataWithPredicate:(NSPredicate *)predicate andEntityName:(NSString *)entityName {
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
//    request.predicate = predicate;
//    NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
//    return [context executeFetchRequest:request error:nil];
//}
//
//+ (void)save:(NSError **)error {
//    [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext save:error];
//}
//
//+ (void)deleteObject:(NSManagedObject *)object {
//    [((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext deleteObject:object];
//}

#pragma mark - **************** 时间戳相关
//获得时间戳
+ (NSString *)stringWithTimeStamp {
    NSDate *date = [NSDate date];
    return [NSString stringWithFormat:@"%ld",(NSInteger)[date timeIntervalSince1970]];
}
//数据库时间字段转时间戳
+ (NSString *)timeStampWithTimeString:(NSString *)timeString {
    if (timeString.length > 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *versionData = [formatter dateFromString:timeString];
        return [NSString stringWithFormat:@"%ld",(NSInteger)[versionData timeIntervalSince1970]];
    } else {
        return @"";
    }
}
//时间戳转时间字符串
+  (NSString *)timeStringWithTimeStmap:(NSString *)timeStamp {
    if (timeStamp.length > 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp.integerValue];
        return [formatter stringFromDate:date];
    } else {
        return @"";
    }
    
}

@end

//
//  LocationManager.m
//  XBZRenting
//
//  Created by Xinbo Hong on 2018/1/17.
//  Copyright © 2018年 XBZRenting. All rights reserved.
//

#import "LocationManager.h"


@interface LocationManager ()<CLLocationManagerDelegate>


@end


@implementation LocationManager

- (void)appStartUpdatingLocation {
    [self.locationManager startUpdatingLocation];
}

- (void)appStopUpdatingLocation {
    [self.locationManager stopUpdatingHeading];
}

#pragma mark - Private Function

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = locations.lastObject;
    self.location = location;
    
    if (self.locationUpdateBlock) {
        self.locationUpdateBlock(locations);
    }
    
    [self.locationManager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        //访问被拒绝
        [self showDeniedAlertController];
    } else if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        NSLog(@"无法获取位置信息");
    } else {
        NSLog(@"%@",error);
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            break;
        case kCLAuthorizationStatusRestricted:
            break;
        case kCLAuthorizationStatusDenied:{
            //拒绝
            [self showDeniedAlertController];
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            break;
    }
}

- (void)showDeniedAlertController {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"友情提醒", nil) message:NSLocalizedString(@"我们需要通过您的地理位置信息获取您周边的相关数据", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"允许", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:cancelAction];
    [alertC addAction:settingAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertC animated:YES completion:nil];
}


#pragma mark - **************** 单例实现
static LocationManager *kSingleObject = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kSingleObject = [[super allocWithZone:NULL] init];
    });
    return kSingleObject;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copy {
    return kSingleObject;
}

- (id)mutableCopy {
    return kSingleObject;
}

#pragma mark - **************** Lazy Load
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 5;
        [self.locationManager startUpdatingLocation];
    }
    return _locationManager;
}

@end

//
//  LocationManager.h
//  XBZRenting
//
//  Created by Xinbo Hong on 2018/1/17.
//  Copyright © 2018年 XBZRenting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
typedef void(^LocationUpdateBlock)(NSArray *locations);

@interface LocationManager : NSObject

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) LocationUpdateBlock locationUpdateBlock;

+ (instancetype)sharedInstance;

- (void)appStartUpdatingLocation;

- (void)appStopUpdatingLocation;

@end

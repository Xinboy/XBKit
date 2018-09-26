//
//  AccountManager.m
//  XJPH
//
//  Created by Xinbo Hong on 2018/7/10.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "AccountManager.h"


NSString *const kUserDefaultUIDKey = @"UIDKey";
NSString *const kUserDefaultEnterpriseKey = @"EnterpriseKey";
@implementation AccountManager

+ (void)saveUserInfo:(AccountModel *)model {
    NSString *complexToken = [NSString stringWithFormat:@"Bearer %@",model.token];
    [kUserDef() setObject:model.expires forKey:@"expire"];
    [kUserDef() setObject:complexToken forKey:@"token"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [kUserDef() setObject:data forKey:kUserDefaultUIDKey];
    [kUserDef() synchronize];
}

+ (AccountModel *)loadUserInfo {
    NSData *data = [kUserDef() objectForKey:kUserDefaultUIDKey];
    return (AccountModel *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
}


+ (void)removeUserInfo {
    [kUserDef() removeObjectForKey:kUserDefaultUIDKey];
}

+ (NSAttributedString *)showStatusInUserView {
    AccountModel *model = [AccountManager loadUserInfo];
    
    NSDictionary *normalDict = @{NSForegroundColorAttributeName: [UIColor colorWithHexInt:0x222222],
                                 NSFontAttributeName: [UIFont fontWithName:kMediumPingFang() autoSize:20]};
    
    if (model) {
        if ([model.auth_status isEqualToString:@"1"] && [model.open_status isEqualToString:@"1"]) {
            NSMutableAttributedString * nameStr = [[NSMutableAttributedString alloc] initWithString:model.name];
            NSDictionary *nameAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexInt:0x222222],NSFontAttributeName:[UIFont fontWithName:kMediumPingFang() autoSize:30]};
            [nameStr setAttributes:nameAttributes range:NSMakeRange(0,nameStr.length)];
            
            NSMutableAttributedString *phoneStr = [[NSMutableAttributedString alloc] initWithString:model.mobile];
            [phoneStr replaceCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
            NSDictionary *phoneAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexInt:0x999999],NSFontAttributeName:[UIFont fontWithName:kMediumPingFang() autoSize:16]};
            [phoneStr setAttributes:phoneAttributes range:NSMakeRange(0,phoneStr.length)];
            
            [nameStr appendAttributedString:phoneStr];
            
            return nameStr.copy;
        } else {
            
            NSAttributedString *unUserAttStr = [[NSAttributedString alloc] initWithString:@"实名 / 开户" attributes:normalDict];
            return unUserAttStr;
        }
    } else {
        NSAttributedString *unUserAttStr = [[NSAttributedString alloc] initWithString:@"登录 / 注册" attributes:normalDict];
        return unUserAttStr;
    }
    
}

static AccountManager *kSingleObject = nil;
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



@end

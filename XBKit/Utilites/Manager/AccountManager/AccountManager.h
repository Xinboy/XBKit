//
//  AccountManager.h
//  XJPH
//
//  Created by Xinbo Hong on 2018/7/10.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

@interface AccountManager : NSObject

@property (nonatomic, strong) AccountModel *model;

//@property (nonatomic, strong) LoginViewController *popLoginVC;

+ (instancetype)sharedInstance;

+ (void)saveUserInfo:(AccountModel *)model;
+ (AccountModel *)loadUserInfo;


+ (void)removeUserInfo;

+ (NSAttributedString *)showStatusInUserView;
@end

//
//  AccountModel.h
//  XJPH
//
//  Created by Xinbo Hong on 2018/7/10.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *idcard;
@property (nonatomic, strong) NSString *account_name;
@property (nonatomic, strong) NSString *account_no;
@property (nonatomic, strong) NSString *bank_name;
@property (nonatomic, strong) NSString *open_status;
@property (nonatomic, strong) NSString *auth_status;
@property (nonatomic, strong) NSString *expires;
@property (nonatomic, strong) NSString *token;

@end

//
//  AccountModel.m
//  XJPH
//
//  Created by Xinbo Hong on 2018/7/10.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.idcard forKey:@"idcard"];
    [aCoder encodeObject:self.account_name forKey:@"account_name"];
    [aCoder encodeObject:self.account_no forKey:@"account_no"];
    [aCoder encodeObject:self.bank_name forKey:@"bank_name"];
    [aCoder encodeObject:self.open_status forKey:@"open_status"];
    [aCoder encodeObject:self.auth_status forKey:@"auth_status"];
    [aCoder encodeObject:self.expires forKey:@"expires"];
    [aCoder encodeObject:self.token forKey:@"token"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.idcard = [aDecoder decodeObjectForKey:@"idcard"];
        self.account_name = [aDecoder decodeObjectForKey:@"account_name"];
        self.account_no = [aDecoder decodeObjectForKey:@"account_no"];
        self.bank_name = [aDecoder decodeObjectForKey:@"bank_name"];
        self.open_status = [aDecoder decodeObjectForKey:@"open_status"];
        self.auth_status = [aDecoder decodeObjectForKey:@"auth_status"];
        self.expires = [aDecoder decodeObjectForKey:@"expires"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
    }
    return self;
}

@end

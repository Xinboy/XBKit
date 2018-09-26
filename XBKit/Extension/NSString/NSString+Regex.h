//
//  NSString+Regex.h
//  XBProjectModule
//
//  Created by Xinbo Hong on 2018/1/2.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)

/**
 正则匹配字符：中文、英文、数字但不包括下划线等符号
 
 @return 是否匹配
 */
- (BOOL)isLegalName;

/**
 正则匹配密码：英文、数字和下划线；长度6 - 16位
 
 @return 是否匹配
 */
- (BOOL)isLegalpassword;

/**
 正则匹配邮箱：英文、数字和下划线；长度6 - 16位
 
 @return 是否匹配
 */
- (BOOL)isLegalMainAddress;


/**
 正则匹配手机号码：11位和所有运营商

 @return 是否匹配
 */
- (BOOL)isLegalPhone;

/**
 正则匹配手机号码：11位 三大运营商
 
 @return 是否匹配
 */
- (BOOL)isLegalPhoneNumber;

/**
 正则匹配手机号码：11位 三大运营商
 
 @return 是否匹配
 */
- (BOOL)isLegalPhone;

/**
 正则匹配身份证号：身份证号
 
 @return 是否匹配
 */
- (BOOL)isLegalIDCard;
@end

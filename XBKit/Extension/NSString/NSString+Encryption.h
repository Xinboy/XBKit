//
//  NSString+Encryption.h
//  XBProjectModule
//
//  Created by Xinbo Hong on 2018/1/2.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encryption)

#pragma mark - AES256加密
//加密
- (NSString *)aes256_encrypt:(NSString *)key;
//解密
- (NSString *)aes256_decrypt:(NSString *)key;

#pragma mark - MD5加密
+ (NSString *)md5:(NSString *)inPutText;

#pragma mark - BASE64加密
//加密
+ (NSString *)base64_encrypt:(NSString *)encryptString;
//解密
+ (NSString *)base64_decrypt:(NSString *)decryptString;
@end

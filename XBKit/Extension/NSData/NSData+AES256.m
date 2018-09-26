//
//  NSData+AES256.m
//  ASEEncrypt
//
//  Created by 张心朝 on 16/6/28.
//  Copyright © 2016年 张心朝. All rights reserved.
//

#import "NSData+AES256.h"
#import <CommonCrypto/CommonCryptor.h>
@implementation NSData (AES256)
- (NSData *)aes256_encrypt:(NSString *)key  
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding ,
                                          keyPtr, kCCBlockSizeAES128,
                                          [@"5efd3f6060e20330" UTF8String],
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
//
//    CCCryptorStatus CCCrypt(
//                            CCOperation op,         /* kCCEncrypt, etc. */
//                            CCAlgorithm alg,        /* kCCAlgorithmAES128, etc. */
//                            CCOptions options,      /* kCCOptionPKCS7Padding, etc. */
//                            const void *key,
//                            size_t keyLength,
//                            const void *iv,         /* optional initialization vector */
//                            const void *dataIn,     /* optional per op and alg */
//                            size_t dataInLength,
//                            void *dataOut,          /* data RETURNED here */
//                            size_t dataOutAvailable,
//                            size_t *dataOutMoved)
//    __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)aes256_decrypt:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding ,
                                          keyPtr, kCCBlockSizeAES128,
                                          [@"5efd3f6060e20330" UTF8String],
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    free(buffer);
    return nil;
}
@end

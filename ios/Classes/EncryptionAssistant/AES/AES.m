//
//  AES.m
//  EncryptionAssistant
//
//  Created by 冯砚伟 on 2017/6/28.
//  Copyright © 2017年 冯砚伟. All rights reserved.
//

#import "AES.h"
#import <CommonCrypto/CommonCryptor.h>
NSString *const kInitVector = @"16-Bytes--String";

size_t const kKeySize = kCCKeySizeAES128;

@implementation AES
//+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key {
//    
//    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
//    NSUInteger dataLength = contentData.length;
//    
//    // 为结束符'\0' +1
//    char keyPtr[kKeySize + 1];
//    memset(keyPtr, 0, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    
//    // 密文长度 <= 明文长度 + BlockSize
//    size_t encryptSize = dataLength + kCCBlockSizeAES128;
//    void *encryptedBytes = malloc(encryptSize);
//    size_t actualOutSize = 0;
//    
//    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
//    
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
//                                          kCCAlgorithmAES,
//                                          kCCOptionPKCS7Padding,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding
//                                          keyPtr,
//                                          kKeySize,
//                                          initVector.bytes,
//                                          contentData.bytes,
//                                          dataLength,
//                                          encryptedBytes,
//                                          encryptSize,
//                                          &actualOutSize);
//    
//    if (cryptStatus == kCCSuccess) {
//        // 对加密后的数据进行 base64 编码
//        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    }
//    free(encryptedBytes);
//    return nil;
//}
//+ (NSData *)AES128Encrypt:(NSData *)plainData WithKey:(NSString *)key{
//    char keyPtr[kCCKeySizeAES128+1];
//    bzero(keyPtr, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    NSUInteger dataLength = [plainData length];
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
//                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
//                                          keyPtr, kCCKeySizeAES128,
//                                          NULL,
//                                          [plainData bytes], dataLength,
//                                          buffer, bufferSize,
//                                          &numBytesEncrypted);
//    if (cryptStatus == kCCSuccess) {
//        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
//    }
//    else {
//        free(buffer);
//        return nil;
//    }
//}

@end

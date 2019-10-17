//
//  NSData+AES1.m
//  EncryptionAssistant
//
//  Created by 冯砚伟 on 2017/6/28.
//  Copyright © 2017年 冯砚伟. All rights reserved.
//

#import "NSData+AES1.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (AES1)
//加密
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self AES128operation:kCCEncrypt key:key iv:iv];
//    return [self aes128Encrypt:key withIV:iv];
}

//解密
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self AES128operation:kCCDecrypt key:key iv:iv];
//    return [self aes128Decrypt:key withIV:iv];
}

- (NSData *)AES128operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [self length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;

    
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding|kCCOptionECBMode,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [self bytes], [self length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess){
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }else{
        NSLog(@"AES128operation Error");
    }
    
    free(buffer);
    return nil;
}


+ (NSData *)dataWithHexString:(NSString *)hexStr {
    hexStr = [hexStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    hexStr = [hexStr lowercaseString];
    NSUInteger len = hexStr.length;
    if (!len) return nil;
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [hexStr getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableData *result = [NSMutableData data];
    unsigned char bytes;
    char str[3] = { '\0', '\0', '\0' };
    int i;
    for (i = 0; i < len / 2; i++) {
        str[0] = buf[i * 2];
        str[1] = buf[i * 2 + 1];
        bytes = strtol(str, NULL, 16);
        [result appendBytes:&bytes length:1];
    }
    free(buf);
    return result;
}
@end

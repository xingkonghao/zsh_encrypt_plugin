//
//  NSData+hexString.h
//  IPTVForDDSDKDemo
//
//  Created by wtchang on 24/4/18.
//  Copyright © 2018年 wtchang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSData (hexString)

+ (nullable NSData *)dataWithHexString:(NSString *)hexString;

- (nullable NSData *)aes256ECBModeEncryptWithKey:(NSData *)key iv:( NSData *)iv;

- (nullable NSData *)aes256CBCModeEncryptWithKey:(NSData *)key iv:(NSData *)iv ;

- (nullable NSData *)aes256DecryptWithkey:(NSData *)key iv:( NSData *)iv;

- (nullable NSString *)base64EncodedString;
@end
NS_ASSUME_NONNULL_END

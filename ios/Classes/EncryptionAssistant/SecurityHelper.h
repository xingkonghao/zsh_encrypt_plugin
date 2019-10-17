//
//  SecurityHelper.h
//  EncryptionAssistant
//
//  Created by 冯砚伟 on 2017/6/28.
//  Copyright © 2017年 冯砚伟. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 加密方式
 
 - SecurityType_RSA: RSA 加密
 */
typedef NS_ENUM(NSInteger, SecurityType) {
    //PS:加密规则 Base64Encode(RSAEncrypt(plaintext)) 解密规则:RSADecrypt(Base64Decode(ciphertext))
    SecurityType_RSA = 0,
    //PS:
    SecurityType_AES,
};

@interface SecurityHelper : NSObject
/**
 字符串加密
 
 @param plainText 明文
 @param securityType 加密算法
 @param key 算法对应的秘钥
 @return 加密过后的内容
 */
+(NSString *)encryptString:(NSString *)plainText withSecurityType:(SecurityType )securityType withKey:(NSString *)key withTag:(NSString *)tag;
/**
 字符串加密
 
 @param plainText 明文
 @param securityType 加密算法
 @param key 算法对应的秘钥
 @return 加密过后的内容
 */
+(NSString *)encryptString:(NSString *)plainText withSecurityType:(SecurityType )securityType withKey:(NSString *)key;
/**
 加密二进制
 
 @param plainData 明文
 @param securityType 加密算法
 @return 加密过后的内容
 */
+(NSData *)encryptData:(NSData *)plainData withSecurityType:(SecurityType )securityType withKey:(NSString *)key;
/**
 字符串解密
 
 @param ciphertext 密文
 @param securityType 加密算法
 @return  加密原文
 */
+(NSString *)decryptString:(NSString *)ciphertext withSecurityType:(SecurityType )securityType withKey:(NSString *)key;

/**
 字符串解密
 
 @param ciphertext 密文
 @param securityType 加密算法
 @return  加密原文
 */
+(NSString *)decryptString:(NSString *)ciphertext withSecurityType:(SecurityType )securityType withKey:(NSString *)key withTag:(NSString *)tag;
/**
 RC4加解密
 */
+ (NSString*)RC4:(NSString*)aInput key:(NSString*)aKey;

@end

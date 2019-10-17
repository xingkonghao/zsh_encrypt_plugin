/*
 @author: ideawu
 @link: https://github.com/ideawu/Objective-C-RSA
 */

#import <Foundation/Foundation.h>

@interface RSA : NSObject

#pragma mark - 公钥加解密
// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey withTag:(NSString *)tag;
// decrypt base64 encoded string, convert result to string(not base64 encoded)
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey withTag:(NSString *)tag;

// return raw data
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;


#pragma mark - 私钥加解密
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;

// return base64 encoded string
// enc with private key NOT working YET!
//+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
// return raw data
//+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;
@end

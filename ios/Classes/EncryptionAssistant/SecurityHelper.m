//
//  SecurityHelper.m
//  EncryptionAssistant
//
//  Created by 冯砚伟 on 2017/6/28.
//  Copyright © 2017年 冯砚伟. All rights reserved.
//

#import "SecurityHelper.h"
#import "RSA.h"
#import "AES.h"
#import "NSData+AES1.h"
#import <pthread.h>
pthread_mutex_t mutex;

@implementation SecurityHelper
+(void)load{
    pthread_mutex_init(&mutex, NULL);
}

+(NSString *)encryptString:(NSString *)plainText withSecurityType:(SecurityType )securityType withKey:(NSString *)key withTag:(NSString *)tag{
    NSString *cipherText;
    switch (securityType) {
        case SecurityType_RSA:{
            cipherText = [RSA encryptString:plainText publicKey:key withTag:tag];
        }
            break;
        case SecurityType_AES:{
            //            pthread_mutex_lock(&mutex);
            NSData *data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
            data = [data AES128EncryptWithKey:key iv:@""];
            data = [data base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
            cipherText = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            //            pthread_mutex_unlock(&mutex);
        }
            break;
        default:
            break;
    }
    return cipherText;
}
+(NSString *)encryptString:(NSString *)plainText withSecurityType:(SecurityType )securityType withKey:(NSString *)key{
    NSString *cipherText;
    switch (securityType) {
        case SecurityType_RSA:{
            cipherText = [RSA encryptString:plainText publicKey:key];
        }
            break;
        case SecurityType_AES:{
            //            pthread_mutex_lock(&mutex);
            NSData *data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
            data = [data AES128EncryptWithKey:key iv:@""];
            data = [data base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
            cipherText = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            //            pthread_mutex_unlock(&mutex);
        }
            break;
        default:
            break;
    }
    return cipherText;
}

+(NSData *)encryptData:(NSData *)plainData withSecurityType:(SecurityType )securityType withKey:(NSString *)key{
    NSData *cipherData;
    switch (securityType) {
        case SecurityType_RSA:{
            cipherData = [RSA encryptData:plainData publicKey:key];
        }
            break;
        case SecurityType_AES:{
            cipherData = [plainData AES128EncryptWithKey:key iv:@""];
            cipherData = [cipherData base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
        }
            break;
        default:
            break;
    }
    return cipherData;
}

+(NSString *)decryptString:(NSString *)ciphertext withSecurityType:(SecurityType )securityType withKey:(NSString *)key{
    NSString *plainText;
    switch (securityType) {
        case SecurityType_RSA:{
            plainText = [RSA decryptString:ciphertext publicKey:key];
        }
            break;
        case SecurityType_AES:{
            NSData *data = [ciphertext dataUsingEncoding:NSUTF8StringEncoding];
            data = [[NSData alloc]initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
            NSData *data2 = [data AES128DecryptWithKey:key iv:@""];
            plainText = [[NSString alloc]initWithData:data2 encoding:NSUTF8StringEncoding];
        }
            break;
        default:
            break;
    }
    return plainText;
}
+(NSString *)decryptString:(NSString *)ciphertext withSecurityType:(SecurityType )securityType withKey:(NSString *)key withTag:(NSString *)tag{
    NSString *plainText;
    switch (securityType) {
        case SecurityType_RSA:{
            plainText = [RSA decryptString:ciphertext publicKey:key withTag:tag];
        }
            break;
        case SecurityType_AES:{
            NSData *data = [ciphertext dataUsingEncoding:NSUTF8StringEncoding];
            data = [[NSData alloc]initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
            NSData *data2 = [data AES128DecryptWithKey:key iv:@""];
            plainText = [[NSString alloc]initWithData:data2 encoding:NSUTF8StringEncoding];
        }
            break;
        default:
            break;
    }
    return plainText;
}
//RC4加解密
+ (NSString*)RC4:(NSString*)aInput key:(NSString*)aKey
{
    NSMutableArray *iS = [[NSMutableArray alloc] initWithCapacity:256];
    NSMutableArray *iK = [[NSMutableArray alloc] initWithCapacity:256];
    
    for (int i= 0; i<256; i++) {
        [iS addObject:[NSNumber numberWithInt:i]];
    }
    
    int j=1;
    //改动1，s-box的长度应当是256，楼主之前写的是255
    for (short i=0; i<256; i++) {
        
        UniChar c = [aKey characterAtIndex:i%aKey.length];
        
        [iK addObject:[NSNumber numberWithChar:c]];
    }
    j=0;
    for (int i=0; i<256; i++) {
        int is = [[iS objectAtIndex:i] intValue];
        UniChar ik = (UniChar)[[iK objectAtIndex:i] charValue];
        
        j = (j + is + ik)%256;
        NSNumber *temp = [iS objectAtIndex:i];
        [iS replaceObjectAtIndex:i withObject:[iS objectAtIndex:j]];
        [iS replaceObjectAtIndex:j withObject:temp];
        
    }
    int i=0;
    j=0;
    NSString *result = aInput;
    for (short x=0; x<[aInput length]; x++) {
        i = (i+1)%256;
        int is = [[iS objectAtIndex:i] intValue];
        j = (j+is)%256;
        //改动2:增加交换is_i和is_j的具体内容
        [iS exchangeObjectAtIndex:i withObjectAtIndex:j];
        
        int is_i = [[iS objectAtIndex:i] intValue];
        int is_j = [[iS objectAtIndex:j] intValue];
        
        int t = (is_i+is_j) % 256;
        int iY = [[iS objectAtIndex:t] intValue];
        
        
        
        UniChar ch = (UniChar)[aInput characterAtIndex:x];
        UniChar ch_y = ch^iY;
        NSString *tmpString =[NSString stringWithCharacters:&ch_y length:1];
        if (!tmpString) return @"";
        result = [result stringByReplacingCharactersInRange:NSMakeRange(x, 1) withString:[NSString stringWithCharacters:&ch_y length:1]];
    }
    return result;
}

@end

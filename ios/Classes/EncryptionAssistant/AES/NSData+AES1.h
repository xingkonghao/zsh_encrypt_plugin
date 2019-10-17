//
//  NSData+AES1.h
//  EncryptionAssistant
//
//  Created by 冯砚伟 on 2017/6/28.
//  Copyright © 2017年 冯砚伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES1)
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;

//解密
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;
@end

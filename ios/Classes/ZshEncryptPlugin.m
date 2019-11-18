#import "ZshEncryptPlugin.h"
#import <zsh_encrypt_plugin/zsh_encrypt_plugin-Swift.h>
#import <Foundation/Foundation.h>
#import "SecurityHelper.h"
#import "RSA.h"
@implementation ZshEncryptPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZshEncryptPlugin registerWithRegistrar:registrar];
    FlutterMethodChannel* channel = [FlutterMethodChannel
        methodChannelWithName:@"zsh_encrypt_plugin"
              binaryMessenger:[registrar messenger]];
    ZshEncryptPlugin* instance = [[ZshEncryptPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];

}
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
     NSDictionary *argsMap  = call.arguments;
    if ([@"getPlatformVersion" isEqualToString:call.method]) {

         result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);

     } else if([@"encrypt_aes" isEqualToString:call.method])
    {
        NSString *aesKey = argsMap[@"aesKey"];
        NSString *encryptString = argsMap[@"encryptString"];
        NSString *aesData = [SecurityHelper encryptString:encryptString?:@"" withSecurityType:SecurityType_AES withKey:aesKey?:@""];

        if(aesData)
        {
                result(aesData);

        }else{
            result([FlutterError errorWithCode:@"UNAVAILABLE"
            message:@"encrypt failed!"
            details:nil]);

        }
    }else if([@"encrypt_public_rsa" isEqualToString:call.method])
    {
        NSString *rsaKey = argsMap[@"rsaKey"];
        NSString *rsaString = argsMap[@"encryptString"];
        NSString *tag = argsMap[@"tag"];
        NSString *rsaData = [SecurityHelper encryptString:rsaString?:@"" withSecurityType:SecurityType_RSA withKey:rsaKey?:@"" withTag:tag?:@""];
        if(rsaData)
        {
                result(rsaData);

        }else{
            result([FlutterError errorWithCode:@"UNAVAILABLE"
            message:@"encrypt failed!"
            details:nil]);
        }

    }else if([@"encrypt_private_rsa" isEqualToString:call.method])
         {
             NSString *rsaKey = argsMap[@"rsaKey"];
             NSString *rsaString = argsMap[@"encryptString"];
             NSString *tag = argsMap[@"tag"];
             NSString *rsaData = [SecurityHelper encryptString:rsaString?:@"" withSecurityType:SecurityType_RSA withKey:rsaKey?:@"" withTag:tag?:@""];
             if(rsaData)
             {
                     result(rsaData);

             }else{
                 result([FlutterError errorWithCode:@"UNAVAILABLE"
                 message:@"encrypt failed!"
                 details:nil]);
             }

         }
    else if([@"decrypt_aes" isEqualToString:call.method])
    {
           NSString *aesKey = argsMap[@"aesKey"];
           NSString *decryptString = argsMap[@"decryptString"];
           NSString *deData = [SecurityHelper decryptString:decryptString?:@"" withSecurityType:SecurityType_AES withKey:aesKey?:@""];
           if(deData)
           {
                   result(deData);

           }else{
               result([FlutterError errorWithCode:@"UNAVAILABLE"
               message:@"decrypt failure!"
               details:nil]);

           }
    }else if([@"decrypt_public_rsa" isEqualToString:call.method]){
        NSString *rsaKey = argsMap[@"rsaKey"];
                NSString *decryptString = argsMap[@"decryptString"];
                NSString *tag = argsMap[@"tag"];
                NSString *deData = [SecurityHelper decryptString:decryptString?:@"" withSecurityType:SecurityType_RSA withKey:rsaKey?:@"" withTag:tag?:@""];
                if(deData)
                {
                        result(deData);

                }else{
                    result([FlutterError errorWithCode:@"UNAVAILABLE"
                    message:@"decrypt failure!"
                    details:nil]);
                }
    }else if([@"decrypt_private_rsa" isEqualToString:call.method]){
         NSString *rsaKey = argsMap[@"rsaKey"];
                        NSString *decryptString = argsMap[@"decryptString"];
                        NSString *tag = argsMap[@"tag"];
                        NSString *deData = [RSA decryptString:decryptString privateKey:rsaKey];
                        if(deData)
                        {
                                result(deData);

                        }else{
                            result([FlutterError errorWithCode:@"UNAVAILABLE"
                            message:@"decrypt failure!"
                            details:nil]);
                        }
    }
    else{
        result(FlutterMethodNotImplemented);
    }
}
@end

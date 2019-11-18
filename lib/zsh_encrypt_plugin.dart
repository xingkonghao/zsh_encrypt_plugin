import 'dart:async';

import 'package:flutter/services.dart';

class ZshEncryptPlugin {
  static const MethodChannel _channel =
      const MethodChannel('zsh_encrypt_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  //AES128 加密
  static Future<String> aes_encryptString(String txt,String key)async{
    try{
      final String result = await _channel.invokeMethod('encrypt_aes',{"encryptString":txt,"aesKey":key});
      return result;
    }on PlatformException catch(e){
      throw "Faield to get String encode: '${e.message}";
    }
  }


  //AES128 解密
  static Future<String> aes_decryptString(String txt,String key)async{
    try{
   final String result = await _channel.invokeMethod('decrypt_aes',{"decryptString":txt,"aesKey":key});
   return result;
   }on PlatformException catch(e){
   throw "Faield to get String decode: '${e.message}";
   }
  }
  //RSA 公钥加密
  static Future<String> rsa_public_encrptString(String txt,String publicKey,String tag)async{
    try{
      final String result = await _channel.invokeMethod('encrypt_public_rsa',{"encryptString":txt,"rsaKey":publicKey,"tag":tag});
      return result;
    }on PlatformException catch(e){
      throw "Failed to get String encode: '${e.message}";
    }
  }
//  //RSA 私钥加密
//  static Future<String> rsa_private_encrptString(String txt,String privateKey,String tag)async{
//    try{
//      final String result = await _channel.invokeMethod('encrypt_public_rsa',{"encryptString":txt,"rsaKey":privateKey,"tag":tag});
//      return result;
//    }on PlatformException catch(e){
//      throw "Failed to get String encode: '${e.message}";
//    }
//  }
  //RSA公钥解密
  static Future<String> rsa_public_decrptString(String txt,String publicKey,String tag)async{
    try{
      final String result = await _channel.invokeMethod('decrypt_public_rsa',{"decryptString":txt,"rsaKey":publicKey,"tag":tag});
      return result;
    }on PlatformException catch(e){
      throw "Failed to get String decode: '${e.message}";
    }
  }
//  //RSA私钥解密
//  static Future<String> rsa_private_decrptString(String txt,String privateKey,String tag)async{
//    try{
//      final String result = await _channel.invokeMethod('decrypt_private_rsa',{"decryptString":txt,"rsaKey":privateKey,"tag":tag});
//      return result;
//    }on PlatformException catch(e){
//      throw "Failed to get String decode: '${e.message}";
//    }
//  }
}

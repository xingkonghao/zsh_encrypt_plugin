import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:zsh_encrypt_plugin/zsh_encrypt_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String originalText = "我爱你中国";
  String aeskey = "asdfghjklzxcvbnm";
  String aesCiphertext;
  String aesDecryptedText;
  String rsaCiphertext;
  String rsaDecryptedText;
  var rsaPublicKey = 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDhSzPPnFn41iaz+t4tI4kbaXNuNFOsI8hFeCYtlwPFKRbETHbBS10bMvUbOWLFtRgZV3L924GQ9orbomEmJ1nWyaSO8iBbZAyiWUP5PJJh/b9kHj1MMwG712bGfYYPdjkRprNpzU9w4UBzUMKKUoHU4c/Gbb4XeBK9LNTPWQL4YwIDAQAB';
var rsaPrivateKey = 'MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOFLM8+cWfjWJrP63i0jiRtpc240U6wjyEV4Ji2XA8UpFsRMdsFLXRsy9Rs5YsW1GBlXcv3bgZD2ituiYSYnWdbJpI7yIFtkDKJZQ/k8kmH9v2QePUwzAbvXZsZ9hg92ORGms2nNT3DhQHNQwopSgdThz8Ztvhd4Er0s1M9ZAvhjAgMBAAECgYEAxwNLTUXsJGfn4Gzm/jC52MEZ+mu2zgT90IAGGZeg+PUG63gwHyeXo4MsCVRz7/m8xAX/ykew+IEQwFt8Pdvc+rrs5yml4gOBPfhpau5QaI75xNjnyH7UA3mbRCZeyZrvuKqtY/f8pCgzy3EBWnRpkcsqeE6bsOQrD45mltr+0QECQQDynvhKEh+hD5xBpF/DIP8Fp6fizexHdA6+aZT/gLaFA4XgZ9HEDDBhvNdadyYUNOLWhkxRHv6CkT5azfLXsJEhAkEA7begtbBCDXDf1+DRh3j2S8zcv6+utYgcpjvxZqjbPi6UIWXLxI80PIwQ0uouHCUMjikBA6VX9vTbw9TZ/IelAwJBAKI3W7baiz86mrTg3A4w/5GeWQexuurDVCBHo5F5U493nYk+oOe9ZpPSmQIpa9JS0d+xB1GtsWlHBzPbQySnL0ECQA/btCjqvT1QTl6EbPXwp92eqQtQmQMbNW4RiaUjlpyrVs5zkAho1T9EyMqJPNI71n6VVa/8k8WxyAdkZ7ZlBikCQEkNe1+sAKnh+AFGCJ+6WAq1J2RuIgcA6bVL3ip7F2NHdE+N+tR9JqWw3JNCweWmAlzKIGs6eKSVD5egzKaLXss=';
 String tag = 'AM0003';
  @override
  void initState() {
    super.initState();
  }


  Future aes_encode() async{
    String result;
    try {
      result = await ZshEncryptPlugin.aes_encryptString(originalText, aeskey);
      print(result);
      setState(() {
        aesCiphertext = result;
      });
    }on PlatformException{
      print("aes encrypt error");
    }
  }
  Future aesDecode()async{
    String result;
    try {
      result = await ZshEncryptPlugin.aes_decryptString(aesCiphertext, aeskey);
      print(result);
      setState(() {
        aesDecryptedText = result;
      });
    }on PlatformException{
      print("aes decrypt error");
    }
  }
  Future rsaPublicEncrypt()async{
    String result;
    try {
      result = await ZshEncryptPlugin.rsa_public_encrptString(originalText, rsaPublicKey, tag);
      print('rsa encrypt: $result');
      setState(() {
        rsaCiphertext = result;
      });
    }on PlatformException{
      print("rsa encrypt error");
    }
  }
  Future rsaPublicDecrypt()async{
    String result;
    try {
      String encryption = 'mz/zSpMXqTXjUt2GCBaDUB6NGOA3XRDi9y5HmVFmAzWb1SIT94t7Ybq1Vh1xyKecazuI/UJcyJh2GLpC+CvLdyS5SBrDv0veQ4tNpBMlHqkOdliQwp0UKahkYduAhl/mOR1USBCnLADQ3LCOft0/N7R/GgFRhXINzx51zzvYrC8=';

      result = await ZshEncryptPlugin.rsa_public_decrptString(encryption, rsaPublicKey, tag);
      print('rsa decrypt: $result');
      setState(() {
        rsaDecryptedText = result;
      });
    }on PlatformException{
      print("rsa decrypt error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text(' original text:$originalText '),
            ),
            FlatButton(onPressed: ()=> {
            aes_encode(),


            }, child: Text('AES Encrypt')),
            Text('aes_Ciphertext: $aesCiphertext'),
            FlatButton(onPressed: ()=>{
              if(aesCiphertext.length>0)
                {
                  aesDecode()

                }
            }, child: Text('AES Decrypt')),
            Text('aes_DecryptedText: $aesDecryptedText'),

            FlatButton(onPressed: ()=>{
              rsaPublicEncrypt()

            }, child: Text('RSA Encrypt')),
            Text('$rsaCiphertext'),

            FlatButton(onPressed: ()=>{
              rsaPublicDecrypt()
            }, child: Text('RSA Decrypt')),
            Text('$rsaDecryptedText'),

          ],

        )
      ),
    );
  }
}

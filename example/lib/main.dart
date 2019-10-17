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
      print("aes encode error");
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
      print("aes encode error");
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
              aesDecode()
            }, child: Text('AES Decrypt')),
            Text('aes_DecryptedText: $aesDecryptedText'),

            FlatButton(onPressed: ()=>{

            }, child: Text('RSA Encrypt')),
            FlatButton(onPressed: ()=>{}, child: Text('RSA Decrypt')),

          ],

        )
      ),
    );
  }
}

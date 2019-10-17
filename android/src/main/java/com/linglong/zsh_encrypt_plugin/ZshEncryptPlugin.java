
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
package android.src.main.java.com.linglong.zsh_encrypt_plugin.Aes;

public  class ZshEmcrptPlugin implements  MethodCallHandler{
    public  static  void registerWith(Registrar registrar){
        final  MethodChannel channel = new MethodChannel(registrar.messenger(),"zsh_encrypt_plugin");
        channel.setMethodCallHandler(new ZshEmcrptPlugin());
    }
    @Override
    public  void onMethodCall(MethodCall call,Result result){
        if (call.method.equauls("getPlatformVersion")){
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        }else  if (call.method.equals("encrypt_aes")){
            String aesKey = call.argument("aesKey");
            NSString *encryptString = argsMap[@"encryptString"];
            try {
                String data = Base64.encode(AESUtils.encrypt(encryptString, aesKey));
                result.success(data);
            }catch (Exception e) {
                e.printStackTrace();
                result.error("UNAVAILABLE","Encrypt failure",null);
            }

        }else if(call.method.equals("encrypt_rsa")){
            String rsaKey = call.argument["rsaKey"];
            String encryptString = call.argument["encryptString"];

            try {
                String nonce = Base64.encode(RSAUtils.encryptByPublicKey(encryptString.getBytes(),rsaKey));
                result.success(data);
            }catch (Exception e) {
                e.printStackTrace();
                result.error("UNAVAILABLE","Encrypt failure",null);

            }
        }else if(call.method.equals("decrypt_aes")){
            String aesKey = call.argument("aesKey");
            NSString *decryptString = argsMap[@"decryptString"];
            try {
                String data = Base64.encode(AESUtils.decrypt(decryptString,aesKey));
                result.success(data);
            }catch (Exception e){
                e.printStackTrace();
                result.error("UNAVAILABLE","Encrypt failure",null);
            }
        }else if(call.method.equals("decrypt_rsa"){
            String rsaKey = call.argument["rsaKey"];
            String decryptString = call.argument["decryptString"];
            try {
                String nonce = Base64.encode(RSAUtils.decryptByPublicKey(decryptString.getBytes(),rsaKey));
                result.success(data);
            }catch (Exception e) {
                e.printStackTrace();
                result.error("UNAVAILABLE","Encrypt failure",null);

            }
        }

    }

}


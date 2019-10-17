import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zsh_encrypt_plugin/zsh_encrypt_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('zsh_encrypt_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ZshEncryptPlugin.platformVersion, '42');
  });
}

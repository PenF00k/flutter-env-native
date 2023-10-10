import 'package:env_native/env_native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('', (tester) async {
    const channel = MethodChannel('penf00k.ru/env_native');
    tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (methodCall) async => 42);

    expect(await EnvNative.getInt('test_int'), 42);
  });
}

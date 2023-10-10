import 'dart:async';

import 'package:flutter/services.dart';

class EnvNative {
  static const MethodChannel _channel =
      MethodChannel('penf00k.ru/env_native');

  static Future<String?> getString(String key) =>
      _get<String>('getString', key);

  static Future<int?> getInt(String key) => _get<int>('getInt', key);

  static Future<T?> _get<T>(String methodName, String key) =>
      _channel.invokeMethod<T>(methodName, key);
}

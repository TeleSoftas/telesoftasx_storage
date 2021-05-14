import 'package:flutter/services.dart';

class TelesoftasxSecureStorage {
  static const MethodChannel _channel =
      const MethodChannel('telesoftasx_secure_storage');

  static Future<dynamic> put(String key, dynamic value) async => _channel.invokeMethod('put', {'key': key, 'value': value});

  static Future<String?> getString(String key, {String? defaultValue}) =>
      _channel.invokeMethod('getString', {'key': key, 'defaultValue': defaultValue});

  static Future<bool?> getBool(String key, {defaultValue = false}) =>
      _channel.invokeMethod('getBool', {'key': key, 'defaultValue': defaultValue});

  static Future<double?> getDouble(String key, {double defaultValue = -1}) =>
      _channel.invokeMethod('getDouble', {'key': key, 'defaultValue': defaultValue});

  static Future<int?> getInt(String key, {int defaultValue = -1}) =>
      _channel.invokeMethod('getInt', {'key': key, 'defaultValue': defaultValue});
}

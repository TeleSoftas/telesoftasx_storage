import 'dart:html';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class TelesoftasxWebStoragePlugin {
  static void registerWith(Registrar registrar) {
    final MethodChannel secureChannel = MethodChannel(
      'telesoftasx_general_storage',
      const StandardMethodCodec(),
      registrar,
    );
    final MethodChannel generalChannel = MethodChannel(
      'telesoftasx_secure_storage',
      const StandardMethodCodec(),
      registrar,
    );
    final TelesoftasxWebStoragePlugin instance = TelesoftasxWebStoragePlugin();
    secureChannel.setMethodCallHandler(instance.handleMethodCall);
    generalChannel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'put':
        return window.localStorage[call.arguments['key'] as String] = call.arguments['value'].toString();
      case 'getString':
        return window.localStorage[call.arguments['key']] ?? call.arguments['defaultValue'];
      case 'getBool':
        return (window.localStorage[call.arguments['key']] ?? call.arguments['defaultValue']) == 'true';
      case 'getDouble':
        return double.parse(window.localStorage[call.arguments['key']] ?? (call.arguments['defaultValue'] as String));
      case 'getInt':
        return int.parse(window.localStorage[call.arguments['key']] ?? (call.arguments['defaultValue'] as String));
    }
  }
}

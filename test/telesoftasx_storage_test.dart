import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telesoftasx_storage/telesoftasx_storage.dart';

void main() {
  const MethodChannel channel = MethodChannel('telesoftasx_storage');

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
    expect(await TelesoftasxStorage.platformVersion, '42');
  });
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pano_rtc/pano_rtc.dart';

void main() {
  const MethodChannel channel = MethodChannel('pano_rtc');

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
    expect(await PanoRtc.platformVersion, '42');
  });
}

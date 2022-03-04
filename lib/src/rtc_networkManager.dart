import 'package:flutter/services.dart';

import '../pano_rtc.dart';
import 'enum_converter.dart';

/// The RtcNetworkManager class.
class RtcNetworkManager with RtcNetworkManagerInterface {
  static const MethodChannel _methodChannel =
      MethodChannel('pano_rtc/api_networkMgr');
  static const EventChannel _eventChannel =
      EventChannel('pano_rtc/events_networkMgr');
  RtcNetworkMgrHandler? _handler;

  Future<T?> _invokeMethod<T>(String method,
      [Map<String, dynamic>? arguments]) {
    return _methodChannel.invokeMethod(method, arguments);
  }

  Future<ResultCode> _invokeCodeMethod(String method,
      [Map<String, dynamic>? arguments]) {
    return _invokeMethod(method, arguments).then((value) {
      return ResultCodeConverter.fromValue(value).e;
    });
  }

  /// @nodoc
  RtcNetworkManager() {
    _eventChannel.receiveBroadcastStream().listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final methodName = eventMap['methodName'] as String?;
      final data = List<dynamic>.from(eventMap['data']);
      _handler?.process(methodName, data);
    });
  }

  /// Sets the network manager event handler.
  ///
  /// After setting the network manager event handler, you can listen for network manager events and receive the statistics of the corresponding [RtcNetworkManager] instance.
  ///
  /// **Parameter** [handler] The event handler.
  void setEventHandler(RtcNetworkMgrHandler handler) {
    _handler = handler;
  }

  @override
  Future<ResultCode> startNetworkTest(String token) {
    return _invokeCodeMethod('startNetworkTest', {'token': token});
  }

  @override
  Future<ResultCode> stopNetworkTest() {
    return _invokeCodeMethod('stopNetworkTest');
  }
}

/// The network manager interface
mixin RtcNetworkManagerInterface {
  /// Start test network.
  ///
  /// **Parameter** [token] the secure token that App Server got from PANO
  ///               the channelId can be PANO_NHC_NetworkTest when generating this token
  ///               NOTE: don't use the token which is used for joining RtcChannel
  /// **Returns**
  ///  - [ResultCode.OK] Success
  ///  - others: Failure
  /// **Note** The RtcEngine must be initialized firstly before startNetworkTest
  ///      The network test will consume additional bandwidth, please avoid doing network test in call
  ///
  /// 启动网络测试。
  ///
  /// **Parameter** [token] App服务器向PANO获取的token。生成此 token 时 channelId 可为 PANO_NHC_NetworkTest
  ///               注意：不要使用加入 RtcChannel 时使用的 token
  /// **Returns**
  ///  - [ResultCode.OK] 成功
  ///  - 其他: 失败
  /// **Note** 在启动 startNetworkTest 前必须先初始化 RtcEngine
  ///      网络测试会产生额外流量，尽量避免在通话过程中进行测试。
  Future<ResultCode> startNetworkTest(String token);

  /// Stop test network.
  ///
  /// **Returns**
  ///  - [ResultCode.OK] Success
  ///  - others: Failure
  ///
  /// 停止网络测试。
  ///
  /// **Returns**
  ///  - [ResultCode.OK] 成功
  ///  - 其他: 失败
  Future<ResultCode> stopNetworkTest();
}

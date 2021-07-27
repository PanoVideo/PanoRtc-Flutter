import 'package:flutter/services.dart';

import '../pano_rtc.dart';

/// The RtcNetworkManager class.
class RtcNetworkManager with RtcNetworkManagerInterface {
  static const MethodChannel _methodChannel =
      MethodChannel('pano_rtc/api_networkMgr');
  static const EventChannel _eventChannel =
      EventChannel('pano_rtc/events_networkMgr');
  RtcNetworkMgrHandler? _handler;

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
  Future<ResultCode?> startNetworkTest(String token) {
    return _methodChannel.invokeMethod('startNetworkTest', {'token': token});
  }

  @override
  Future<ResultCode?> stopNetworkTest() {
    return _methodChannel.invokeMethod('stopNetworkTest');
  }
}

/// The network manager interface
mixin RtcNetworkManagerInterface {
  /// Start test network.
  ///
  /// **Parameter** [token] the secure token that App Server got from PANO
  ///               the channelId can be PANO_NHC_NetworkTest when generating this token
  ///               NOTE: don't use the token which is used for joining RtcChannel
  ///@return
  ///  - [ResultCode.OK] Success
  ///  - others: Failure
  ///@note The RtcEngine must be initialized firstly before startNetworkTest
  ///      The network test will consume additional bandwidth, please avoid doing network test in call
  ///
  /// 启动网络测试。
  ///
  /// **Parameter** [token] App服务器向PANO获取的token。生成此 token 时 channelId 可为 PANO_NHC_NetworkTest
  ///               注意：不要使用加入 RtcChannel 时使用的 token
  ///@return
  ///  - [ResultCode.OK] 成功
  ///  - 其他: 失败
  ///@note 在启动 startNetworkTest 前必须先初始化 RtcEngine
  ///      网络测试会产生额外流量，尽量避免在通话过程中进行测试。
  Future<ResultCode?> startNetworkTest(String token);

  /// Stop test network.
  ///
  ///@return
  ///  - [ResultCode.OK] Success
  ///  - others: Failure
  ///
  /// 停止网络测试。
  ///
  ///@return
  ///  - [ResultCode.OK] 成功
  ///  - 其他: 失败
  Future<ResultCode?> stopNetworkTest();
}

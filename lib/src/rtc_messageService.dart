import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import '../pano_rtc.dart';
import 'enum_converter.dart';
import 'rtc_enums.dart';

/// The RtcMessageService class.
class RtcMessageService with RtcMessageServiceInterface {
  static const MethodChannel _methodChannel = MethodChannel('pano_rtc/api_rtm');
  static const EventChannel _eventChannel = EventChannel('pano_rtc/events_rtm');
  RtcMessageServiceHandler _handler;

  /// @nodoc
  RtcMessageService() {
    _eventChannel.receiveBroadcastStream().listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final methodName = eventMap['methodName'] as String;
      final data = List<dynamic>.from(eventMap['data']);
      _handler?.process(methodName, data);
    });
  }

  Future<T> _invokeMethod<T>(String method, [Map<String, dynamic> arguments]) {
    if (T == ResultCode) {
      return _methodChannel.invokeMethod(method, arguments).then((value) {
        return ResultCodeConverter.fromValue(value).e as T;
      });
    } else {
      return _methodChannel.invokeMethod(method, arguments);
    }
  }

  /// Sets the RtcMessageService event handler.
  ///
  /// After setting the RtcMessageService event handler, you can listen for RtcMessageService events and receive the statistics of the corresponding [RtcMessageService] instance.
  ///
  /// **Parameter** [handler] The event handler.
  void setEventHandler(RtcMessageServiceHandler handler) {
    _handler = handler;
  }

  @override
  Future<ResultCode> broadcastMessage(Uint8List message,
      {bool sendBack = true}) {
    return _invokeMethod(
        'broadcastMessage', {'message': message, 'sendBack': sendBack});
  }

  @override
  Future<ResultCode> sendMessage(Uint8List message, String userId) {
    return _invokeMethod('sendMessage', {'message': message, 'userId': userId});
  }
}

/// The RtcMessageService interface
mixin RtcMessageServiceInterface {
  /// Send message to the user specified by userId.
  ///
  /// **Parameter** [message] The message data.
  ///
  /// **Parameter** [userId] The user who will receive the message.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// You can send messages at a maximum frequency of 150 calls every 3 seconds. The maximum data length is 4 KB.
  ///
  /// 发送消息给某个指定用户。
  ///
  /// **Parameter** [message] 要发送的消息。
  ///
  /// **Parameter** [userId] 接收消息的用户。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 发送消息的调用频率上限为每 3 秒 150 次。请确保二进制消息大小不超过 4 KB。
  Future<ResultCode> sendMessage(Uint8List message, String userId);

  /// Broadcast message to all users.
  ///
  /// **Parameter** [message] The message data.
  /// **Parameter** [sendBack] Send back flag.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// You can send messages at a maximum frequency of 150 calls every 3 seconds. The maximum data length is 4 KB.
  ///
  /// 广播消息给所有用户。
  ///
  /// **Parameter** [message] 要广播的消息。
  /// **Parameter** [sendBack] 是否回发消息。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 发送消息的调用频率上限为每 3 秒 150 次。请确保二进制消息大小不超过 4 KB。
  Future<ResultCode> broadcastMessage(Uint8List message,
      {bool sendBack = true});
}

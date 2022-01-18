import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import '../pano_rtc.dart';
import 'enum_converter.dart';

/// The RtcMessageService class.
class RtcMessageService with RtcMessageServiceInterface {
  static const MethodChannel _methodChannel = MethodChannel('pano_rtc/api_rtm');
  static const EventChannel _eventChannel = EventChannel('pano_rtc/events_rtm');
  RtcMessageServiceHandler? _handler;

  /// @nodoc
  RtcMessageService() {
    _eventChannel.receiveBroadcastStream().listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final methodName = eventMap['methodName'] as String?;
      final data = List<dynamic>.from(eventMap['data']);
      _handler?.process(methodName, data);
    });
  }

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

  /// Sets the RtcMessageService event handler.
  ///
  /// After setting the RtcMessageService event handler, you can listen for RtcMessageService events and receive the statistics of the corresponding [RtcMessageService] instance.
  ///
  /// **Parameter** [handler] The event handler.
  void setEventHandler(RtcMessageServiceHandler handler) {
    _handler = handler;
  }

  @override
  Future<ResultCode> setProperty(String name, Uint8List value) {
    return _invokeCodeMethod('setProperty', {'name': name, 'value': value});
  }

  @override
  Future<ResultCode> sendMessage(Uint8List message, String userId) {
    return _invokeCodeMethod(
        'sendMessage', {'message': message, 'userId': userId});
  }

  @override
  Future<ResultCode> broadcastMessage(Uint8List message,
      {bool sendBack = true}) {
    return _invokeCodeMethod(
        'broadcastMessage', {'message': message, 'sendBack': sendBack});
  }

  @override
  Future<ResultCode> publish(String topic, Uint8List data) {
    return _invokeCodeMethod('publish', {'topic': topic, 'data': data});
  }

  @override
  Future<ResultCode> subscribe(String topic) {
    return _invokeCodeMethod('subscribe', {'topic': topic});
  }

  @override
  Future<ResultCode> unsubscribe(String topic) {
    return _invokeCodeMethod('unsubscribe', {'topic': topic});
  }
}

/// The RtcMessageService interface
mixin RtcMessageServiceInterface {
  ///  @~english
  ///  @brief Set or update meeting property.
  ///  @param name  The property name.
  ///  @param value  The to be set. if value is null or length is 0,
  ///                then the property will be removed from server.
  ///  @return
  ///   - OK: Success.
  ///   - others: Failure.
  ///  @~chinese
  ///  @brief 设置或更属性。
  ///  @param name  属性名字。
  ///  @param value  属性值。如果 value 为空，或者 length 为0，则此属性会被删除。
  ///  @return
  ///   - OK: 调用成功。
  ///   - others: 调用失败。
  Future<ResultCode> setProperty(String name, Uint8List value);

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

  /// @~english
  /// @brief Publish topic.
  /// @param topic  The topic.
  /// @param data  The topic data.
  /// @return
  ///   - OK: Success.
  ///   - others: Failure.
  /// @note You can send messages at a maximum frequency of 150 calls every 3 seconds.
  ///       The maximum data length is 4 KB.
  /// @~chinese
  /// @brief 发布一个主题。
  /// @param topic  主题标识。
  /// @param data  主题数据。
  /// @return
  ///   - OK: 成功。
  ///   - 其他: 失败。
  /// @note 发送消息的调用频率上限为每 3 秒 150 次。
  ///       请确保二进制消息大小不超过 4 KB。
  Future<ResultCode> publish(String topic, Uint8List data);

  /// @~english
  /// @brief Subscribe topic.
  /// @param topic  The topic.
  /// @return
  ///   - OK: Success.
  ///   - others: Failure.
  /// @~chinese
  /// @brief 订阅一个主题。
  /// @param topic  主题标识。
  /// @return
  ///   - OK: 成功。
  ///   - 其他: 失败。
  Future<ResultCode> subscribe(String topic);

  /// @~english
  /// @brief Unsubscribe topic.
  /// @param topic  The topic.
  /// @return
  ///   - OK: Success.
  ///   - others: Failure.
  /// @~chinese
  /// @brief 取消订阅一个主题。
  /// @param topic  主题标识。
  /// @return
  ///   - OK: 成功。
  ///   - 其他: 失败。
  Future<ResultCode> unsubscribe(String topic);
}

/// Property action type.
///
/// @brief 属性操作类型。
class RtcPropertyAction {
  /// Action type.
  ///
  /// 属性操作类型。
  final ActionType? type;

  /// The property name.
  ///
  /// 属性名字。
  final String? propName;

  /// The property value.
  ///
  /// 属性值。
  final Uint8List? propValue;

  /// Constructs a [RtcPropertyAction]
  RtcPropertyAction(this.type, this.propName, this.propValue);
}

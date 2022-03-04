import 'package:flutter/services.dart';

import '../pano_rtc.dart';
import 'enum_converter.dart';

class RtcGroupManager with RtcGroupManagerInterface {
  static const MethodChannel _methodChannel =
      MethodChannel('pano_rtc/api_group');
  static const EventChannel _eventChannel =
      EventChannel('pano_rtc/events_group');

  RtcGroupEventHandler? _handler;

  /// @nodoc
  RtcGroupManager() {
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

  /// Set the RtcGroupManager event handler.
  ///
  /// After setting the RtcGroupManager event handler, you can listen for RtcGroupManager events and receive the statistics of the corresponding [RtcGroupManager] instance.
  ///
  /// **Parameter** [handler] The event handler.
  void setEventHandler(RtcGroupEventHandler handler) {
    _handler = handler;
  }

  @override
  Future<ResultCode> joinGroup(String groupId, GroupConfig config) {
    return _invokeCodeMethod(
        'joinGroup', {'groupId': groupId, 'config': config.toJson()});
  }

  @override
  Future<ResultCode> subscribeGroup(String groupId) {
    return _invokeCodeMethod('subscribeGroup', {'groupId': groupId});
  }

  @override
  Future<ResultCode> unsubscribeGroup(String groupId) {
    return _invokeCodeMethod('unsubscribeGroup', {'groupId': groupId});
  }

  @override
  Future<ResultCode> leaveGroup(String groupId) {
    return _invokeCodeMethod('leaveGroup', {'groupId': groupId});
  }

  @override
  Future<ResultCode> inviteGroupUsers(String groupId, List<String> users) {
    return _invokeCodeMethod(
        'inviteGroupUsers', {'groupId': groupId, 'users': users});
  }

  @override
  Future<ResultCode> dismissGroup(String groupId) {
    return _invokeCodeMethod('dismissGroup', {'groupId': groupId});
  }

  @override
  Future<ResultCode> setDefaultGroup(String? groupId) {
    return _invokeCodeMethod('setDefaultGroup', {'groupId': groupId});
  }

  @override
  Future<ResultCode> observeGroup(String groupId) {
    return _invokeCodeMethod('observeGroup', {'groupId': groupId});
  }

  @override
  Future<ResultCode> unobserveGroup(String groupId) {
    return _invokeCodeMethod('unobserveGroup', {'groupId': groupId});
  }

  @override
  Future<ResultCode> observeAllGroups() {
    return _invokeCodeMethod('observeAllGroups');
  }

  @override
  Future<ResultCode> unobserveAllGroups() {
    return _invokeCodeMethod('unobserveAllGroups');
  }
}

/// The group manager interface.
///
/// 分组服务核心接口。
mixin RtcGroupManagerInterface {
  /// Join group.
  ///
  /// **Parameter** [groupId] The group ID. Max length is 128 bytes.
  /// **Parameter** [config] The group parameters.
  /// **Returns**
  ///  - [ResultCode.OK] Success.
  ///  - others: Failure.
  ///
  /// 加入分组。
  ///
  /// **Parameter** [groupId] 分组标识。最大长度是128字节。
  /// **Parameter** [config] 分组配置参数。
  /// **Returns**
  ///  - [ResultCode.OK] 成功。
  ///  - 其他: 失败。
  Future<ResultCode> joinGroup(String groupId, GroupConfig config);

  /// Subscribe group.
  ///
  /// **Parameter** [groupId] The group ID.
  /// **Returns**
  ///  - [ResultCode.OK] Success.
  ///  - others: Failure.
  ///
  /// 订阅分组。
  ///
  /// **Parameter** [groupId] 分组标识。
  /// **Returns**
  ///  - [ResultCode.OK] 成功。
  ///  - 其他: 失败。
  Future<ResultCode> subscribeGroup(String groupId);

  /// Unsubscribe group.
  ///
  /// **Parameter** [groupId] The group ID.
  /// **Returns**
  ///  - [ResultCode.OK] Success.
  ///  - others: Failure.
  ///
  /// 取消订阅分组。
  ///
  /// **Parameter** [groupId] 分组标识。
  /// **Returns**
  ///  - [ResultCode.OK] 成功。
  ///  - 其他: 失败。
  Future<ResultCode> unsubscribeGroup(String groupId);

  /// Leave group.
  ///
  /// **Parameter** [groupId] The group ID.
  /// **Returns**
  ///  - [ResultCode.OK] Success.
  ///  - others: Failure.
  ///
  /// 离开分组。
  ///
  /// **Parameter** [groupId] 分组标识。
  /// **Returns**
  ///  - [ResultCode.OK] 成功。
  ///  - 其他: 失败。
  Future<ResultCode> leaveGroup(String groupId);

  /// Invite user to join group.
  ///
  /// **Parameter** [groupId] The group ID.
  /// **Parameter** [users] The users to be invited.
  /// **Returns**
  ///  - [ResultCode.OK] Success.
  ///  - others: Failure.
  ///
  /// 邀请用户加入分组。
  ///
  /// **Parameter** [groupId] 分组标识。
  /// **Parameter** [users] 受邀用户列表。
  /// **Returns**
  ///  - [ResultCode.OK] 成功。
  ///  - 其他: 失败。
  Future<ResultCode> inviteGroupUsers(String groupId, List<String> users);

  /// Dismiss group.
  ///
  /// **Parameter** [groupId] The group ID.
  /// **Returns**
  ///  - [ResultCode.OK] Success
  ///  - others: Failure
  ///
  /// 解散分组。
  ///
  /// **Parameter** [groupId] 分组标识。
  /// **Returns**
  ///  - [ResultCode.OK] 成功
  ///  - 其他: 失败
  Future<ResultCode> dismissGroup(String groupId);

  /// Set default group. When automatic audio subscription is enabled, new users
  /// will automatically join and subscribe to the default group after joining
  /// the channel with the default group setting.
  ///
  /// **Parameter** [groupId] The group ID. Max length is 128 bytes. Set null to cancel the default group.
  /// **Returns**
  ///  - [ResultCode.OK] Success
  ///  - others: Failure
  ///
  /// 设置默认分组。在音频自动订阅启用的情况下，默认分组设置后新用户加入频道会自动加入和订阅默认分组。
  ///
  /// **Parameter** [groupId] 分组标识。最大长度是128字节。置空为取消默认分组设置。
  /// **Returns**
  ///  - [ResultCode.OK] 成功
  ///  - 其他: 失败
  Future<ResultCode> setDefaultGroup(String? groupId);

  /// Observe group event.
  ///
  /// **Parameter** [groupId] The group ID.
  /// **Returns**
  ///  - [ResultCode.OK] Success.
  ///  - others: Failure.
  ///
  /// 观察指定分组的事件。调用成功后可在未加入分组的情况下接收分组事件。
  ///
  /// **Parameter** [groupId] 分组标识。
  /// **Returns**
  ///  - [ResultCode.OK] 成功。
  ///  - 其他: 失败
  Future<ResultCode> observeGroup(String groupId);

  /// Unobserve group event.
  ///
  /// **Parameter** [groupId] The group ID.
  /// **Returns**
  ///  - [ResultCode.OK] Success.
  ///  - others: Failure.
  ///
  /// 取消观察指定分组的事件。
  ///
  /// **Parameter** [groupId] 分组标识。
  /// **Returns**
  ///  - [ResultCode.OK] 成功。
  ///  - 其他: 失败
  Future<ResultCode> unobserveGroup(String groupId);

  /// Observe all groups‘ event.
  ///
  /// **Returns**
  ///  - [ResultCode.OK] Success.
  ///  - others: Failure.
  ///
  /// 观察所有分组的事件，包括后续创建的分组。调用成功后可在未加入分组的情况下接收分组事件。
  ///
  /// **Returns**
  ///  - [ResultCode.OK] 成功。
  ///  - 其他: 失败
  Future<ResultCode> observeAllGroups();

  /// Unobserve all groups’ event.
  ///
  /// **Returns**
  ///  - [ResultCode.OK] Success.
  ///  - others: Failure.
  ///
  /// 取消观察所有分组的事件。
  ///
  /// **Returns**
  ///  - [ResultCode.OK] 成功。
  ///  - 其他: 失败
  Future<ResultCode> unobserveAllGroups();
}

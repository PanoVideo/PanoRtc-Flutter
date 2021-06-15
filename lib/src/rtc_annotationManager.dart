import 'package:flutter/services.dart';
import 'package:pano_rtc/src/rtc_annotation.dart';

import '../pano_rtc.dart';
import 'enum_converter.dart';

/// The RtcAnnotationManager class.
class RtcAnnotationManager with RtcAnnotationManagerInterface {
  static const MethodChannel _methodChannel =
      MethodChannel('pano_rtc/api_annotationMgr');
  static const EventChannel _eventChannel =
      EventChannel('pano_rtc/events_annotationMgr');
  AnnotationMgrEventHandler _handler;

  /// @nodoc
  static final Map<String, RtcAnnotation> annotations = {};

  /// @nodoc
  RtcAnnotationManager() {
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

  /// @nodoc
  void destroy() {
    annotations.clear();
  }

  /// Sets the annotation manager event handler.
  ///
  /// After setting the annotation manager event handler, you can listen for annotation manager events and receive the statistics of the corresponding [RtcAnnotationManager] instance.
  ///
  /// **Parameter** [handler] The event handler.
  void setEventHandler(AnnotationMgrEventHandler handler) {
    _handler = handler;
  }

  @override
  Future<RtcAnnotation> getShareAnnotation(String userId) async {
    var annotationId =
        await _invokeMethod('getShareAnnotation', {'userId': userId}) as String;
    if (annotationId.isNotEmpty) {
      annotations[annotationId] ??= RtcAnnotation(annotationId);
      return annotations[annotationId];
    }
    return null;
  }

  @override
  Future<RtcAnnotation> getVideoAnnotation(String userId, int streamId) async {
    var annotationId = await _invokeMethod(
            'getVideoAnnotation', {'userId': userId, 'streamId': streamId})
        as String;
    if (annotationId.isNotEmpty) {
      annotations[annotationId] ??= RtcAnnotation(annotationId);
      return annotations[annotationId];
    }
    return null;
  }
}

/// The annotation manager interface
mixin RtcAnnotationManagerInterface {
  /// Get video annotation object.
  ///
  /// **Parameter** [userId] User ID
  ///
  /// **Parameter** [streamId] Stream ID
  ///
  /// **Returns**
  ///  - non-null: a pointer to the video annotation object
  ///  - others: Failure
  ///
  /// 获取视频标注对象
  ///
  /// **Parameter** [userId] 用户ID
  ///
  /// **Parameter** [streamId] 视频流ID
  ///
  /// **Returns**
  /// - 非空指针： 指向视频标注对象的指针。
  /// - 空指针: 失败
  Future<RtcAnnotation> getVideoAnnotation(String userId, int streamId);

  /// Get share annotation object.
  ///
  /// **Parameter** [userId] User ID
  ///
  /// **Returns**
  ///  - non-null: a pointer to the share annotation object
  ///  - others: Failure
  ///
  /// 获取共享标注对象
  ///
  /// **Parameter** [userId] 用户ID
  ///
  /// **Returns**
  /// - 非空指针： 指向共享标注对象的指针。
  /// - 空指针: 失败
  Future<RtcAnnotation> getShareAnnotation(String userId);
}

import 'dart:async';

import 'package:flutter/services.dart';

import '../pano_rtc.dart';
import 'enum_converter.dart';

/// The RtcAnnotation class.
class RtcAnnotation with RtcAnnotationInterface {
  static const MethodChannel _methodChannel =
      MethodChannel('pano_rtc/api_annotation');
  static const EventChannel _eventChannel =
      EventChannel('pano_rtc/events_annotation');

  static StreamSubscription? _subscription;

  /// The ID of RtcAnnotation
  final String annotationId;

  AnnotationEventHandler? _handler;

  /// @nodoc
  RtcAnnotation(this.annotationId);

  Future<T?> _invokeMethod<T>(String method,
      [Map<String, dynamic>? arguments]) {
    var args = arguments == null
        ? {'annotationId': annotationId}
        : {'annotationId': annotationId, ...arguments};
    return _methodChannel.invokeMethod(method, args);
  }

  Future<ResultCode> _invokeCodeMethod(String method,
      [Map<String, dynamic>? arguments]) {
    return _invokeMethod(method, arguments).then((value) {
      return ResultCodeConverter.fromValue(value).e;
    });
  }

  /// Sets the annotation event handler.
  ///
  /// After setting the annotation event handler, you can listen for annotation events and receive the statistics of the corresponding [RtcAnnotation] instance.
  ///
  /// **Parameter** [handler] The event handler.
  void setEventHandler(AnnotationEventHandler handler) {
    _handler = handler;
    _subscription ??= _eventChannel.receiveBroadcastStream().listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final annotationId = eventMap['annotationId'];
      final methodName = eventMap['methodName'] as String?;
      final data = List<dynamic>.from(eventMap['data']);
      RtcAnnotationManager.annotations[annotationId]?._handler
          ?.process(methodName, data);
    });
  }

  @override
  Future<ResultCode> clearContents() {
    return _invokeCodeMethod('clearContents');
  }

  @override
  Future<ResultCode> clearUserContents(String userId) {
    return _invokeCodeMethod('clearUserContents', {'userId': userId});
  }

  @override
  Future<ResultCode> redo() {
    return _invokeCodeMethod('redo');
  }

  @override
  Future<ResultCode> setColor(WBColor color) {
    return _invokeCodeMethod('setColor', {'color': color.toJson()});
  }

  @override
  Future<ResultCode> setFontSize(int size) {
    return _invokeCodeMethod('setFontSize', {'size': size});
  }

  @override
  Future<ResultCode> setFontStyle(WBFontStyle style) {
    return _invokeCodeMethod(
        'setFontStyle', {'style': WBFontStyleConverter(style).value()});
  }

  @override
  Future<ResultCode> setLineWidth(int size) {
    return _invokeCodeMethod('setLineWidth', {'size': size});
  }

  @override
  Future<ResultCode> setRoleType(WBRoleType type) {
    return _invokeCodeMethod(
        'setRoleType', {'type': WBRoleTypeConverter(type).value()});
  }

  @override
  Future<ResultCode> setToolType(WBToolType type) {
    return _invokeCodeMethod(
        'setToolType', {'type': WBToolTypeConverter(type).value()});
  }

  @override
  Future<ResultCode> setVisible(bool visible) {
    return _invokeCodeMethod('setVisible', {'visible': visible});
  }

  @override
  Future<ResultCode> snapshot(String outputDir) {
    return _invokeCodeMethod('snapshot', {'outputDir': outputDir});
  }

  @override
  Future<ResultCode> startAnnotation(RtcSurfaceViewModel viewModel) {
    return viewModel
        .invokeCodeMethod('startAnnotation', {'annotationId': annotationId});
  }

  @override
  Future<ResultCode> stopAnnotation() {
    return _invokeCodeMethod('stopAnnotation');
  }

  @override
  Future<ResultCode> undo() {
    return _invokeCodeMethod('undo');
  }
}

/// The annotation interface
mixin RtcAnnotationInterface {
  /// Set annotation role type.
  ///
  /// **Parameter** type  The annotation role type.
  ///
  /// 设置标注角色类型
  ///
  /// **Parameter** type 标注角色
  Future<ResultCode> setRoleType(WBRoleType type);

  /// Start annotation  and set render window
  ///
  /// **Parameter** [viewModel] Platform specified window object
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// **Note**
  /// Please make sure that annotation service is available before start annotation
  ///
  /// 开启标注并且设置显示窗口
  ///
  /// **Parameter** [viewModel] 平台相关的窗口对象。
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  ///
  /// **Note**
  /// 开启标注前需要保证白板服务是正常的。
  Future<ResultCode> startAnnotation(RtcSurfaceViewModel viewModel);

  /// Stop the annotation.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 停止标注
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> stopAnnotation();

  /// Set annotation view visible/invisible.
  ///
  /// **Parameter** [visible] visible or not
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// **Note**
  /// annotation view is visible default
  ///
  /// 设置标注视图是否可见
  ///
  /// **Parameter** [visible] 是否可见
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  ///
  /// **Note**
  /// 标注视图默认是可见的
  Future<ResultCode> setVisible(bool visible);

  /// Set tool type
  ///
  /// **Parameter** [type] tool type
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 设置工具类型
  ///
  /// **Parameter** [type] 工具类型
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> setToolType(WBToolType type);

  /// Set line width
  ///
  /// **Parameter** [size] line width. Valid value ranges between 1 and 20
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 设置线宽
  ///
  /// **Parameter** [size] 线宽。 有效值范围1到20
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> setLineWidth(int size);

  /// Set color
  ///
  /// **Parameter** [color] Color
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 设置颜色
  ///
  /// **Parameter** [color] 颜色
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> setColor(WBColor color);

  /// Set font style
  ///
  /// **Parameter** [style] font style
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 设置字体样式
  ///
  /// **Parameter** [style] 字体样式
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> setFontStyle(WBFontStyle style);

  /// Set font size
  ///
  /// **Parameter** [size] font size
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 设置字体大小
  ///
  /// **Parameter** [size] 字体大小
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> setFontSize(int size);

  /// Undo
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 撤消上一次操作
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> undo();

  /// Redo
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 重做标注的上一次被撤销操作
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> redo();

  /// Clear annotation content by specific user ID
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - [ResultCode.NoPrivilege] need ADMIN role to call this API
  /// - Others: Fail
  ///
  /// **Note**
  /// ADMIN role is required if the userId is not local user
  ///
  /// 清除指定用户标注内容
  ///
  /// **Parameter** [userId] 用户ID
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - [ResultCode.NoPrivilege] 没有权限
  /// - Others: 失败
  ///
  /// **Note**
  /// 只有 ADMIN 角色才可以清除非本地用户的内容
  Future<ResultCode> clearUserContents(String userId);

  /// Clear annotation content
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - [ResultCode.NoPrivilege] need ADMIN role to call this API
  /// - Others: Fail
  ///
  /// **Note**
  /// this API need ADMIN role
  ///
  /// 清除标注内容，需要 ADMIN 角色才可调用成功
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - [ResultCode.NoPrivilege] 没有权限
  /// - Others: 失败
  ///
  /// **Note**
  /// 此接口只有 ADMIN 角色才可调用
  Future<ResultCode> clearContents();

  /// Save annotation contents to image.
  ///
  /// **Parameter** [outputDir] output directory
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// **Note**
  /// snapshot result and image filename is returned in callback [AnnotationEventHandler.onSnapshotComplete]
  ///
  /// 保存标注内容到图像。
  ///
  /// **Parameter** [outputDir] 输出路径
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  ///
  /// **Note**
  /// 快照结果和图像文件名通过回调函数[AnnotationEventHandler.onSnapshotComplete]返回
  Future<ResultCode> snapshot(String outputDir);
}

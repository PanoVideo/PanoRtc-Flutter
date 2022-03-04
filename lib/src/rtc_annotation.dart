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
  Future<ResultCode> setRoleType(WBRoleType type) {
    return _invokeCodeMethod(
        'setRoleType', {'type': WBRoleTypeConverter(type).value()});
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
  Future<ResultCode> setVisible(bool visible) {
    return _invokeCodeMethod('setVisible', {'visible': visible});
  }

  @override
  Future<ResultCode> setToolType(WBToolType type) {
    return _invokeCodeMethod(
        'setToolType', {'type': WBToolTypeConverter(type).value()});
  }

  @override
  Future<ResultCode> setLineWidth(int size) {
    return _invokeCodeMethod('setLineWidth', {'size': size});
  }

  @override
  Future<ResultCode> setColor(WBColor color) {
    return _invokeCodeMethod('setColor', {'color': color.toJson()});
  }

  @override
  Future<ResultCode> setFillType(WBFillType type) {
    return _invokeCodeMethod(
        'setFillType', {'type': WBFillTypeConverter(type).value()});
  }

  @override
  Future<ResultCode> setFillColor(WBColor color) {
    return _invokeCodeMethod('setFillColor', {'color': color.toJson()});
  }

  @override
  Future<ResultCode> setFontStyle(WBFontStyle style) {
    return _invokeCodeMethod(
        'setFontStyle', {'style': WBFontStyleConverter(style).value()});
  }

  @override
  Future<ResultCode> setFontSize(int size) {
    return _invokeCodeMethod('setFontSize', {'size': size});
  }

  @override
  Future<ResultCode> undo() {
    return _invokeCodeMethod('undo');
  }

  @override
  Future<ResultCode> redo() {
    return _invokeCodeMethod('redo');
  }

  @override
  Future<ResultCode> clearUserContents(String userId) {
    return _invokeCodeMethod('clearUserContents', {'userId': userId});
  }

  @override
  Future<ResultCode> clearContents() {
    return _invokeCodeMethod('clearContents');
  }

  @override
  Future<ResultCode> snapshot(String outputDir) {
    return _invokeCodeMethod('snapshot', {'outputDir': outputDir});
  }

  @override
  Future<WBToolType> getToolType() {
    return _invokeMethod('getToolType')
        .then((value) => WBToolTypeConverter.fromValue(value).e);
  }

  @override
  Future<ResultCode> setAspectSize(int w, int h) {
    return _invokeCodeMethod('setAspectSize', {'w': w, 'h': h});
  }

  @override
  Future<ResultCode> setScalingMode(VideoScalingMode mode) {
    return _invokeCodeMethod(
        'setScalingMode', {'mode': VideoScalingModeConverter(mode).value()});
  }

  @override
  Future<ResultCode> setOption(option, AnnoOptionType type) {
    var params = <String, dynamic>{};
    params['type'] = AnnoOptionTypeConverter(type).value();
    var isValid = true;
    switch (type) {
      case AnnoOptionType.EnableLocalRender:
      case AnnoOptionType.EnableShowDraws:
      case AnnoOptionType.EnableUIResponse:
      case AnnoOptionType.EnableCursorposSync:
      case AnnoOptionType.EnableShowRemoteCursor:
        if (option is bool) {
          params['option'] = option;
        } else {
          isValid = false;
        }
        break;
      default:
        isValid = false;
    }

    if (!isValid) return Future.value(ResultCode.InvalidArgs);

    return _invokeCodeMethod('setOption', params);
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

  /// Set fill type
  ///
  /// **Parameter** [type] Fill type
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 设置填充类型
  /// **Parameter** [type] 填充类型
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> setFillType(WBFillType type);

  /// Set fill color
  ///
  /// **Parameter** [color]  Color.  Valid value range: [0, 1].
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// **Note**
  /// The color will be onset only the filltype is WbFileType.Color
  ///
  /// 设置填充颜色
  ///
  /// **Parameter** [color] 颜色。有效值范围：[0, 1]。
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  ///
  /// **Note**
  /// 填充类型为WbFileType.Color时， 此设置方能起效。
  Future<ResultCode> setFillColor(WBColor color);

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

  /// get tool type
  ///
  /// **Returns**
  /// - tool type
  ///
  /// 获取工具类型
  ///
  /// **Returns**
  /// - 工具类型
  Future<WBToolType> getToolType();

  /// set annotation area aspect size
  ///
  /// **Parameter** [w] width
  ///
  /// **Parameter** [h] height
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 设置标注区域大小
  ///
  /// **Parameter** [w] 宽
  ///
  /// **Parameter** [h] 高
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> setAspectSize(int w, int h);

  /// set annotation area scaling mode
  ///
  /// **Parameter** [mode] scaling mode
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 设置标注区域缩放模式
  ///
  /// **Parameter** [mode] 缩放模式
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> setScalingMode(VideoScalingMode mode);

  /// Set annotation option and paramters
  ///
  /// **Parameter** [option] paramter defined with option
  ///
  /// **Parameter** [type] option type
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 设置标注参数
  ///
  /// **Parameter** [option] 参数, 参数的定义需遵循不同的option所定义的参数结构
  ///
  /// **Parameter** [type] 参数类别
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode> setOption(dynamic option, AnnoOptionType type);
}

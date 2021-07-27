import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pano_rtc/pano_rtc.dart';
import 'package:pano_rtc/src/enum_converter.dart';

import 'rtc_enums.dart';
import 'rtc_objects.dart';
import 'rtc_view.dart';

/// The RtcWhiteboard class.
class RtcWhiteboard with RtcWhiteboardInterface {
  static const MethodChannel _methodChannel =
      MethodChannel('pano_rtc/api_whiteboard');
  static const EventChannel _eventChannel =
      EventChannel('pano_rtc/events_whiteboard');

  static StreamSubscription? _subscription;

  /// The ID of RtcWhiteboard
  final String whiteboardId;

  WhiteboardEventHandler? _handler;

  /// @nodoc
  RtcWhiteboard(this.whiteboardId);

  Future<T?> _invokeMethod<T>(String method, [Map<String, dynamic>? arguments]) {
    var args = arguments == null
        ? {'whiteboardId': whiteboardId}
        : {'whiteboardId': whiteboardId, ...arguments};
    if (T == ResultCode) {
      return _methodChannel.invokeMethod(method, args).then((value) {
        return ResultCodeConverter.fromValue(value).e as T;
      });
    } else {
      return _methodChannel.invokeMethod(method, args);
    }
  }

  /// Sets the whiteboard event handler.
  ///
  /// After setting the whiteboard event handler, you can listen for whiteboard events and receive the statistics of the corresponding [RtcWhiteboard] instance.
  ///
  /// **Parameter** [handler] The event handler.
  void setEventHandler(WhiteboardEventHandler handler) {
    _handler = handler;
    _subscription ??= _eventChannel.receiveBroadcastStream().listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final whiteboardId = eventMap['whiteboardId'];
      final methodName = eventMap['methodName'] as String?;
      final data = List<dynamic>.from(eventMap['data']);
      RtcEngineKit.whiteboards[whiteboardId]?._handler
          ?.process(methodName, data);
    });
  }

  @override
  Future<ResultCode?> open(RtcWhiteboardSurfaceViewModel viewModel) {
    return viewModel.invokeMethod('open', {'whiteboardId': whiteboardId});
  }

  @override
  Future<ResultCode?> close() {
    return _invokeMethod('close');
  }

  @override
  Future<ResultCode?> leave() {
    return _invokeMethod('leave');
  }

  @override
  Future<ResultCode?> stop() {
    return _invokeMethod('stop');
  }

  @override
  Future<String?> getCurrentWhiteboardId() {
    return _invokeMethod('getCurrentWhiteboardId');
  }

  @override
  Future<ResultCode?> setRoleType(WBRoleType type) {
    return _invokeMethod(
        'setRoleType', {'type': WBRoleTypeConverter(type).value()});
  }

  @override
  Future<ResultCode?> setToolType(WBToolType type) {
    return _invokeMethod(
        'setToolType', {'type': WBToolTypeConverter(type).value()});
  }

  @override
  Future<WBToolType> getToolType() {
    return _invokeMethod('getToolType')
        .then((value) => WBToolTypeConverter.fromValue(value).e!);
  }

  @override
  Future<ResultCode?> setLineWidth(int width) {
    return _invokeMethod('setLineWidth', {'width': width});
  }

  @override
  Future<ResultCode?> setFillType(WBFillType type) {
    return _invokeMethod(
        'setFillType', {'type': WBFillTypeConverter(type).value()});
  }

  @override
  Future<ResultCode?> setFillColor(WBColor color) {
    return _invokeMethod('setFillColor', {'color': color.toJson()});
  }

  @override
  Future<ResultCode?> setForegroundColor(WBColor color) {
    return _invokeMethod('setForegroundColor', {'color': color.toJson()});
  }

  @override
  Future<ResultCode?> setBackgroundColor(WBColor color) {
    return _invokeMethod('setBackgroundColor', {'color': color.toJson()});
  }

  @override
  Future<ResultCode?> setFontStyle(WBFontStyle style) {
    return _invokeMethod(
        'setFontStyle', {'style': WBFontStyleConverter(style).value()});
  }

  @override
  Future<ResultCode?> setFontSize(int size) {
    return _invokeMethod('setFontSize', {'size': size});
  }

  @override
  Future<ResultCode?> addStamp(WBStamp stamp) {
    return _invokeMethod('addStamp', {'stamp': stamp.toJson()});
  }

  @override
  Future<ResultCode?> setStamp(String stampId) {
    return _invokeMethod('setStamp', {'stampId': stampId});
  }

  @override
  Future<ResultCode?> setBackgroundImageScalingMode(WBImageScalingMode mode) {
    return _invokeMethod('setBackgroundImageScalingMode',
        {'mode': WBImageScalingModeConverter(mode).value()});
  }

  @override
  Future<ResultCode?> setBackgroundImage(String imageUrl) {
    return _invokeMethod('setBackgroundImage', {'imageUrl': imageUrl});
  }

  @override
  Future<ResultCode?> setBackgroundImageWithPage(String imageUrl, int pageNo) {
    return _invokeMethod(
        'setBackgroundImageWithPage', {'imageUrl': imageUrl, 'pageNo': pageNo});
  }

  @override
  Future<int?> getCurrentPageNumber() {
    return _invokeMethod('getCurrentPageNumber');
  }

  @override
  Future<int?> getTotalNumberOfPages() {
    return _invokeMethod('getTotalNumberOfPages');
  }

  @override
  Future<ResultCode?> addPage(bool autoSwitch) {
    return _invokeMethod('addPage', {'autoSwitch': autoSwitch});
  }

  @override
  Future<ResultCode?> insertPage(int pageNo, bool autoSwitch) {
    return _invokeMethod(
        'insertPage', {'pageNo': pageNo, 'autoSwitch': autoSwitch});
  }

  @override
  Future<ResultCode?> removePage(int pageNo, {bool switchNext = false}) {
    return _invokeMethod(
        'removePage', {'pageNo': pageNo, 'switchNext': switchNext});
  }

  @override
  Future<ResultCode?> gotoPage(int pageNo) {
    return _invokeMethod('gotoPage', {'pageNo': pageNo});
  }

  @override
  Future<ResultCode?> nextPage() {
    return _invokeMethod('nextPage');
  }

  @override
  Future<ResultCode?> prevPage() {
    return _invokeMethod('prevPage');
  }

  @override
  Future<ResultCode?> nextStep() {
    return _invokeMethod('nextStep');
  }

  @override
  Future<ResultCode?> prevStep() {
    return _invokeMethod('prevStep');
  }

  @override
  Future<ResultCode?> addImageFile(String imageUrl) {
    return _invokeMethod('addImageFile', {'imageUrl': imageUrl});
  }

  @override
  Future<ResultCode?> addAudioFile(String mediaUrl) {
    return _invokeMethod('addAudioFile', {'mediaUrl': mediaUrl});
  }

  @override
  Future<ResultCode?> addVideoFile(String mediaUrl) {
    return _invokeMethod('addVideoFile', {'mediaUrl': mediaUrl});
  }

  @override
  Future<String?> addBackgroundImages(List<String> urls) {
    return _invokeMethod('addBackgroundImages', {'urls': urls});
  }

  @override
  Future<String?> addH5File(String url, {String? downloadUrl}) {
    return _invokeMethod(
        'addH5File',
        downloadUrl == null
            ? {'url': url}
            : {'url': url, 'downloadUrl': downloadUrl});
  }

  @override
  Future<String?> addDoc(WBDocContents contents) {
    return _invokeMethod('addDoc', {'contents': contents.toJson()});
  }

  @override
  Future<String?> createDocWithImages(List<String> urls) {
    return _invokeMethod('createDocWithImages', {'urls': urls});
  }

  @override
  Future<String?> createDocWithFilePath(String filePath,
      {WBConvertConfig? config}) {
    return _invokeMethod(
        'createDocWithFilePath',
        config == null
            ? {'filePath': filePath}
            : {'filePath': filePath, 'config': config.toJson()});
  }

  @override
  Future<ResultCode?> deleteDoc(String fileId) {
    return _invokeMethod('deleteDoc', {'fileId': fileId});
  }

  @override
  Future<ResultCode?> switchDoc(String fileId) {
    return _invokeMethod('switchDoc', {'fileId': fileId});
  }

  @override
  Future<ResultCode?> saveDocToImages(String fileId, String outputDir) {
    return _invokeMethod(
        'saveDocToImages', {'fileId': fileId, 'outputDir': outputDir});
  }

  @override
  Future<List<String>?> enumerateFiles() {
    return _invokeMethod('enumerateFiles');
  }

  @override
  Future<String?> getCurrentFileId() {
    return _invokeMethod('getCurrentFileId');
  }

  @override
  Future<WBDocInfo?> getFileInfo(String fileId) {
    return _invokeMethod('getFileInfo', {'fileId': fileId})
        .then((value) => value == null ? null : WBDocInfo.fromJson(value));
  }

  @override
  Future<ResultCode?> clearContents(bool curPage, WBClearType type) {
    return _invokeMethod('clearContents',
        {'curPage': curPage, 'type': WBClearTypeConverter(type).value()});
  }

  @override
  Future<ResultCode?> clearUserContents(
      String userId, bool curPage, WBClearType type) {
    return _invokeMethod('clearUserContents', {
      'userId': userId,
      'curPage': curPage,
      'type': WBClearTypeConverter(type).value()
    });
  }

  @override
  Future<ResultCode?> undo() {
    return _invokeMethod('undo');
  }

  @override
  Future<ResultCode?> redo() {
    return _invokeMethod('redo');
  }

  @override
  Future<double?> getCurrentScaleFactor() {
    return _invokeMethod('getCurrentScaleFactor');
  }

  @override
  Future<ResultCode?> setCurrentScaleFactor(double scale) {
    return _invokeMethod('setCurrentScaleFactor', {'scale': scale});
  }

  @override
  Future<ResultCode?> snapshot(WBSnapshotMode mode, String outputDir) {
    return _invokeMethod('snapshot', {
      'mode': WBSnapshotModeConverter(mode).value(),
      'outputDir': outputDir
    });
  }

  @override
  Future<ResultCode?> startFollowVision() {
    return _invokeMethod('startFollowVision');
  }

  @override
  Future<ResultCode?> startShareVision() {
    return _invokeMethod('startShareVision');
  }

  @override
  Future<ResultCode?> stopFollowVision() {
    return _invokeMethod('stopFollowVision');
  }

  @override
  Future<ResultCode?> stopShareVision() {
    return _invokeMethod('stopShareVision');
  }

  @override
  Future<ResultCode?> syncVision() {
    return _invokeMethod('syncVision');
  }

  @override
  Future<ResultCode?> sendMessage(Uint8List message, String userId) {
    return _invokeMethod('sendMessage', {'message': message, 'userId': userId});
  }

  @override
  Future<ResultCode?> broadcastMessage(Uint8List message) {
    return _invokeMethod('broadcastMessage', {'message': message});
  }

  @override
  Future<ResultCode?> setOption(option, WBOptionType type) {
    var params = <String, dynamic>{};
    params['type'] = WBOptionTypeConverter(type).value();
    var isValid = true;
    switch (type) {
      case WBOptionType.FileCachePath:
        if (option is String) {
          params['option'] = option;
        } else {
          isValid = false;
        }
        break;
      case WBOptionType.EnableUIResponse:
        if (option is bool) {
          params['option'] = option;
        } else {
          isValid = false;
        }
        break;
      case WBOptionType.ShowDraws:
        if (option is bool) {
          params['option'] = option;
        } else {
          isValid = false;
        }
        break;
      case WBOptionType.ScaleMove:
        if (option is bool) {
          params['option'] = option;
        } else {
          isValid = false;
        }
        break;
      case WBOptionType.AutoSelected:
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

    return _invokeMethod('setOption', params);
  }
}

/// The [RtcWhiteboard] interface class provides all whiteboard methods invoked by the application.
///
/// **Note**
/// The [RtcWhiteboard] object can be obtained through the [RtcEngineKit] instance.
///
/// [RtcWhiteboard] 接口类对应用程序提供了所有的白板相关方法。
///
/// **Note**
/// [RtcWhiteboard] 对象可以通过 [RtcEngineKit] 实例获取。
mixin RtcWhiteboardInterface {
  /// Open the whiteboard.
  ///
  /// **Parameter** [view] The whiteboard display view provided by customer.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 打开白板。
  ///
  /// **Parameter** [view] 客户提供的白板显示视图。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> open(RtcWhiteboardSurfaceViewModel viewModel);

  /// Close the whiteboard.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 关闭白板。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> close();

  /// Leave the whiteboard.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 离开白板
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> leave();

  /// Stop the whiteboard.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// **Note**
  /// default whiteboard can't be stopped
  ///
  /// 停止白板
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  ///
  /// **Note**
  /// 默认白板不能被停止
  Future<ResultCode?> stop();

  /// get current Whiteboard Id
  ///
  /// **Returns**
  /// - Whiteboard Id
  ///
  /// 获取当前白板Id
  ///
  /// **Returns**
  /// - 白板Id
  Future<String?> getCurrentWhiteboardId();

  /// Set whiteboard role type.
  ///
  /// **Parameter** [type] The whiteboard role type, [WBRoleType] enum type.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置白板角色类型。
  ///
  /// **Parameter** [type] 白板角色，[WBRoleType] 枚举类型。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setRoleType(WBRoleType type);

  /// Set the whiteboard tool.
  ///
  /// **Parameter** [type] [WBToolType] enum type.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置白板工具。
  ///
  /// **Parameter** [view] [WBToolType] 枚举类型。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setToolType(WBToolType type);

  /// Get tool type
  ///
  /// **Returns**
  /// - tool type
  ///
  /// 获取工具类型
  ///
  /// **Returns**
  /// - 工具类型
  Future<WBToolType> getToolType();

  /// Set the whiteboard line width.
  ///
  /// **Parameter** [width] Valid value ranges between 1 and 20.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置白板线条宽度。
  ///
  /// **Parameter** [width] 有效值范围1到20。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setLineWidth(int width);

  /// Set the whiteboard fill type.
  ///
  /// **Parameter** [type] [WBFillType] enum type.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置白板填充类型。
  ///
  /// **Parameter** [type] [WBFillType] 枚举类型。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setFillType(WBFillType type);

  /// Set the whiteboard fill color.
  ///
  /// **Parameter** [color] [WBColor] object. Valid value ranges between 0 and 1.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Only works when the fill type is set to [WBFillType.Color].
  ///
  /// 设置白板填充颜色。
  ///
  /// **Parameter** [color] [WBColor] 对象。有效值范围0到1。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 仅当设置填充类型为[WBFillType.Color]起效。
  Future<ResultCode?> setFillColor(WBColor color);

  /// Set the whiteboard foreground color.
  ///
  /// **Parameter** [color] [WBColor] object. Valid value ranges between 0 and 1.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置白板前景色。
  ///
  /// **Parameter** [color] [WBColor] 对象。有效值范围0到1。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setForegroundColor(WBColor color);

  /// Set the whiteboard background color.
  ///
  /// **Parameter** [color] [WBColor] object. Valid value ranges between 0 and 1.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置白板背景色。
  ///
  /// **Parameter** [color] [WBColor] 对象。有效值范围0到1。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setBackgroundColor(WBColor color);

  /// Set the whiteboard font style.
  ///
  /// **Parameter** [style] [WBFontStyle] enum type.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置白板字体样式。
  ///
  /// **Parameter** [color] [WBFontStyle] 枚举类型。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setFontStyle(WBFontStyle style);

  /// Set the font size.
  ///
  /// **Parameter** [size] Valid value ranges between 10 and 96.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置字体大小。
  ///
  /// **Parameter** [size] 有效值范围10到96。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setFontSize(int size);

  /// Add Stamp Resource
  ///
  /// **Parameter** [stamp] stamp resource
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 添加图章资源
  ///
  /// **Parameter** [stamp] 图章资源
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> addStamp(WBStamp stamp);

  /// Set Stamp Resource
  ///
  /// **Parameter** stampId stamp resource ID
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置图章资源
  ///
  /// **Parameter** stampId 图章资源ID
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setStamp(String stampId);

  /// Set background image scaling mode.
  ///
  /// **Parameter** [mode] background image scaling mode.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 设置白板背景图缩放模式。
  ///
  /// **Parameter** [mode] 背景图缩放模式。
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode?> setBackgroundImageScalingMode(WBImageScalingMode mode);

  /// Set the background image of current whiteboard page.
  ///
  /// **Parameter** [imageUrl] Image URL, a local iamge path or a network image link.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置白板当前页背景图片。
  ///
  /// **Parameter** [imageUrl] 图片 URL，可为本地路径或者网络链接。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setBackgroundImage(String imageUrl);

  /// Set background image of specified whiteboard page.
  ///
  /// **Parameter** [imageUrl] Image URL, a local image path or a network image link.
  ///
  /// **Parameter** [pageNo] The page number.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置白板指定页背景图片
  ///
  /// **Parameter** [imageUrl] 背景图 URL，可为本地路径或者网络链接。
  ///
  /// **Parameter** [pageNo] 白板页码。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setBackgroundImageWithPage(String imageUrl, int pageNo);

  /// Get current page number.
  ///
  /// **Returns**
  /// - `-1`: No page
  /// - Others: Page number
  ///
  /// 获取当前白板页码。
  ///
  /// **Returns**
  /// - `-1`：白板未打开
  /// - Others：白板页码
  Future<int?> getCurrentPageNumber();

  /// Get total number of pages.
  ///
  /// **Returns** The number of pages
  ///
  /// 获取总白板页码数。
  ///
  /// **Returns** 页码数
  Future<int?> getTotalNumberOfPages();

  /// Add new page to the end.
  ///
  /// **Parameter** [autoSwitch] Auto switch to the new page.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 添加一个新页面到最后。
  ///
  /// **Parameter** [autoSwitch] 自动切换到新添加的页面。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> addPage(bool autoSwitch);

  /// Add new page after the page number.
  ///
  /// **Parameter** [pageNo] The page number.
  ///
  /// **Parameter** [autoSwitch] Auto switch to the new page.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 添加一个新页面到指定页码之后。
  ///
  /// **Parameter** [pageNo] 指定页码。
  ///
  /// **Parameter** [autoSwitch] 自动切换到新添加的页面。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> insertPage(int pageNo, bool autoSwitch);

  /// goto the page pageNo
  ///
  /// **Parameter** [pageNo] the page
  ///
  /// **Parameter** [switchNext] switch to next page of removed page.
  ///
  /// **Note**
  /// The default behavior is switch to previous page of removed page after remove page.
  /// Set switchNext `true` to make it switch to next page of removed page.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 删除页 pageNo
  ///
  /// **Parameter** [pageNo] 被删除的页码
  ///
  /// **Parameter** [switchNext] 切换到删除页的下一页.
  ///
  /// **Note**
  /// 删除页的默认行为是切换到删除页的前一页。设置switchNext为`true`改为切换到删除页的下一页。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> removePage(int pageNo, {bool switchNext = false});

  /// Goto the page with the page number.
  ///
  /// **Parameter** [pageNo] The page number.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 切换到指定页。
  ///
  /// **Parameter** [pageNo] 指定页码。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> gotoPage(int pageNo);

  /// Switch to next page.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 切换到下一页。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> nextPage();

  /// Switch to previous page.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 切换到前一页。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> prevPage();

  /// next step for H5 doc
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 执行H5文件下一步
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> nextStep();

  /// previous step for H5 doc
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 执行H5文件上一步
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> prevStep();

  /// Add image file to current whiteboard page
  ///
  /// **Parameter** [imageUrl]  image URL
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 添加图片到当前白板页
  ///
  /// **Parameter** [imageUrl]  图像 URL，可为本地路径或远程 URL
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> addImageFile(String imageUrl);

  /// add audio media file to current whiteboard page
  ///
  /// **Parameter** [mediaUrl]  media URL
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 添加音频媒体文件到当前白板页
  ///
  /// **Parameter** [mediaUrl]  媒体 URL，可为本地路径或远程 URL
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> addAudioFile(String mediaUrl);

  /// add video media file to current whiteboard page
  ///
  /// **Parameter** [mediaUrl]  media URL
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 添加视频媒体文件到当前白板页
  ///
  /// **Parameter** [mediaUrl]  媒体 URL，可为本地路径或远程 URL
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> addVideoFile(String mediaUrl);

  /// Add some background images to current whiteboard file
  ///
  /// **Parameter** [urls] Background image url array (remote url only)
  ///
  /// **Returns**
  /// - Current whiteboard file ID, if fail return empty string
  ///
  /// **Note**
  /// PanoWhiteboard has created doc with whiteboard file ID `default` when created
  ///
  /// 添加指定数量的背景图到当前白板文件
  ///
  /// **Parameter** [urls] 背景图url数组（仅支持远程URL）
  ///
  /// **Returns**
  /// - 当前白板文件ID，如果失败返回空串
  ///
  /// **Note**
  /// PanoWhiteboard 创建时会生成白板文件ID为`default`的白板文件
  Future<String?> addBackgroundImages(List<String> urls);

  /// Add H5 file URL to current whiteboard file as background
  ///
  /// **Parameter** [url] H5 URL (remote URL only)
  ///
  /// **Parameter** [downloadUrl] URL of download H5 files, should be packed as .zip file
  ///
  /// **Returns**
  ///    - Current whiteboard file ID, if fail return null
  ///
  /// **Note**
  /// PanoWhiteboard has created doc with whiteboard file ID "default" when created
  ///
  /// 添加H5文件URL到当前白板文件作为背景
  ///
  /// **Parameter** [url] 网络URL（仅支持远程URL）
  ///
  /// **Parameter** [downloadUrl] H5文件的下载URL, 所有文件需要打包为zip文件
  ///
  /// **Returns**
  /// - 当前白板文件ID，如果失败返回null
  ///
  /// **Note**
  /// PanoWhiteboard创建时会生成白板文件ID为"default"的白板文件
  Future<String?> addH5File(String url, {String? downloadUrl});

  /// Add a new whiteboard file
  ///
  /// **Parameter** [contents] Whiteboard file contents with converted result
  ///
  /// **Returns**
  /// - Current whiteboard file ID, if fail return null
  ///
  /// **Note**
  /// PanoWhiteboard has created doc with whiteboard file ID "default" when created
  ///
  /// 添加新的白板文件
  /// **Parameter** [contents] 根据转码结果指定的白板文件内容
  ///
  /// **Returns**
  /// - 当前白板文件ID，如果失败返回null
  ///
  /// **Note**
  /// PanoWhiteboard创建时会生成白板文件ID为"default"的白板文件
  Future<String?> addDoc(WBDocContents contents);

  /// Create new whiteboard file with some background images
  ///
  /// **Parameter** [urls] Background image url array (remote url only)
  ///
  /// **Returns**
  /// - Whiteboard file ID created, if fail return empty string
  ///
  /// **Note**
  /// PanoWhiteboard has created doc with whiteboard file ID `default` when created
  ///
  /// 导入指定数量的背景图并创建新的白板文件
  ///
  /// **Parameter** [urls] 背景图url数组（仅支持远程URL）
  ///
  /// **Returns**
  /// - 新创建的白板文件ID，如果失败返回空串
  ///
  /// **Note**
  /// PanoWhiteboard 创建时会生成白板文件ID为`default`的白板文件
  Future<String?> createDocWithImages(List<String> urls);

  /// Upload local file for transcode and create new whiteboard file
  ///
  /// **Parameter** [filePath] Local file path
  ///
  /// **Parameter** [config] File convert configuration
  ///
  /// **Returns**
  /// - Whiteborad file ID created, if fail return empty string
  ///
  /// **Note**
  /// PanoWhiteboard has created doc with whiteboard file ID `default` when created
  ///
  /// 上传本地需转码的文件并创建新的白板文件
  ///
  /// **Parameter** [filePath] 本地文件路径
  ///
  /// **Parameter** [config] 转码配置
  ///
  /// **Returns**
  /// - 新创建的白板文件ID，如果失败返回空串
  ///
  /// **Note**
  /// PanoWhiteboard 创建时会生成白板文件ID为`default`的白板文件
  Future<String?> createDocWithFilePath(String filePath,
      {WBConvertConfig? config});

  /// Delete whiteboard file
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// **Note**
  /// `default` whiteboard file could not be deleted
  ///
  /// 删除白板文件
  ///
  /// **Parameter** [fileId] 白板文件ID
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  ///
  /// **Note**
  /// `default` 白板文件不能被删除
  Future<ResultCode?> deleteDoc(String fileId);

  /// Switch whiteboard file
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 切换白板文件
  ///
  /// **Parameter** [fileId] 白板文件ID
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode?> switchDoc(String fileId);

  /// Save whiteboard file. Save each page to one image.
  ///
  /// Image name format is like whiteboard_[fileId]_[page number].png, eg. whiteboard_default_1.png
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// **Parameter** [outputDir] Output directory
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 保存白板文件。每个白板页存为一张图
  ///
  /// 图像名称格式为whiteboard_[fileId]_[page number].png, 例如：whiteboard_default_1.png
  ///
  /// **Parameter** [fileId] 白板文件ID
  ///
  /// **Parameter** [outputDir] 输出路径
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode?> saveDocToImages(String fileId, String outputDir);

  /// Enumerate whiteboard files
  ///
  /// **Returns** fileId array
  ///
  /// 枚举白板文件
  ///
  /// **Returns** fileId 数组
  Future<List<String>?> enumerateFiles();

  /// get current whiteboard file ID
  ///
  /// **Returns**
  /// - current whiteboard file ID, if fail return null
  ///
  /// 获取当前白板文件ID
  ///
  /// **Returns**
  /// - 当前白板文件ID, 失败则返回null
  Future<String?> getCurrentFileId();

  /// Get whiteboard file information with specific fileId
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// **Returns**
  /// - non-null: whiteboard file information
  /// - others: Failure
  ///
  /// 获取指定白板文件ID的白板文件信息
  ///
  /// **Parameter** [fileId] 白板文件ID
  ///
  /// **Returns**
  /// - 非空：白板文件信息
  /// - 空：失败
  Future<WBDocInfo?> getFileInfo(String fileId);

  /// clear whiteboard content
  ///
  /// **Parameter** [curPage] `true`: clear current page only; `false`: clear all pages
  ///
  /// **Parameter** [type] [WBClearType] enum type
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// **Note**
  /// The operation requires admin role.
  ///
  /// 清除白板内容
  ///
  /// **Parameter** [curPage] `true`: 只清除当前页内容；`false`: 清除所有页内容
  ///
  /// **Parameter** [type] [WBClearType] 枚举类型
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  ///
  /// **Note**
  /// 此操作需要管理员角色。
  Future<ResultCode?> clearContents(bool curPage, WBClearType type);

  /// clear whiteboard content by specific user ID
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [curPage] `true`: clear current page only; `false`: clear all pages
  ///
  /// **Parameter** [type] [WBClearType] enum type
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// **Note**
  /// If the user isn't current user, the operation requires admin role.
  ///
  /// 清除指定用户绘制的白板内容
  ///
  /// **Parameter** [userId] 用户ID
  ///
  /// **Parameter** [curPage] `true`: 只清除当前页内容；`false`: 清除所有页内容
  ///
  /// **Parameter** [type] [WBClearType] 枚举类型
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  ///
  /// **Note**
  /// 如果指定用户不是当前用户，此操作需要管理员角色。
  Future<ResultCode?> clearUserContents(
      String userId, bool curPage, WBClearType type);

  /// Undo the last operation of the whiteboard.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 撤销白板上一次操作。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> undo();

  /// Redo the last undone operation of the whiteboard.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 重做白板的上一次被撤销操作。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> redo();

  /// Get current whiteboard scale factor.
  ///
  /// **Returns** scale factor.
  ///
  /// 获取当前白板视图的缩放比例。
  ///
  /// **Returns** 缩放比例值。
  Future<double?> getCurrentScaleFactor();

  /// set current whiteboard scale factor
  ///
  /// **Parameter** [scale] scale factor. Valid value ranges between 0.1 and 5.0
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - Others: Fail
  ///
  /// 设置当前白板视图的缩放比例
  ///
  /// **Parameter** [scale] 缩放比例值。有效值范围0.1到5.0
  ///
  /// **Returns**
  /// - [ResultCode.OK]： 成功
  /// - Others: 失败
  Future<ResultCode?> setCurrentScaleFactor(double scale);

  /// Save whiteboard contents to image.
  ///
  /// **Parameter** [mode] snapshot mode
  ///
  /// **Parameter** [outputDir] Output directory.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// snapshot result and image filename is returned in delegate method [WhiteboardEventHandler.onSnapshotComplete]
  ///
  /// 保存白板内容到图像。
  ///
  /// **Parameter** [mode] 快照模式
  ///
  /// **Parameter** [outputDir] 输出路径。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 快照结果和图像文件名通过回调函数[WhiteboardEventHandler.onSnapshotComplete]返回
  Future<ResultCode?> snapshot(WBSnapshotMode mode, String outputDir);

  /// Start share vision
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 开始共享视角
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> startShareVision();

  /// Stop share vision
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 停止共享视角
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> stopShareVision();

  /// Start follow vision
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 开始跟随视角
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> startFollowVision();

  /// Stop follow vision
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 停止跟随视角
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> stopFollowVision();

  /// @Sync vision of current page
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 同步当前页视角
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> syncVision();

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
  /// 发送消息给某个指定用户。
  ///
  /// **Parameter** [message] 要发送的消息。
  ///
  /// **Parameter** [userId] 接收消息的用户。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> sendMessage(Uint8List message, String userId);

  /// Broadcast message to all users.
  ///
  /// **Parameter** [message] The message data.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 广播消息给所有用户。
  ///
  /// **Parameter** [message] 要广播的消息。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> broadcastMessage(Uint8List message);

  /// Set whiteboard option object.
  ///
  /// **Parameter** [option] The Option object.
  ///
  /// **Parameter** [type] [WBOptionType] enum type.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置白板选项对象。
  ///
  /// **Parameter** [option] 选项对象。
  ///
  /// **Parameter** [type] [WBOptionType] 枚举类型。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setOption(dynamic option, WBOptionType type);
}

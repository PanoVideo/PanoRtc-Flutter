import 'package:flutter/services.dart';

import '../pano_rtc.dart';
import 'enum_converter.dart';

/// The RtcVideoStreamManager class.
class RtcVideoStreamManager with RtcVideoStreamInterface {
  static const MethodChannel _methodChannel =
      MethodChannel('pano_rtc/api_video_streamMgr');
  static const EventChannel _eventChannel =
      EventChannel('pano_rtc/events_video_streamMgr');
  VideoStreamEventHandler? _handler;

  /// @nodoc
  RtcVideoStreamManager() {
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

  /// Sets the video stream manager event handler.
  ///
  /// After setting the video stream manager event handler, you can listen for video stream manager events and receive the statistics of the corresponding [RtcVideoStreamManager] instance.
  ///
  /// **Parameter** [handler] The event handler.
  void setEventHandler(VideoStreamEventHandler handler) {
    _handler = handler;
  }

  @override
  Future<int> createVideoStream(String deviceId) {
    return _invokeMethod('createVideoStream', {'deviceId': deviceId})
        .then((value) => value);
  }

  @override
  Future<ResultCode> destroyVideoStream(int streamId) {
    return _invokeCodeMethod('destroyVideoStream', {'streamId': streamId});
  }

  @override
  Future<String?> getCaptureDevice(int streamId) {
    return _invokeMethod('getCaptureDevice', {'streamId': streamId});
  }

  @override
  Future<ResultCode> muteVideo(int streamId) {
    return _invokeCodeMethod('muteVideo', {'streamId': streamId});
  }

  @override
  Future<ResultCode> setCaptureDevice(int streamId, String deviceId) {
    return _invokeCodeMethod(
        'setCaptureDevice', {'streamId': streamId, 'deviceId': deviceId});
  }

  @override
  Future<ResultCode> snapshotVideo(
      String userId, int streamId, String outputDir,
      {RtcSnapshotVideoOption? option}) {
    option ??= RtcSnapshotVideoOption();
    return _invokeCodeMethod('snapshotVideo', {
      'userId': userId,
      'streamId': streamId,
      'outputDir': outputDir,
      'option': option.toJson()
    });
  }

  @override
  Future<ResultCode> startVideo(int streamId, RtcSurfaceViewModel viewModel,
      {RtcVideoConfig? config}) {
    config ??= RtcVideoConfig();
    return viewModel.invokeCodeMethod('startVideoWithStreamId',
        {'streamId': streamId, 'config': config.toJson()});
  }

  @override
  Future<ResultCode> stopVideo(int streamId) {
    return _invokeCodeMethod('stopVideo', {'streamId': streamId});
  }

  @override
  Future<ResultCode> subscribeVideo(
      String userId, int streamId, RtcSurfaceViewModel viewModel,
      {RtcVideoConfig? config}) {
    config ??= RtcVideoConfig();
    return viewModel.invokeCodeMethod('subscribeVideoWithStreamId',
        {'userId': userId, 'streamId': streamId, 'config': config.toJson()});
  }

  @override
  Future<ResultCode> unmuteVideo(int streamId) {
    return _invokeCodeMethod('unmuteVideo', {'streamId': streamId});
  }

  @override
  Future<ResultCode> unsubscribeVideo(String userId, int streamId) {
    return _invokeCodeMethod(
        'unsubscribeVideo', {'userId': userId, 'streamId': streamId});
  }
}

/// The video stream interface
mixin RtcVideoStreamInterface {
  /// Create a new video stream.
  ///
  /// **Parameter** [deviceId] The device to be set to new stream.
  ///
  /// **Returns**
  /// - >= 0: video stream ID
  /// - others: Failure
  ///
  /// **Note**
  /// The default video stream is always available after channel joined
  ///
  /// 创建一个新的视频流。
  ///
  /// **Parameter** [deviceId] 设备 ID, 此设备会设置给新视频流。
  ///
  /// **Returns**
  /// - >= 0: 视频流 ID
  /// - 其他: 失败
  ///
  /// **Note**
  /// 默认视频流无需创建，在频道加入成功后即有效。
  Future<int?> createVideoStream(String deviceId);

  /// Destroy a video stream.
  ///
  /// **Parameter** [streamId] The stream ID to be destroyed.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// The default video stream could not be destroyed
  ///
  /// 销毁一个视频流。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 默认视频流不可销毁。
  Future<ResultCode> destroyVideoStream(int streamId);

  /// Set capture device for video stream.
  ///
  /// **Parameter** [streamId] Stream ID.
  ///
  /// **Parameter** [deviceId] Device ID.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置或更新视频流的采集设备。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  ///
  /// **Parameter** [deviceId] 采集设备 ID。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode> setCaptureDevice(int streamId, String deviceId);

  /// Get capture device of the stream.
  ///
  /// **Parameter** [streamId] Stream ID.
  ///
  /// **Returns**
  /// - empty: Failure, the streamId is not found
  /// - others: The capture device ID
  ///
  /// 获取视频流的采集设备。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  ///
  /// **Returns**
  /// - 空字符串: 失败，streamId未找到或其他错误
  /// - 非空字符串: 成功，返回采集设备ID
  Future<String?> getCaptureDevice(int streamId);

  /// start video stream with render window
  ///
  /// **Parameter** [streamId] Stream ID
  ///
  /// **Parameter** [viewModel] Platform specific view model.
  ///
  /// **Parameter** [config] Video configure
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Must be called from main thread on platform macOS iOS and Android.
  ///
  /// 开启视频流，并且设置渲染窗口
  ///
  /// **Parameter** [streamId] 视频流 ID
  ///
  /// **Parameter** [viewModel] 平台相关的窗口对象
  ///
  /// **Parameter** [config] 视频配置参数
  ///
  /// **Returns**
  /// - [ResultCode.OK] 调用成功
  /// - others： 调用失败
  ///
  /// **Note**
  /// 在 macOS iOS and Android 平台下必须从主线程调用。
  Future<ResultCode> startVideo(int streamId, RtcSurfaceViewModel viewModel,
      {RtcVideoConfig? config});

  /// Stop video stream
  ///
  /// **Parameter** [streamId] Stream ID
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 关闭视频流
  ///
  /// **Parameter** [streamId] 视频流 ID
  ///
  /// **Returns**
  /// - [ResultCode.OK] 调用成功
  /// - others： 调用失败
  Future<ResultCode> stopVideo(int streamId);

  /// Pause video stream.
  ///
  /// **Parameter** [streamId] Stream ID
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Please start the video stream before pausing, otherwise it will not work.
  ///
  /// 暂停视频流。
  ///
  /// **Parameter** [streamId] 视频流 ID
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 暂停视频流前请先开启视频流，否则操作将无效。
  Future<ResultCode> muteVideo(int streamId);

  /// Resume video stream.
  ///
  /// **Parameter** [streamId] Stream ID
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Please start the video stream before resuming, otherwise it will not work.
  ///
  /// 恢复视频。
  ///
  /// **Parameter** [streamId] 视频流 ID
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 恢复视频流前请先开启视频流，否则操作将无效。
  Future<ResultCode> unmuteVideo(int streamId);

  /// Subscribe to a user's video stream with render window.
  ///
  /// **Parameter** [userId] The user ID defined by customer.
  ///
  /// **Parameter** [streamId] Stream ID.
  ///
  /// **Parameter** [viewModel] Platform specified window object.
  ///
  /// **Parameter** [config] Video configure.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Before subscribing to a user’s video stream, please make sure the user has started the video stream.
  ///      Must be called from main thread on platform macOS iOS and Android.
  ///
  /// 订阅用户的视频流， 并设置渲染窗口。
  ///
  /// **Parameter** [userId] 客户定义的用户标识。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  ///
  /// **Parameter** [viewModel] 平台相关的窗口对象。
  ///
  /// **Parameter** [config] 视频参数。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 订阅用户的视频流前，请确保用户已开启视频流。
  ///      在 macOS iOS and Android 平台下必须从主线程调用。
  Future<ResultCode> subscribeVideo(
      String userId, int streamId, RtcSurfaceViewModel viewModel,
      {RtcVideoConfig? config});

  /// Unsubscribe to a user's video stream.
  ///
  /// **Parameter** [userId] The user ID defined by customer.
  ///
  /// **Parameter** [streamId] Stream ID.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// When a user stops the video or leaves the channel, the user's video will be automatically unsubscribed.
  ///
  /// 取消订阅用户的视频。
  ///
  /// **Parameter** [userId] 客户定义的用户标识。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 当用户停止视频流或者离开频道的时候，用户的视频流将会被自动取消订阅。
  Future<ResultCode> unsubscribeVideo(String userId, int streamId);

  /// Capture specific user's video stream content
  ///
  /// **Parameter** [userId] the id of target user
  ///
  /// **Parameter** [streamId] the video stream ID
  ///
  /// **Parameter** [outputDir] output directory
  ///
  /// **Parameter** [option] snapshot option
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 捕获指定用户的视频流画面
  ///
  /// **Parameter** [userId] 目标用户的 ID
  ///
  /// **Parameter** [streamId] 视频流 ID
  ///
  /// **Parameter** [outputDir] 输出路径
  ///
  /// **Parameter** [option] 快照选项
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode> snapshotVideo(
      String userId, int streamId, String outputDir,
      {RtcSnapshotVideoOption? option});
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pano_rtc/src/rtc_messageService.dart';
import 'package:pano_rtc/src/rtc_whiteboard.dart';

import 'enum_converter.dart';
import 'rtc_annotationManager.dart';
import 'rtc_enums.dart';
import 'rtc_events.dart';
import 'rtc_networkManager.dart';
import 'rtc_objects.dart';
import 'rtc_videoStreamManager.dart';
import 'rtc_view.dart';

/// RtcEngine is the main class of the PanoRtc SDK.
class RtcEngineKit with RtcEngineKitInterface {
  static const MethodChannel _methodChannel =
      MethodChannel('pano_rtc/api_engine');
  static const EventChannel _eventChannel =
      EventChannel('pano_rtc/events_engine');

  static RtcEngineKit? _engine;

  /// @nodoc
  static final Map<String, RtcWhiteboard> whiteboards = {};

  RtcEngineEventHandler? _handler;
  RtcVideoStreamManager? _videoStreamManager;
  RtcAnnotationManager? _annotationManager;
  RtcNetworkManager? _networkManager;
  RtcMessageService? _messageService;

  RtcEngineKit._() {
    _eventChannel.receiveBroadcastStream().listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final methodName = eventMap['methodName'] as String?;
      final data = List<dynamic>.from(eventMap['data']);
      _handler?.process(methodName, data);
    });
  }

  Future<T?> _invokeMethod<T>(String method, [Map<String, dynamic>? arguments]) {
    if (T == ResultCode) {
      return _methodChannel.invokeMethod(method, arguments).then((value) {
        return ResultCodeConverter.fromValue(value).e as T;
      });
    } else {
      return _methodChannel.invokeMethod(method, arguments);
    }
  }

  /// Creating an [RtcEngineKit] object.
  ///
  /// **Parameter** [config] [RtcEngineConfig] object.
  ///
  /// **Returns**
  /// [RtcEngineKit] object.
  ///
  /// **Note**
  /// If the object creation fails, an null object is returned.
  ///
  /// 创建一个 [RtcEngineKit] 对象。
  ///
  /// **Parameter** [config] [RtcEngineConfig] 对象.
  ///
  /// **Returns**
  /// [RtcEngineKit] 对象
  ///
  /// **Note**
  /// 如果对象创建失败，将返回空对象。
  static Future<RtcEngineKit?> engine(RtcEngineConfig config) async {
    if (_engine != null) return _engine;
    await _methodChannel.invokeMethod('create', {'config': config.toJson()});
    _engine = RtcEngineKit._();
    await _engine!.setParameters(jsonEncode({
      'pano_sdk': {'sdk_type': 'flutter', 'dart': Platform.version}
    }));
    return _engine;
  }

  @override
  Future<void> destroy() {
    _engine = null;
    whiteboards.clear();

    _videoStreamManager = null;

    _annotationManager?.destroy();
    _annotationManager = null;

    _networkManager = null;
    _messageService = null;
    return _invokeMethod('destroy');
  }

  /// Sets the engine event handler.
  ///
  /// After setting the engine event handler, you can listen for engine events and receive the statistics of the corresponding [RtcEngineKit] instance.
  ///
  /// **Parameter** [handler] The event handler.
  void setEventHandler(RtcEngineEventHandler handler) {
    _handler = handler;
  }

  /// Retrieves the PANO SDK version.
  ///
  /// **Returns** The PANO SDK version, format as 1.0.1.
  ///
  /// 返回 PANO SDK 的版本信息
  ///
  /// **Returns**
  /// PANO SDK 版本字符串，比如 1.0.1。
  static Future<String?> getSdkVersion() {
    return _methodChannel.invokeMethod('getSdkVersion');
  }

  @override
  Future<ResultCode?> updateConfig(RtcEngineConfig config) {
    return _invokeMethod('updateConfig', {'config': config.toJson()});
  }

  @override
  Future<ResultCode?> joinChannel(String token, String channelId, String userId,
      {RtcChannelConfig? config}) {
    config ??= RtcChannelConfig();
    return _invokeMethod('joinChannel', {
      'token': token,
      'channelId': channelId,
      'userId': userId,
      'config': config.toJson()
    });
  }

  @override
  Future<void> leaveChannel() {
    return _invokeMethod('leaveChannel');
  }

  @override
  Future<ResultCode?> startAudio() {
    return _invokeMethod('startAudio');
  }

  @override
  Future<ResultCode?> stopAudio() {
    return _invokeMethod('stopAudio');
  }

  @override
  Future<ResultCode?> startVideo(RtcSurfaceViewModel viewModel,
      {RtcRenderConfig? config}) {
    config ??= RtcRenderConfig();
    return viewModel.invokeMethod('startVideo', {'config': config.toJson()});
  }

  @override
  Future<ResultCode?> stopVideo() {
    return _invokeMethod('stopVideo');
  }

  @override
  Future<ResultCode?> subscribeAudio(String userId) {
    return _invokeMethod('subscribeAudio', {'userId': userId});
  }

  @override
  Future<ResultCode?> unsubscribeAudio(String userId) {
    return _invokeMethod('unsubscribeAudio', {'userId': userId});
  }

  @override
  Future<ResultCode?> subscribeVideo(
      String userId, RtcSurfaceViewModel viewModel,
      {RtcRenderConfig? config}) {
    config ??= RtcRenderConfig();
    return viewModel.invokeMethod(
        'subscribeVideo', {'userId': userId, 'config': config.toJson()});
  }

  @override
  Future<ResultCode?> unsubscribeVideo(String userId) {
    return _invokeMethod('unsubscribeVideo', {'userId': userId});
  }

  @override
  Future<ResultCode?> startScreen({String? appGroupId}) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return _invokeMethod('startScreen');
    } else {
      appGroupId ??= '';
      return _invokeMethod('startScreen', {'appGroupId': appGroupId});
    }
  }

  @override
  Future<ResultCode?> stopScreen() {
    return _invokeMethod('stopScreen');
  }

  @override
  Future<ResultCode?> subscribeScreen(
      String userId, RtcSurfaceViewModel viewModel) {
    return viewModel.invokeMethod('subscribeScreen', {'userId': userId});
  }

  @override
  Future<ResultCode?> unsubscribeScreen(String userId) {
    return _invokeMethod('unsubscribeScreen', {'userId': userId});
  }

  @override
  Future<ResultCode?> updateScreenScaling(
      String userId, ScreenScalingRatio ratio) {
    return _invokeMethod('updateScreenScaling', {
      'userId': userId,
      'ratio': ScreenScalingRatioConverter(ratio).value()
    });
  }

  @override
  Future<ResultCode?> updateScreenScalingWithFocus(
      String userId, double ratio, Point<int> focus) {
    return _invokeMethod('updateScreenScalingWithFocus', {
      'userId': userId,
      'ratio': ratio,
      'focus': {'x': focus.x, 'y': focus.y}
    });
  }

  @override
  Future<ResultCode?> updateScreenMoving(String userId, Point<int> distance) {
    return _invokeMethod('updateScreenMoving', {
      'userId': userId,
      'distance': {'x': distance.x, 'y': distance.y}
    });
  }

  @override
  Future<ResultCode?> muteAudio() {
    return _invokeMethod('muteAudio');
  }

  @override
  Future<ResultCode?> unmuteAudio() {
    return _invokeMethod('unmuteAudio');
  }

  @override
  Future<ResultCode?> muteVideo() {
    return _invokeMethod('muteVideo');
  }

  @override
  Future<ResultCode?> unmuteVideo() {
    return _invokeMethod('unmuteVideo');
  }

  @override
  Future<ResultCode?> setMicrophoneMuteStatus(bool enable) {
    return _invokeMethod('setMicrophoneMuteStatus', {'enable': enable});
  }

  @override
  Future<ResultCode?> setAudioDeviceVolume(int volume, AudioDeviceType type) {
    return _invokeMethod('setAudioDeviceVolume',
        {'volume': volume, 'type': AudioDeviceTypeConverter(type).value()});
  }

  @override
  Future<int?> getAudioDeviceVolume(AudioDeviceType type) {
    return _invokeMethod('getAudioDeviceVolume',
        {'type': AudioDeviceTypeConverter(type).value()});
  }

  @override
  Future<int?> getRecordingLevel() {
    return _invokeMethod('getRecordingLevel');
  }

  @override
  Future<int?> getPlayoutLevel() {
    return _invokeMethod('getPlayoutLevel');
  }

  @override
  Future<ResultCode?> setLoudspeakerStatus(bool enable) {
    return _invokeMethod('setLoudspeakerStatus', {'enable': enable});
  }

  @override
  Future<bool?> isEnabledLoudspeaker() {
    return _invokeMethod('isEnabledLoudspeaker');
  }

  @override
  Future<ResultCode?> switchCamera() {
    return _invokeMethod('switchCamera');
  }

  @override
  Future<bool?> isFrontCamera() {
    return _invokeMethod('isFrontCamera');
  }

  @override
  Future<String?> getCameraDeviceId(bool frontCamera) {
    return _invokeMethod('getCameraDeviceId', {'frontCamera': frontCamera});
  }

  @override
  Future<ResultCode?> startPreview(RtcSurfaceViewModel viewModel,
      {RtcRenderConfig? config}) {
    config ??= RtcRenderConfig();
    return viewModel.invokeMethod('startPreview', {'config': config.toJson()});
  }

  @override
  Future<ResultCode?> stopPreview() {
    return _invokeMethod('stopPreview');
  }

  @override
  Future<ResultCode?> createAudioMixingTask(int taskId, String filename) {
    return _invokeMethod(
        'createAudioMixingTask', {'taskId': taskId, 'filename': filename});
  }

  @override
  Future<ResultCode?> destroyAudioMixingTask(int taskId) {
    return _invokeMethod('destroyAudioMixingTask', {'taskId': taskId});
  }

  @override
  Future<ResultCode?> startAudioMixingTask(
      int taskId, RtcAudioMixingConfig config) {
    return _invokeMethod(
        'startAudioMixingTask', {'taskId': taskId, 'config': config.toJson()});
  }

  @override
  Future<ResultCode?> updateAudioMixingTask(
      int taskId, RtcAudioMixingConfig config) {
    return _invokeMethod(
        'updateAudioMixingTask', {'taskId': taskId, 'config': config.toJson()});
  }

  @override
  Future<ResultCode?> stopAudioMixingTask(int taskId) {
    return _invokeMethod('stopAudioMixingTask', {'taskId': taskId});
  }

  @override
  Future<ResultCode?> resumeAudioMixing(int taskId) {
    return _invokeMethod('resumeAudioMixing', {'taskId': taskId});
  }

  @override
  Future<ResultCode?> pauseAudioMixing(int taskId) {
    return _invokeMethod('pauseAudioMixing', {'taskId': taskId});
  }

  @override
  Future<int?> getAudioMixingDuration(int taskId) {
    return _invokeMethod('getAudioMixingDuration', {'taskId': taskId});
  }

  @override
  Future<int?> getAudioMixingCurrentTimestamp(int taskId) {
    return _invokeMethod('getAudioMixingCurrentTimestamp', {'taskId': taskId});
  }

  @override
  Future<ResultCode?> seekAudioMixing(int taskId, int timestampMs) {
    return _invokeMethod(
        'seekAudioMixing', {'taskId': taskId, 'timestampMs': timestampMs});
  }

  @override
  Future<ResultCode?> snapshotVideo(String outputDir, String userId,
      {RtcSnapshotVideoOption? option}) {
    option ??= RtcSnapshotVideoOption();
    return _invokeMethod('snapshotVideo',
        {'outputDir': outputDir, 'userId': userId, 'option': option.toJson()});
  }

  @override
  Future<RtcWhiteboard?> whiteboardEngine() async {
    var whiteboardId = await _invokeMethod('whiteboardEngine') as String;
    if (whiteboardId.isNotEmpty) {
      whiteboards[whiteboardId] ??= RtcWhiteboard(whiteboardId);
      return whiteboards[whiteboardId];
    }
    return null;
  }

  @override
  Future<ResultCode?> switchWhiteboardEngine(String whiteboardId) {
    return _invokeMethod(
        'switchWhiteboardEngine', {'whiteboardId': whiteboardId});
  }

  @override
  Future<ResultCode?> startAudioDumpWithFilePath(
      String filePath, int maxFileSize) {
    return _invokeMethod('startAudioDumpWithFilePath',
        {'filePath': filePath, 'maxFileSize': maxFileSize});
  }

  @override
  Future<ResultCode?> stopAudioDump() {
    return _invokeMethod('stopAudioDump');
  }

  @override
  Future<ResultCode?> sendFeedback(FeedbackInfo info) {
    return _invokeMethod('sendFeedback', {'info': info.toJson()});
  }

  @override
  Future<ResultCode?> setOption(option, OptionType type) {
    var params = <String, dynamic>{};
    params['type'] = OptionTypeConverter(type).value();
    var isValid = true;
    switch (type) {
      case OptionType.FaceBeautify:
        if (option is FaceBeautifyOption) {
          params['option'] = option.toJson();
        } else {
          isValid = false;
        }
        break;
      case OptionType.UploadLogs:
        if (option is bool) {
          params['option'] = option;
        } else {
          isValid = false;
        }
        break;
      case OptionType.UploadAudioDump:
        if (option is bool) {
          params['option'] = option;
        } else {
          isValid = false;
        }
        break;
      case OptionType.AudioEqualizationMode:
        if (option is AudioEqualizationMode) {
          params['option'] = AudioEqualizationModeConverter(option).value();
        } else {
          isValid = false;
        }
        break;
      case OptionType.AudioReverbMode:
        if (option is AudioReverbMode) {
          params['option'] = AudioReverbModeConverter(option).value();
        } else {
          isValid = false;
        }
        break;
      case OptionType.VideoFrameRate:
        if (option is VideoFrameRateType) {
          params['option'] = VideoFrameRateTypeConverter(option).value();
        } else {
          isValid = false;
        }
        break;
      case OptionType.AudioEarMonitoring:
        if (option is bool) {
          params['option'] = option;
        } else {
          isValid = false;
        }
        break;
      case OptionType.BuiltinTransform:
        isValid = false;
        break;
      case OptionType.UploadLogsAtFailure:
        if (option is bool) {
          params['option'] = option;
        } else {
          isValid = false;
        }
        break;
      case OptionType.CpuAdaption:
        if (option is bool) {
          params['option'] = option;
        } else {
          isValid = false;
        }
        break;
      case OptionType.AudioProfile:
        if (option is RtcAudioProfile) {
          params['option'] = option.toJson();
        } else {
          isValid = false;
        }
        break;
      case OptionType.QuadTransform:
        if (option is QuadTransformOption) {
          params['option'] = option.toJson();
        } else {
          isValid = false;
        }
        break;
      case OptionType.ScreenOptimization:
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

  @override
  Future<ResultCode?> setParameters(String param) {
    return _invokeMethod('setParameters', {'param': param});
  }

  @override
  Future<RtcVideoStreamManager?> videoStreamManager() async {
    if (_videoStreamManager != null) return _videoStreamManager;
    await _invokeMethod('videoStreamManager');
    _videoStreamManager = RtcVideoStreamManager();
    return _videoStreamManager;
  }

  @override
  Future<RtcAnnotationManager?> annotationManager() async {
    if (_annotationManager != null) return _annotationManager;
    await _invokeMethod('annotationManager');
    _annotationManager = RtcAnnotationManager();
    return _annotationManager;
  }

  @override
  Future<RtcNetworkManager?> networkManager() async {
    if (_networkManager != null) return _networkManager;
    await _invokeMethod('networkManager');
    _networkManager = RtcNetworkManager();
    return _networkManager;
  }

  @override
  Future<RtcMessageService?> messageService() async {
    if (_messageService != null) return _messageService;
    await _invokeMethod('messageService');
    _messageService = RtcMessageService();
    return _messageService;
  }
}

/// The rtc engine interface
mixin RtcEngineKitInterface
    implements
        RtcDeviceManagerInterface,
        RtcAudioMixingManagerInterface,
        RtcSnapshotInterface,
        RtcWhiteboardManagerInterface,
        RtcTroubleshootInterface,
        RtcOptionInterface,
        RtcCustomizedInterface,
        RtcManagersInterface {
  /// Update the configuration of the [RtcEngineKit] object.
  ///
  /// **Parameter** [config] [RtcEngineConfig] object.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Please update the configuration before joining the channel, otherwise it will fail.
  ///
  /// 更新 RtcEngineKit 对象配置。
  ///
  /// **Parameter** [config] [RtcEngineConfig] 对象.
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 请在加入频道之前更新配置，否则将返回失败。
  Future<ResultCode?> updateConfig(RtcEngineConfig config);

  /// Destroy the [RtcEngineKit] object.
  ///
  /// **Note**
  /// After destroying the [RtcEngineKit] object, the object will no longer be valid.
  ///
  /// 销毁 [RtcEngineKit] 对象。
  ///
  /// **Note**
  /// [RtcEngineKit] 对象在销毁后将不再有效。
  Future<void> destroy();

  /// Join the channel.
  ///
  /// **Parameter** [token] The secure token that App Server got from PANO.
  ///
  /// **Parameter** [channelId] The channel ID defined by customer. It must compliance with the following rules:
  /// - max length is 128 bytes.
  /// - characters can be "0-9", "a-z", "A-Z",
  ///   whitespace (cannot at leading and trailing),
  ///   "!", "#", "$", "%", "&", "(", ")", "+", ",", "-", ".", ":",
  ///   ";", "<", "=", ">", "?", "@", "[", "]", "^", "_", "|", "~".
  ///
  /// **Parameter** [userId] The user ID defined by customer. It must be unique.
  ///
  /// **Parameter** [config] Channel configurations. (Optional)
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Join only one channel at a time.
  /// User need to check the callback [onUserJoinIndication] to see if join channel result.
  ///
  /// 加入频道。
  ///
  /// **Parameter** [token] 应用服务器从PANO获得的安全令牌。
  ///
  /// **Parameter** [channelId] 客户定义的频道标识。必须符合以下规则:
  /// - 最大长度是128字节；
  /// - 只能由以下字符构成：
  ///   "0-9", "a-z", "A-Z", 空格 (不能出现在首部和尾部),
  ///   "!", "#", "$", "%", "&", "(", ")", "+", ",", "-", ".", ":",
  ///   ";", "<", "=", ">", "?", "@", "[", "]", "^", "_", "|", "~"。
  ///
  /// **Parameter** [userId] 客户定义的用户标识。必须是唯一的。
  ///
  /// **Parameter** [config] 频道设置。（可选）
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 同一时刻只能加入一个频道。
  /// 用户需检查回调函数 [onUserJoinIndication] 获知加会结果。
  Future<ResultCode?> joinChannel(String token, String channelId, String userId,
      {RtcChannelConfig? config});

  /// Leave the channel.
  ///
  ///
  /// 离开频道。
  ///
  Future<void> leaveChannel();

  /// Start audio.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Please join one channel before starting audio, otherwise it will fail.
  ///
  /// 开启音频。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 开启音频前请先加入一个频道，否则将返回失败。
  Future<ResultCode?> startAudio();

  /// Stop audio.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 停止音频。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> stopAudio();

  /// Start video (with a render view).
  ///
  /// **Parameter** [viewModel] [RtcSurfaceViewModel] object.
  ///
  /// **Parameter** [config] [RtcRenderConfig] object.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Please join one channel before starting video, otherwise it will fail.
  /// Must be called from main thread.
  ///
  /// 开启视频（随带渲染视图）。
  ///
  /// **Parameter** [viewModel] [RtcSurfaceViewModel] 对象。
  ///
  /// **Parameter** [config] [RtcRenderConfig] 对象。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 开启视频前请先加入一个频道，否则将返回失败。
  /// 必须从主线程调用。
  Future<ResultCode?> startVideo(RtcSurfaceViewModel viewModel,
      {RtcRenderConfig? config});

  /// Stop video.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 停止视频。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> stopVideo();

  /// Subscribe to a user's audio.
  ///
  /// **Parameter** [userId] The user ID defined by customer.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Before subscribing to a user’s audio, please make sure the user has started the audio.
  ///
  /// 订阅用户的音频。
  ///
  /// **Parameter** [userId] 客户定义的用户标识。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 订阅用户的音频前，请确保用户已开启音频。
  Future<ResultCode?> subscribeAudio(String userId);

  /// Unsubscribe to a user's audio.
  ///
  /// **Parameter** [userId] The user ID defined by customer.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// When a user stops the audio or leaves the channel, the user's audio will be automatically unsubscribed.
  ///
  /// 取消订阅用户的音频。
  ///
  /// **Parameter** [userId] 客户定义的用户标识。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 当用户停止音频或者离开频道的时候，用户的音频将会被自动取消订阅。
  Future<ResultCode?> unsubscribeAudio(String userId);

  /// Subscribe to a user's video (with a render view).
  ///
  /// **Parameter** [userId] The user ID defined by customer.
  ///
  /// **Parameter** [viewModel] [RtcSurfaceViewModel] object.
  ///
  /// **Parameter** [config] [RtcRenderConfig] object.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Before subscribing to a user’s video, please make sure the user has started the video.
  /// Must be called from main thread.
  ///
  /// 订阅用户的视频（随带渲染视图）。
  ///
  /// **Parameter** [userId] 客户定义的用户标识。
  ///
  /// **Parameter** [viewModel] [RtcSurfaceViewModel] 对象。
  ///
  /// **Parameter** [config] [RtcRenderConfig] 对象。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 订阅用户的视频前，请确保用户已开启视频。
  /// 必须从主线程调用。
  Future<ResultCode?> subscribeVideo(
      String userId, RtcSurfaceViewModel viewModel,
      {RtcRenderConfig? config});

  /// Unsubscribe to a user's video.
  ///
  /// **Parameter** [userId] The user ID defined by customer.
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
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 当用户停止视频或者离开频道的时候，用户的视频将会被自动取消订阅。
  Future<ResultCode?> unsubscribeVideo(String userId);

  /// Start screen capture.
  ///
  /// **Parameter** [appGroupId] Application Group Identifier. Online document: https://developer.pano.video/features/rtc/screen-ios/ (Optional)(iOS only)
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// iOS: This interface supports iPhone and iPad with iOS 11.0 and above
  ///
  /// 开始屏幕采集。
  ///
  /// **Parameter** [appGroupId] Application Group Identifier。请参考文档：https://developer.pano.video/features/rtc/screen-ios/（可选）（仅限iOS）
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// iOS: 该接口支持 iOS 11.0 及以上的 iPhone 和 iPad
  Future<ResultCode?> startScreen({String? appGroupId});

  /// Stop screen capture.
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  /// 停止屏幕采集。
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> stopScreen();

  /// Subscribe to a user's screen sharing (with a render view).
  ///
  /// **Parameter** [userId] The user ID defined by customer.
  ///
  /// **Parameter** [viewModel] [RtcSurfaceViewModel] object.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Before subscribing to a user’s screen sharing, please make sure the user has started the screen sharing.
  /// Must be called from main thread.
  ///
  /// 订阅用户的屏幕共享（随带渲染视图）。
  ///
  /// **Parameter** [userId] 客户定义的用户标识。
  ///
  /// **Parameter** [viewModel] [RtcSurfaceViewModel] 对象。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 订阅用户的屏幕共享前，请确保用户已开启屏幕共享。
  /// 必须从主线程调用。
  Future<ResultCode?> subscribeScreen(
      String userId, RtcSurfaceViewModel viewModel);

  /// Unsubscribe to a user's screen sharing.
  ///
  /// **Parameter** [userId] The user ID defined by customer.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// When a user stops the screen sharing or leaves the channel,
  /// the user's screen sharing will be automatically unsubscribed.
  ///
  /// 取消订阅用户的屏幕共享。
  ///
  /// **Parameter** [userId] 客户定义的用户标识。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 当用户停止屏幕共享或者离开频道的时候，用户的屏幕共享将会被自动取消订阅。
  Future<ResultCode?> unsubscribeScreen(String userId);

  /// Update screen absolute scaling ratio.
  ///
  /// **Parameter** [userId] The user ID defined by customer.
  ///
  /// **Parameter** [ratio] Screen scaling ratio type.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// The default focus is center point of view.
  ///
  /// 更新屏幕的绝对缩放比例。
  ///
  /// **Parameter** [userId] 客户定义的用户标识。
  ///
  /// **Parameter** [ratio] 屏幕缩放比例类型。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 默认焦点是视图的中心点。
  Future<ResultCode?> updateScreenScaling(
      String userId, ScreenScalingRatio ratio);

  /// Update screen relative scaling ratio.
  ///
  /// **Parameter** [userId] The user ID defined by customer.
  ///
  /// **Parameter** [ratio] Screen scaling ratio value.
  ///
  /// **Parameter** [focus] Screen focus coordinate value.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 更新屏幕的相对缩放比例。
  ///
  /// **Parameter** [userId] 客户定义的用户标识。
  ///
  /// **Parameter** [ratio] 屏幕缩放比例值。
  ///
  /// **Parameter** [focus] 屏幕焦点坐标值。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> updateScreenScalingWithFocus(
      String userId, double ratio, Point<int> focus);

  /// Update screen relative moving distance.
  ///
  /// **Parameter** [userId] The user ID defined by customer.
  ///
  /// **Parameter** [distance] Screen focus moving distance.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 更新屏幕的相对移动距离。
  ///
  /// **Parameter** [userId] 客户定义的用户标识。
  ///
  /// **Parameter** [distance] 屏幕焦点移动距离。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> updateScreenMoving(String userId, Point<int> distance);

  /// Mute audio.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Please start the audio before muting, otherwise it will not work.
  ///
  /// 静音。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 静音前请先开启音频，否则操作将无效。
  Future<ResultCode?> muteAudio();

  /// Unmute audio.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Please start the audio before unmuting, otherwise it will not work.
  ///
  /// 取消静音。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 取消静音前请先开启音频，否则操作将无效。
  Future<ResultCode?> unmuteAudio();

  /// Pause video.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Please start the video before pausing, otherwise it will not work.
  ///
  /// 暂停视频。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 暂停视频前请先开启视频，否则操作将无效。
  Future<ResultCode?> muteVideo();

  /// Resume video.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Please start the video before resuming, otherwise it will not work.
  ///
  /// 恢复视频。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 恢复视频前请先开启视频，否则操作将无效。
  Future<ResultCode?> unmuteVideo();
}

/// @nodoc
mixin RtcDeviceManagerInterface {
  /// set microphone mute enable status
  ///
  /// **Parameter** [enable] enable mute flag, true/false to mute/unmute
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置麦克风采集数据静音状态(不包括伴音等其他声音)
  ///
  /// **Parameter** [enable] 静音开关， 打开/关闭 静音
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setMicrophoneMuteStatus(bool enable);

  /// Set the volume of the current audio device.
  ///
  /// **Parameter** [volume] Valid value ranges between 0 and 255.
  ///
  /// **Parameter** [type] Device type, PanoDeviceType enum type.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置当前音频设备的音量。
  ///
  /// **Parameter** [volume] 有效值范围0到255。
  ///
  /// **Parameter** [type] 设备类型，PanoDeviceType 枚举类型。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setAudioDeviceVolume(int volume, AudioDeviceType type);

  /// Get the volume of the current audio device.
  ///
  /// **Parameter** [type] Device type, PanoDeviceType enum type.
  ///
  /// **Returns**
  /// Current volume. Valid value ranges between 0 and 255.
  ///
  /// 获取当前音频设备的音量。
  ///
  /// **Parameter** [type] 设备类型，PanoDeviceType 枚举类型。
  ///
  /// **Returns**
  /// 当前音量。有效值范围0到255。
  Future<int?> getAudioDeviceVolume(AudioDeviceType type);

  /// Get audio capture level.
  ///
  /// **Returns**
  /// Audio capture level.
  ///
  /// 获取音频采集强度值。
  ///
  /// **Returns**
  /// 音频采集强度值。
  Future<int?> getRecordingLevel();

  /// Get audio playout level.
  ///
  /// **Returns**
  /// Audio playout level.
  ///
  /// 获取音频播放强度值。
  ///
  /// **Returns**
  /// 音频播放强度值。
  Future<int?> getPlayoutLevel();

  /// Set loudspeaker enable status.
  ///
  /// **Parameter** [enable] Whether to enable.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置扬声器启用状态。
  ///
  /// **Parameter** [enable] 是否启用。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setLoudspeakerStatus(bool enable);

  /// Get loudspeaker enable status.
  ///
  /// **Returns**
  /// Whether to enable.
  ///
  /// 获取扬声器启用状态。
  ///
  /// **Returns**
  /// 是否启用。
  Future<bool?> isEnabledLoudspeaker();

  /// Switch front and rear cameras.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 切换前后置摄像头。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> switchCamera();

  /// Get current camera type.
  ///
  /// **Returns**
  /// Whether it is a front camera.
  ///
  /// 获取当前摄像头类型。
  ///
  /// **Returns**
  /// 是否是前置摄像头。
  Future<bool?> isFrontCamera();

  /// Get camera device ID.
  ///
  /// **Parameter** [frontCamera] Camera device type, `true` is front camera, `false` is back camera.
  ///
  /// **Returns**
  /// Device unique ID.
  ///
  /// 获取摄像头设备标识。
  ///
  /// **Parameter** [frontCamera] 摄像头设备类型，YES是前置摄像头，NO是后置摄像头。
  ///
  /// **Returns**
  /// 设备唯一标识。
  Future<String?> getCameraDeviceId(bool frontCamera);

  /// Start current camera preview (with a render view).
  ///
  /// **Parameter** [viewModel] [RtcSurfaceViewModel] object.
  ///
  /// **Parameter** [config] [RtcRenderConfig] object.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// Must be called from main thread.
  ///
  /// 开启当前摄像头预览（随带渲染视图）。
  ///
  /// **Parameter** [viewModel] [RtcSurfaceViewModel] 对象。
  ///
  /// **Parameter** [config] [RtcRenderConfig] 对象。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 必须从主线程调用。
  Future<ResultCode?> startPreview(RtcSurfaceViewModel viewModel,
      {RtcRenderConfig? config});

  /// Stop current camera preview.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 停止当前摄像头预览。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> stopPreview();
}

/// @nodoc
mixin RtcAudioMixingManagerInterface {
  /// Create audio mixing task.
  ///
  /// **Parameter** [taskId] unique identifier of task.
  ///
  /// **Parameter** [filename] full path of music file. support mp3, aac, wav.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  ///
  /// 创建混音任务。
  ///
  /// **Parameter** [taskId] 任务标识。
  ///
  /// **Parameter** [filename] 音频文件的完整路径。支持mp3，aac，wav。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> createAudioMixingTask(int taskId, String filename);

  /// Destroy audio mixing task.
  ///
  /// **Parameter** [taskId] unique identifier of task.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 销毁混音任务。
  ///
  /// **Parameter** [taskId] 任务标识。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> destroyAudioMixingTask(int taskId);

  /// Start audio mixing task.
  ///
  /// **Parameter** [taskId] unique identifier of task.
  ///
  /// **Parameter** [config] task configuration
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// The real mixing process will only work after joining channel.
  ///
  /// 启动混音任务。
  ///
  /// **Parameter** [taskId] 任务标识。
  ///
  /// **Parameter** [config] 配置参数。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// 实际的混音操作仅在加入房间后进行。
  Future<ResultCode?> startAudioMixingTask(
      int taskId, RtcAudioMixingConfig config);

  /// Update audio mixing task configuration.
  ///
  /// **Parameter** [taskId] unique identifier of task.
  ///
  /// **Parameter** [config] task configuration
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 更新混音任务配置参数。
  ///
  /// **Parameter** [taskId] 任务标识。
  ///
  /// **Parameter** [config] 配置参数。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> updateAudioMixingTask(
      int taskId, RtcAudioMixingConfig config);

  /// Stop audio mixing task.
  ///
  /// **Parameter** [taskId] unique identifier of task.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 结束混音任务。
  ///
  /// **Parameter** [taskId] 任务标识。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> stopAudioMixingTask(int taskId);

  /// Resume the paused audio mixing task.
  ///
  /// **Parameter** [taskId] unique identifier of task.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 恢复被暂停的混音任务。
  ///
  /// **Parameter** [taskId] 任务标识。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> resumeAudioMixing(int taskId);

  /// Pause audio mixing task.
  ///
  /// **Parameter** [taskId] unique identifier of task.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 暂停混音任务。
  ///
  /// **Parameter** [taskId] 任务标识。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> pauseAudioMixing(int taskId);

  /// Get duration of music file.
  ///
  /// **Parameter** [taskId] unique identifier of task.
  ///
  /// **Returns**
  /// Duration with millisecond. If fail, the duration is less than 0.
  ///
  /// **Note**
  /// The duration is estimated based on the average bitrate. For some audio files with
  /// a non-constant bitrate, there may be a deviation from the actual value.
  ///
  /// 获取音频文件的总时长。
  ///
  /// **Parameter** [taskId] 任务标识。
  ///
  /// **Returns**
  /// 毫秒级总时长。如果失败，返回值小于0。
  ///
  /// **Note**
  /// 总时长是根据文件平均码率估算出来的。对于某些非恒定码率的音频文件，可能与实际总时长相比存在一定偏差。
  Future<int?> getAudioMixingDuration(int taskId);

  /// Get current timestamp.
  ///
  /// **Parameter** [taskId] unique identifier of task.
  ///
  /// **Returns**
  /// Current timestamp with millisecond. If fail or task has stopped, the timestamp is less than 0.
  ///
  /// 获取当前时间戳。
  ///
  /// **Parameter** [taskId] 任务标识。
  ///
  /// **Returns**
  /// 毫秒级当前时间戳。如果失败或者混音任务已结束，返回值小于0。
  Future<int?> getAudioMixingCurrentTimestamp(int taskId);

  /// Seek to target timestamp.
  ///
  /// **Parameter** [taskId] unique identifier of task.
  ///
  /// **Parameter** [timestampMs] timestamp.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 跳转至指定时间戳。
  ///
  /// **Parameter** [taskId] 任务标识。
  ///
  /// **Parameter** [timestampMs] 时间戳。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> seekAudioMixing(int taskId, int timestampMs);
}

/// @nodoc
mixin RtcSnapshotInterface {
  /// Capture specific user's video content
  ///
  /// **Parameter** [outputDir] output directory
  ///
  /// **Parameter** [userId] the id of target user
  ///
  /// **Parameter** [option] snapshot option
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 捕获指定用户的视频画面
  ///
  /// **Parameter** [outputDir] 输出路径
  ///
  /// **Parameter** [userId] 目标用户的ID
  ///
  /// **Parameter** [option] 快照选项
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> snapshotVideo(String outputDir, String userId,
      {RtcSnapshotVideoOption? option});
}

/// @nodoc
mixin RtcWhiteboardManagerInterface {
  /// Get whiteboard control object.
  ///
  /// **Returns**
  /// [RtcWhiteboard] object.
  ///
  /// 获取白板控制对象。
  ///
  /// **Returns**
  /// [RtcWhiteboard] 对象。
  Future<RtcWhiteboard?> whiteboardEngine();

  /// Switch whiteboard control object.
  ///
  /// **Parameter** [whiteboardId] whiteboard Id
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// **Note**
  /// - This interface is used for multiple whiteboard case.
  /// - [RtcEngineKit] creates whiteboard with whiteboard Id "default" automatically
  /// - RtcEngine will reserve whiteboard Id with "pano-" prefix, please don't use it.
  /// - When call this interface with whiteboard Id not set before, [RtcEngineKit] will create new whiteboard internal.
  /// - Call whiteboardEngine to get current whiteboard object after switch.
  ///
  /// 切换白板控制对象
  ///
  /// **Parameter** [whiteboardId] 白板Id
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  ///
  /// **Note**
  /// - 此接口用于多白板用例场景。
  /// - [RtcEngineKit]会自动创建白板Id为"default"的白板
  /// - RtcEngine会保留前缀为"pano-"的白板Id，请不要使用
  /// - 当传入的whiteboardId之前没被设置过，[RtcEngineKit]会生成新的白板
  /// - 切换后需要调用whiteboardEngine获得当前的白板控制对象。
  Future<ResultCode?> switchWhiteboardEngine(String whiteboardId);
}

/// @nodoc
mixin RtcTroubleshootInterface {
  /// Start audio dump.
  ///
  /// **Parameter** [filePath] The dump file path.
  ///
  /// **Parameter** [maxFileSize] The max dump file size. If the value is -1, the file size is unlimited.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 开启音频转储。
  ///
  /// **Parameter** [filePath] 转储文件路径.
  ///
  /// **Parameter** [maxFileSize] 最大转储文件大小. 如果值为-1，则文件大小不受限制。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> startAudioDumpWithFilePath(
      String filePath, int maxFileSize);

  /// Stop audio dump.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 停止音频转储。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> stopAudioDump();

  /// Send feedback to PANO.
  ///
  /// **Parameter** [info] Feedback info.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 发送用户反馈到 PANO。
  ///
  /// **Parameter** [info] 反馈的信息。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> sendFeedback(FeedbackInfo info);
}

/// @nodoc
mixin RtcOptionInterface {
  /// Set option object to PANO SDK.
  ///
  /// **Parameter** [option] The Option object.
  ///
  /// **Parameter** [type] [PanoOptionType] enum type.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置选项对象给PANO SDK。
  ///
  /// **Parameter** [option] 选项对象。
  ///
  /// **Parameter** [type] [PanoOptionType] 枚举类型。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setOption(dynamic option, OptionType type);
}

/// @nodoc
mixin RtcCustomizedInterface {
  /// Set customized parameters to PANO SDK.
  ///
  /// **Parameter** [param] JSON-format parameters.
  ///
  /// **Returns**
  /// - [ResultCode.OK] Success
  /// - others: Failure
  ///
  /// 设置自定义参数给PANO SDK。
  ///
  /// **Parameter** [param] JSON格式参数。
  ///
  /// **Returns**
  /// - [ResultCode.OK] 成功
  /// - 其他: 失败
  Future<ResultCode?> setParameters(String param);
}

/// @nodoc
mixin RtcManagersInterface {
  /// Get video stream manager object.
  ///
  /// **Returns**
  /// [RtcVideoStreamManager] object.
  ///
  /// 获取视频流管理器对象。
  ///
  /// **Returns**
  /// [RtcVideoStreamManager] 对象。
  Future<RtcVideoStreamManager?> videoStreamManager();

  /// Get annotation manager object.
  ///
  /// **Returns**
  /// [RtcAnnotationManager] object.
  ///
  /// 获取标注管理器对象。
  ///
  /// **Returns**
  /// [RtcAnnotationManager] 对象。
  Future<RtcAnnotationManager?> annotationManager();

  /// get the network manager, it can be called before initialize.
  ///
  /// **Returns**
  /// [RtcNetworkManager] object.
  ///
  /// 获取网络管理器的指针
  ///
  /// **Returns**
  /// [RtcNetworkManager] 对象。
  Future<RtcNetworkManager?> networkManager();

  /// Get the message service interface.
  ///
  /// **Returns**
  /// [RtcMessageService] object.
  ///
  /// 获取消息服务的接口指针
  ///
  /// **Returns**
  /// [RtcMessageService] 对象。
  Future<RtcMessageService?> messageService();
}

import 'dart:typed_data';

import 'package:pano_rtc/pano_rtc.dart';

import 'enum_converter.dart';
import 'rtc_enums.dart';

typedef EmptyCallback = void Function();
typedef ResultCallback = void Function(ResultCode? result);
typedef UserIdCallback = void Function(String userId);

//Engine
typedef OnChannelCountDown = void Function(int remain);
typedef OnUserJoinIndication = void Function(String userId, String userName);
typedef OnUserLeaveIndication = void Function(
    String userId, UserLeaveReason? reason);
typedef OnUserAudioSubscribe = void Function(
    String userId, SubscribeResult? result);
typedef OnUserVideoStart = void Function(
    String userId, VideoProfileType? maxProfile);
typedef OnUserVideoSubscribe = void Function(
    String userId, SubscribeResult? result);
typedef OnUserScreenSubscribe = void Function(
    String userId, SubscribeResult? result);
typedef OnWhiteboardStartWithId = void Function(String whiteboardId);
typedef OnWhiteboardStopWithId = void Function(String whiteboardId);
typedef OnVideoCaptureStateChanged = void Function(
    String deviceId, VideoCaptureState? state);
typedef OnScreenCaptureStateChanged = void Function(
    ScreenCaptureState? state, ResultCode? reason);
typedef OnChannelFailover = void Function(FailoverState? state);
typedef OnActiveSpeakerListUpdated = void Function(List<String>? userIds);
typedef OnAudioMixingStateChanged = void Function(
    int taskId, AudioMixingState? state);
typedef OnVideoSnapshotCompleted = void Function(
    bool succeed, String userId, String fileName);
typedef OnNetworkQuality = void Function(String userId, QualityRating? quality);
typedef OnUserAudioLevel = void Function(RtcAudioLevel level);

typedef RtcVideoSendStatsCallback = void Function(RtcVideoSendStats stats);
typedef RtcVideoRecvStatsCallback = void Function(RtcVideoRecvStats stats);
typedef RtcAudioSendStatsCallback = void Function(RtcAudioSendStats stats);
typedef RtcAudioRecvStatsCallback = void Function(RtcAudioRecvStats stats);
typedef RtcVideoSendBweStatsCallback = void Function(
    RtcVideoSendBweStats stats);
typedef RtcVideoRecvBweStatsCallback = void Function(
    RtcVideoRecvBweStats stats);
typedef RtcSystemStatsCallback = void Function(RtcSystemStats stats);

/// Callback of RtcEngine,  the callbacks must to set to RtcEngine to get events notification.
///
/// RtcEngine的回调函数， 在使用RtcEigine之前必须要设置回调以获取事件通知。
class RtcEngineEventHandler {
  /// Notification of join channel
  ///
  /// **Parameter** [result] OK means join channel success, others mean join channel fail.
  ///
  /// 加入频道的通知
  ///
  /// **Parameter** [result] OK 表示加入频道成功， 其他表示加入频道失败。
  ResultCallback? onChannelJoinConfirm;

  /// Notification of leave channel
  ///
  /// **Parameter** [result] OK means leave channel normally,  others mans leave channel abnormally.
  ///
  /// 离开频道的通知
  ///
  /// **Parameter** [result] OK 表示正常离开频道， 其他表示非正常离开频道。
  ResultCallback? onChannelLeaveIndication;

  /// Notification of channel count down
  ///
  /// **Parameter** [remain] channel remian time in seconds.
  ///
  /// 频道倒计时通知
  ///
  /// **Parameter** [remain] 频道剩余时间，单位：秒。

  OnChannelCountDown? onChannelCountDown;

  /// Notification of other attendee join
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [userName] user name, can be empty string.
  ///
  /// 其他人员的加入通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [userName] 用户名字， 可能为空字符串。
  OnUserJoinIndication? onUserJoinIndication;

  /// Notification of other attendee leave
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [reason] reason of leave. OK means attendee leave normally, others attendee mean leave abnormally.
  ///
  /// 其他人员离开通知。
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [reason] 用户离开的原因, OK表示正常离开， 其他为非正常离开。
  OnUserLeaveIndication? onUserLeaveIndication;

  /// Notification of attendee start audio
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 用户打开音频通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserAudioStart;

  /// Notification of attendee stop audio
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 用户关闭音频通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserAudioStop;

  /// Notification of result to subscribe user audio
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [result] the result of subscribing
  ///
  /// 用户音频订阅结果通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [result] 订阅结果。
  OnUserAudioSubscribe? onUserAudioSubscribe;

  /// Notification of attendee start video
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [maxProfile] user video profile
  ///
  /// 用户开启视频通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [maxProfile] 用户视频能力
  OnUserVideoStart? onUserVideoStart;

  /// Notification of attendee stop video
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 用户关闭视频通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserVideoStop;

  /// Notification of result to subscribe user video
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [result] the result of subscribing
  ///
  /// 用户视频订阅结果通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [result] 订阅结果。
  OnUserVideoSubscribe? onUserVideoSubscribe;

  /// Notification of attendee mute audio
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 用户设置静音通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserAudioMute;

  /// Notification of attendee unmute audio
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 用户取消静音通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserAudioUnmute;

  /// Notification of attendee mute video
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 用户暂停视频通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserVideoMute;

  /// Notification of attendee unmute video
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 用户恢复视频通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserVideoUnmute;

  /// Notification of attendee start screen share
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 用户开启屏幕共享通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserScreenStart;

  /// Notification of attendee stop screen share
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 用户关闭屏幕共享通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserScreenStop;

  /// Notification of result to subscribe user screen share
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [result] the result of subscribing
  ///
  /// 用户桌面共享订阅结果通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [result] 订阅结果。
  OnUserScreenSubscribe? onUserScreenSubscribe;

  /// Notification of attendee mute screen share
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 用户暂停屏幕共享通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserScreenMute;

  /// Notification of attendee unmute screen share
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 用户恢复屏幕共享通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserScreenUnmute;

  /// Notification of whiteboard service available
  ///
  /// 白板服务可用通知
  EmptyCallback? onWhiteboardAvailable;

  /// Notification of whiteboard service unavailable
  ///
  /// 白板服务不可用通知
  EmptyCallback? onWhiteboardUnavailable;

  /// Notification of default whiteboard start
  ///
  /// 开始默认共享白板通知
  EmptyCallback? onWhiteboardStart;

  /// Notification of default whiteboard stop
  ///
  /// 终止默认共享白板通知
  EmptyCallback? onWhiteboardStop;

  /// Notification of whiteboard start
  ///
  /// **Parameter** [whiteboardId] whiteboard Id
  ///
  /// 开始共享白板通知
  ///
  /// **Parameter** [whiteboardId] 白板Id
  OnWhiteboardStartWithId? onWhiteboardStartWithId;

  /// Notification of whiteboard stop
  ///
  /// **Parameter** [whiteboardId] whiteboard Id
  ///
  /// 终止共享白板通知
  ///
  /// **Parameter** [whiteboardId] 白板Id
  OnWhiteboardStopWithId? onWhiteboardStopWithId;

  /// Notification of first audio packet arrived
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 第一个音频包到达通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onFirstAudioDataReceived;

  /// Notification of first video packet arrived
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 第一个视频包到达通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onFirstVideoDataReceived;

  /// Notification of first screen share packet arrived
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 第一个屏幕共享包到达通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onFirstScreenDataReceived;

  /// Notification of first video frame will be rendered.
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 第一个视频帧渲染通知。
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onFirstVideoFrameRendered;

  /// Notification of first screen share frame will be rendered.
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 第一个屏幕共享帧渲染通知。
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onFirstScreenFrameRendered;

  /// Notification of video capture state changed.
  ///
  /// **Parameter** [deviceID] The device ID.
  ///
  /// **Parameter** [state] The capture state.
  ///
  /// 视频采集状态变化的通知。
  ///
  /// **Parameter** [deviceID] 设备ID。
  ///
  /// **Parameter** [state] 采集状态。
  OnVideoCaptureStateChanged? onVideoCaptureStateChanged;

  /// Notification of channel failover
  ///
  /// **Parameter** [state] failover state
  ///
  /// 频道错误恢复通知
  ///
  /// **Parameter** [state] 错误恢复状态
  OnChannelFailover? onChannelFailover;

  /// Notification of active speaker list updating
  ///
  /// **Parameter** [userIds] The userId list, sorted by users' audio energy
  ///
  /// **Parameter** [count] The count of userId list
  ///
  /// 活跃用户列表变更通知
  ///
  /// **Parameter** [userIds] 用户 ID 列表, 按声音能量值排序
  ///
  /// **Parameter** [count] 用户列表大小
  OnActiveSpeakerListUpdated? onActiveSpeakerListUpdated;

  /// Notification of audio mixing state changing
  ///
  /// **Parameter** [taskId] Unique identifier of task.
  ///
  /// **Parameter** [state] State of Audio mixing task.
  ///
  /// 混音任务状态变更通知
  ///
  /// **Parameter** [taskId] 任务标识
  ///
  /// **Parameter** [state] 混音状态
  OnAudioMixingStateChanged? onAudioMixingStateChanged;

  /// Notification of user's video snapshot completed
  ///
  /// **Parameter** [succeed] Succeed to write the image.
  ///
  /// **Parameter** [userId] The userId of snapshot source
  ///
  /// **Parameter** [filename] The snapshot image full path with name.
  ///
  /// 用户视频快照完成通知
  ///
  /// **Parameter** [succeed] 是否成功写入文件
  ///
  /// **Parameter** [userId] 快照所属的用户ID
  ///
  /// **Parameter** [filename] 快照文件完整路径
  OnVideoSnapshotCompleted? onVideoSnapshotCompleted;

  /// Notification of in-call network quality
  ///
  /// **Parameter** [userId] The user ID
  ///
  /// **Parameter** [quality] The network quality.
  ///
  /// 通话中的网络质量通知
  ///
  /// **Parameter** [userId] 用户ID
  ///
  /// **Parameter** [quality] 网络质量
  OnNetworkQuality? onNetworkQuality;

  /// Notification of audio start result
  ///
  /// **Parameter** [result] The result of audio start
  ///
  /// 音频开启成功与否的通知
  ///
  /// **Parameter** [result] 音频开启的结果
  ResultCallback? onAudioStartResult;

  /// Notification of video start result
  ///
  /// **Parameter** [result] The result of video start
  ///
  /// 视频开启成功与否的通知
  ///
  /// **Parameter** [result] 视频开启的结果
  ResultCallback? onVideoStartResult;

  /// Notification of sharing start result
  ///
  /// **Parameter** [result] The result of sharing start
  ///
  /// 共享开启成功与否的通知
  ///
  /// **Parameter** [result] 共享开启的结果
  ResultCallback? onScreenStartResult;

  /// Notification of screen capture state changed.
  ///
  /// **Parameter** [state] The capture state.
  ///
  /// **Parameter** [reason] The reason of capture state change.
  ///
  /// 屏幕采集状态变化的通知。
  ///
  /// **Parameter** [state] 采集状态。
  ///
  /// **Parameter** [reason] 状态变化原因。
  OnScreenCaptureStateChanged? onScreenCaptureStateChanged;

  /// Callback user audio level.
  ///
  /// **Parameter** [level] Current audio level.
  ///
  /// 回调用户声音强度。
  ///
  /// **Parameter** [level] 当前的用户强度。
  OnUserAudioLevel? onUserAudioLevel;

  /// Callback statistics of sent video.
  ///
  /// **Parameter** [stats] Statistics of sent video.
  ///
  /// 回调发送视频的统计。
  ///
  /// **Parameter** [stats] 已发送视频的统计信息。
  RtcVideoSendStatsCallback? onVideoSendStats;

  /// Callback statistics of received video.
  ///
  /// **Parameter** [stats] Statistics of received video.
  ///
  /// 回调接收视频的统计。
  ///
  /// **Parameter** [stats] 已接收视频的统计信息。
  RtcVideoRecvStatsCallback? onVideoRecvStats;

  /// Callback statistics of sent audio.
  ///
  /// **Parameter** [stats] Statistics of sent aduio.
  ///
  /// 回调发送音频的统计。
  ///
  /// **Parameter** [stats] 已发送音频的统计信息。
  RtcAudioSendStatsCallback? onAudioSendStats;

  /// Callback statistics of received audio.
  ///
  /// **Parameter** [stats] Statistics of received audio.
  ///
  /// 回调接收音频的统计。
  ///
  /// **Parameter** [stats] 已接收音频的统计信息。
  RtcAudioRecvStatsCallback? onAudioRecvStats;

  /// Callback statistics of sent screen sharing.
  ///
  /// **Parameter** [stats] Statistics of sent video.
  ///
  /// 回调发送屏幕共享的统计。
  ///
  /// **Parameter** [stats] 已发送屏幕共享的统计信息。
  RtcVideoSendStatsCallback? onScreenSendStats;

  /// Callback statistics of received screen sharing.
  ///
  /// **Parameter** [stats] Statistics of received screen sharing.
  ///
  /// 回调接收屏幕共享的统计。
  ///
  /// **Parameter** [stats] 已接收屏幕共享的统计信息。
  RtcVideoRecvStatsCallback? onScreenRecvStats;

  /// Callback bandwidth estimation information of sent video.
  ///
  /// **Parameter** [stats] Bandwidth estimation of sent video.
  ///
  /// **Note**
  /// Total bandwidth evaluation including sent video and screen sharing.
  ///
  /// 回调发送视频的带宽评估。
  ///
  /// **Parameter** [stats] 发送视频的带宽评估信息。
  ///
  /// **Note**
  /// 包含发送视频和屏幕共享的总共带宽评估。
  RtcVideoSendBweStatsCallback? onVideoSendBweStats;

  /// Callback bandwidth estimation information of received video.
  ///
  /// **Parameter** [stats] Bandwidth estimation of received video.
  ///
  /// **Note**
  /// Total bandwidth estimation including received video and screen sharing.
  ///
  /// 回调接收视频的带宽评估。
  ///
  /// **Parameter** [stats] 接收视频的带宽评估信息。
  ///
  /// **Note**
  /// 包含接收视频和屏幕共享的总共带宽评估。
  RtcVideoRecvBweStatsCallback? onVideoRecvBweStats;

  /// Callback system statistics.
  ///
  /// **Parameter** [stats] Current system statistics.
  ///
  /// 回调系统统计信息。
  ///
  /// **Parameter** [stats] 当前的系统统计信息。
  RtcSystemStatsCallback? onSystemStats;

  /// Constructs a [RtcEngineEventHandler]
  RtcEngineEventHandler(
      {this.onChannelJoinConfirm,
      this.onChannelLeaveIndication,
      this.onChannelCountDown,
      this.onUserJoinIndication,
      this.onUserLeaveIndication,
      this.onUserAudioStart,
      this.onUserAudioStop,
      this.onUserAudioSubscribe,
      this.onUserVideoStart,
      this.onUserVideoStop,
      this.onUserVideoSubscribe,
      this.onUserAudioMute,
      this.onUserAudioUnmute,
      this.onUserVideoMute,
      this.onUserVideoUnmute,
      this.onUserScreenStart,
      this.onUserScreenStop,
      this.onUserScreenSubscribe,
      this.onUserScreenMute,
      this.onUserScreenUnmute,
      this.onWhiteboardAvailable,
      this.onWhiteboardUnavailable,
      this.onWhiteboardStart,
      this.onWhiteboardStop,
      this.onWhiteboardStartWithId,
      this.onWhiteboardStopWithId,
      this.onFirstAudioDataReceived,
      this.onFirstVideoDataReceived,
      this.onFirstScreenDataReceived,
      this.onFirstVideoFrameRendered,
      this.onFirstScreenFrameRendered,
      this.onVideoCaptureStateChanged,
      this.onAudioStartResult,
      this.onVideoStartResult,
      this.onScreenStartResult,
      this.onScreenCaptureStateChanged,
      this.onChannelFailover,
      this.onActiveSpeakerListUpdated,
      this.onAudioMixingStateChanged,
      this.onVideoSnapshotCompleted,
      this.onNetworkQuality,
      this.onUserAudioLevel,
      this.onVideoSendStats,
      this.onVideoRecvStats,
      this.onAudioSendStats,
      this.onAudioRecvStats,
      this.onScreenSendStats,
      this.onScreenRecvStats,
      this.onVideoSendBweStats,
      this.onVideoRecvBweStats,
      this.onSystemStats});

  /// @nodoc
  void process(String? methodName, List<dynamic> data) {
    switch (methodName) {
      case 'onChannelJoinConfirm':
        onChannelJoinConfirm?.call(ResultCodeConverter.fromValue(data[0]).e);
        break;
      case 'onChannelLeaveIndication':
        onChannelLeaveIndication
            ?.call(ResultCodeConverter.fromValue(data[0]).e);
        break;
      case 'onChannelCountDown':
        onChannelCountDown?.call(data[0]);
        break;
      case 'onUserJoinIndication':
        onUserJoinIndication?.call(data[0], data[1]);
        break;
      case 'onUserLeaveIndication':
        onUserLeaveIndication?.call(
            data[0], UserLeaveReasonConverter.fromValue(data[1]).e);
        break;
      case 'onUserAudioStart':
        onUserAudioStart?.call(data[0]);
        break;
      case 'onUserAudioStop':
        onUserAudioStop?.call(data[0]);
        break;
      case 'onUserAudioSubscribe':
        onUserAudioSubscribe?.call(
            data[0], SubscribeResultConverter.fromValue(data[1]).e);
        break;
      case 'onUserVideoStart':
        onUserVideoStart?.call(
            data[0], VideoProfileTypeConverter.fromValue(data[1]).e);
        break;
      case 'onUserVideoStop':
        onUserVideoStop?.call(data[0]);
        break;
      case 'onUserVideoSubscribe':
        onUserVideoSubscribe?.call(
            data[0], SubscribeResultConverter.fromValue(data[1]).e);
        break;
      case 'onUserAudioMute':
        onUserAudioMute?.call(data[0]);
        break;
      case 'onUserAudioUnmute':
        onUserAudioUnmute?.call(data[0]);
        break;
      case 'onUserVideoMute':
        onUserVideoMute?.call(data[0]);
        break;
      case 'onUserVideoUnmute':
        onUserVideoUnmute?.call(data[0]);
        break;
      case 'onUserScreenStart':
        onUserScreenStart?.call(data[0]);
        break;
      case 'onUserScreenStop':
        onUserScreenStop?.call(data[0]);
        break;
      case 'onUserScreenSubscribe':
        onUserScreenSubscribe?.call(
            data[0], SubscribeResultConverter.fromValue(data[1]).e);
        break;
      case 'onUserScreenMute':
        onUserScreenMute?.call(data[0]);
        break;
      case 'onUserScreenUnmute':
        onUserScreenUnmute?.call(data[0]);
        break;
      case 'onWhiteboardAvailable':
        onWhiteboardAvailable?.call();
        break;
      case 'onWhiteboardUnavailable':
        onWhiteboardUnavailable?.call();
        break;
      case 'onWhiteboardStart':
        onWhiteboardStart?.call();
        break;
      case 'onWhiteboardStop':
        onWhiteboardStop?.call();
        break;
      case 'onWhiteboardStartWithId':
        onWhiteboardStartWithId?.call(data[0]);
        break;
      case 'onWhiteboardStopWithId':
        onWhiteboardStopWithId?.call(data[0]);
        break;
      case 'onFirstAudioDataReceived':
        onFirstAudioDataReceived?.call(data[0]);
        break;
      case 'onFirstVideoDataReceived':
        onFirstVideoDataReceived?.call(data[0]);
        break;
      case 'onFirstScreenDataReceived':
        onFirstScreenDataReceived?.call(data[0]);
        break;
      case 'onFirstVideoFrameRendered':
        onFirstVideoFrameRendered?.call(data[0]);
        break;
      case 'onFirstScreenFrameRendered':
        onFirstScreenFrameRendered?.call(data[0]);
        break;
      case 'onVideoCaptureStateChanged':
        onVideoCaptureStateChanged?.call(
            data[0], VideoCaptureStateConverter.fromValue(data[1]).e);
        break;
      case 'onAudioStartResult':
        onAudioStartResult?.call(ResultCodeConverter.fromValue(data[0]).e);
        break;
      case 'onVideoStartResult':
        onVideoStartResult?.call(ResultCodeConverter.fromValue(data[0]).e);
        break;
      case 'onScreenStartResult':
        onScreenStartResult?.call(ResultCodeConverter.fromValue(data[0]).e);
        break;
      case 'onScreenCaptureStateChanged':
        onScreenCaptureStateChanged?.call(
            ScreenCaptureStateConverter.fromValue(data[1]).e,
            ResultCodeConverter.fromValue(data[0]).e);
        break;
      case 'onChannelFailover':
        onChannelFailover?.call(FailoverStateConverter.fromValue(data[0]).e);
        break;
      case 'onActiveSpeakerListUpdated':
        onActiveSpeakerListUpdated?.call(data[0].cast<String>());
        break;
      case 'onAudioMixingStateChanged':
        onAudioMixingStateChanged?.call(
            data[0], AudioMixingStateConverter.fromValue(data[1]).e);
        break;
      case 'onVideoSnapshotCompleted':
        onVideoSnapshotCompleted?.call(data[0], data[1], data[2]);
        break;
      case 'onNetworkQuality':
        onNetworkQuality?.call(
            data[0], QualityRatingConverter.fromValue(data[1]).e);
        break;
      case 'onUserAudioLevel':
        onUserAudioLevel
            ?.call(RtcAudioLevel.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'onVideoSendStats':
        onVideoSendStats?.call(
            RtcVideoSendStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'onVideoRecvStats':
        onVideoRecvStats?.call(
            RtcVideoRecvStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'onAudioSendStats':
        onAudioSendStats?.call(
            RtcAudioSendStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'onAudioRecvStats':
        onAudioRecvStats?.call(
            RtcAudioRecvStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'onScreenSendStats':
        onScreenSendStats?.call(
            RtcVideoSendStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'onScreenRecvStats':
        onScreenRecvStats?.call(
            RtcVideoRecvStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'onVideoSendBweStats':
        onVideoSendBweStats?.call(
            RtcVideoSendBweStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'onVideoRecvBweStats':
        onVideoRecvBweStats?.call(
            RtcVideoRecvBweStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'onSystemStats':
        onSystemStats
            ?.call(RtcSystemStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
    }
  }
}

//Whiteboard
typedef FileIdCallback = void Function(ResultCode? result, String fileId);
typedef OnPageNumberChanged = void Function(int curPage, int totalPages);
typedef OnImageStateChanged = void Function(String url, WBImageState? status);
typedef OnViewScaleChanged = void Function(double scale);
typedef OnRoleTypeChanged = void Function(WBRoleType? newRole);
typedef OnMessage = void Function(String userId, Uint8List byte);
typedef OnDocTranscodeStatus = void Function(
    ResultCode? result, String fileId, int progress, int totalPages);
typedef OnSaveDoc = void Function(
    ResultCode? result, String fileId, String outputDir);
typedef OnDocThumbnailReady = void Function(String fileId, List<String>? urls);
typedef OnUserJoined = void Function(String userId, String userName);

/// Callback of RtcWhiteboard,  the callback must set to RtcWhiteboard to get events notification.
///
/// RtcWhiteboard 的回调函数， 在使用 RtcWhiteboard 之前必须要设置回调以获取事件通知。
class WhiteboardEventHandler {
  /// Notification of whiteboard data synced
  ///
  ///白板数据同步完成通知
  EmptyCallback? onStatusSynced;

  /// Notification of page number changed
  ///
  /// **Parameter** [curPage] new page number.
  ///
  ///白板页码变化通知
  ///
  /// **Parameter** [curPage] 新当前页码
  OnPageNumberChanged? onPageNumberChanged;

  /// Notification of image state changed
  ///
  /// **Parameter** [pageNo] page number.
  ///
  /// **Parameter** [url] image url.
  ///
  /// **Parameter** [state] image state.
  ///
  ///图片状态变化通知
  ///
  /// **Parameter** [pageNo] 页码。
  ///
  /// **Parameter** [url] 图片 URL。
  ///
  /// **Parameter** [state] 图片状态码。
  OnImageStateChanged? onImageStateChanged;

  /// Notification of whiteboard view scale factor changed
  ///
  /// **Parameter** [scale] The scale factor.
  ///
  ///白板视图缩放比例变化通知
  ///
  /// **Parameter** [scale] 缩放比例。
  OnViewScaleChanged? onViewScaleChanged;

  /// Notification of whiteboard role type changed
  ///
  /// **Parameter** [newRole] The new role type.
  ///
  ///白板角色类型变化通知
  ///
  /// **Parameter** [newRole] 新角色。
  OnRoleTypeChanged? onRoleTypeChanged;

  /// Notification of whiteboard content update
  ///
  ///白板内容更新通知
  EmptyCallback? onContentUpdated;

  /// Notification of whiteboard snapshot complete
  ///
  /// **Parameter** [result] Snapshot result
  ///
  /// **Parameter** [filename] Snapshot image full path with name.
  ///
  ///白板快照完成通知
  ///
  /// **Parameter** [result] 快照结果
  ///
  /// **Parameter** [filename] 快照文件名
  OnSnapshotComplete? onSnapshotComplete;

  /// Notification of message
  ///
  /// **Parameter** [userId] The user who send the message
  ///
  ///消息通知
  ///
  /// **Parameter** [userId] 消息发送者 ID
  OnMessage? onMessage;

  /// Notification of add background images
  ///
  /// **Parameter** [result] Notification result
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// 添加一组背景图结果通知
  ///
  /// **Parameter** [result] 通知结果
  ///
  /// **Parameter** [fileId] 白板文件ID
  FileIdCallback? onAddBackgroundImages;

  /// Notification of add H5 file
  ///
  /// **Parameter** [result] Notification result
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// 添加H5文件结果通知
  ///
  /// **Parameter** [result] 通知结果
  ///
  /// **Parameter** [fileId] 白板文件ID
  FileIdCallback? onAddH5File;

  /// Notification of doc transcode status
  ///
  /// **Parameter** [result] Notification result
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// **Parameter** [progress] Transcode progress
  ///
  /// **Parameter** [totalPage] Transcode total page number
  ///
  /// 文档转码状态通知
  ///
  /// **Parameter** [result] 通知结果
  ///
  /// **Parameter** [fileId] 白板文件ID
  ///
  /// **Parameter** [progress] 转码进度
  ///
  /// **Parameter** [totalPage] 转码总页数
  OnDocTranscodeStatus? onDocTranscodeStatus;

  /// Notification of create whiteboard file
  ///
  /// **Parameter** [result] Notification result
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// 创建白板文件通知
  ///
  /// **Parameter** [result] 通知结果
  ///
  /// **Parameter** [fileId] 白板文件ID
  FileIdCallback? onCreateDoc;

  /// Notification of delete whiteboard file
  ///
  /// **Parameter** [result] Notification result
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// 删除白板文件通知
  ///
  /// **Parameter** [result] 通知结果
  ///
  /// **Parameter** [fileId] 白板文件ID
  FileIdCallback? onDeleteDoc;

  /// Notification of switch whiteboard file
  ///
  /// **Parameter** [result] Notification result
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// 切换白板文件通知
  ///
  /// **Parameter** [result] 通知结果
  ///
  /// **Parameter** [fileId] 白板文件ID
  FileIdCallback? onSwitchDoc;

  /// Notification of save whiteboard file
  ///
  /// **Parameter** [result] Notification result
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// **Parameter** [outputDir] Output directory
  ///
  /// 保存白板文件通知
  ///
  /// **Parameter** [result] 通知结果
  ///
  /// **Parameter** [fileId] 白板文件ID
  ///
  /// **Parameter** [outputDir] 输出路径
  OnSaveDoc? onSaveDoc;

  /// Notification of whiteboard file thumbnail ready
  ///
  /// **Parameter** [fileId] Whiteboard file ID
  ///
  /// **Parameter** [urls] thumbnail url array
  ///
  /// 白板文件缩略图完成通知
  ///
  /// **Parameter** [fileId] 白板文件ID
  ///
  /// **Parameter** [urls] 缩略图url数组
  OnDocThumbnailReady? onDocThumbnailReady;

  /// Notification of vision share started
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 视角共享开始通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onVisionShareStarted;

  /// Notification of vision share stopped
  ///
  /// **Parameter** [userId] user ID
  ///
  /// 视角共享结束通知
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onVisionShareStopped;

  /// Notification of attendee join
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [userName] user name, can be empty string.
  ///
  /// 人员的加入通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [userName] 用户名字， 可能为空字符串
  OnUserJoined? onUserJoined;

  /// Notification of attendee leave
  ///
  /// **Parameter** [userId] user ID
  ///
  ///人员离开通知。
  ///
  /// **Parameter** [userId] 用户ID。
  UserIdCallback? onUserLeft;

  /// Constructs a [WhiteboardEventHandler]
  WhiteboardEventHandler(
      {this.onStatusSynced,
      this.onPageNumberChanged,
      this.onImageStateChanged,
      this.onViewScaleChanged,
      this.onRoleTypeChanged,
      this.onContentUpdated,
      this.onSnapshotComplete,
      this.onMessage,
      this.onAddBackgroundImages,
      this.onAddH5File,
      this.onDocTranscodeStatus,
      this.onCreateDoc,
      this.onDeleteDoc,
      this.onSwitchDoc,
      this.onSaveDoc,
      this.onDocThumbnailReady,
      this.onVisionShareStarted,
      this.onVisionShareStopped,
      this.onUserJoined,
      this.onUserLeft});

  /// @nodoc
  void process(String? methodName, List<dynamic> data) {
    switch (methodName) {
      case 'onStatusSynced':
        onStatusSynced?.call();
        break;
      case 'onPageNumberChanged':
        onPageNumberChanged?.call(data[0], data[1]);
        break;
      case 'onImageStateChanged':
        onImageStateChanged?.call(
            data[0], WBImageStateConverter.fromValue(data[1]).e);
        break;
      case 'onViewScaleChanged':
        onViewScaleChanged?.call(data[0]);
        break;
      case 'onRoleTypeChanged':
        onRoleTypeChanged?.call(WBRoleTypeConverter.fromValue(data[0]).e);
        break;
      case 'onContentUpdated':
        onContentUpdated?.call();
        break;
      case 'onSnapshotComplete':
        onSnapshotComplete?.call(
            ResultCodeConverter.fromValue(data[0]).e, data[1]);
        break;
      case 'onMessage':
        onMessage?.call(data[0], data[1]);
        break;
      case 'onAddBackgroundImages':
        onAddBackgroundImages?.call(
            ResultCodeConverter.fromValue(data[0]).e, data[1]);
        break;
      case 'onAddH5File':
        onAddH5File?.call(ResultCodeConverter.fromValue(data[0]).e, data[1]);
        break;
      case 'onDocTranscodeStatus':
        onDocTranscodeStatus?.call(ResultCodeConverter.fromValue(data[0]).e,
            data[1], data[2], data[3]);
        break;
      case 'onCreateDoc':
        onCreateDoc?.call(ResultCodeConverter.fromValue(data[0]).e, data[1]);
        break;
      case 'onDeleteDoc':
        onDeleteDoc?.call(ResultCodeConverter.fromValue(data[0]).e, data[1]);
        break;
      case 'onSwitchDoc':
        onSwitchDoc?.call(ResultCodeConverter.fromValue(data[0]).e, data[1]);
        break;
      case 'onSaveDoc':
        onSaveDoc?.call(
            ResultCodeConverter.fromValue(data[0]).e, data[1], data[2]);
        break;
      case 'onDocThumbnailReady':
        onDocThumbnailReady!.call(data[0], data[1].cast<String>());
        break;
      case 'onVisionShareStarted':
        onVisionShareStarted!.call(data[0]);
        break;
      case 'onVisionShareStopped':
        onVisionShareStopped!.call(data[0]);
        break;
      case 'onUserJoined':
        onUserJoined?.call(data[0], data[1]);
        break;
      case 'onUserLeft':
        onUserLeft?.call(data[0]);
        break;
    }
  }
}

//AnnotationManager
typedef OnVideoAnnotationStart = void Function(String userId, int streamId);
typedef OnVideoAnnotationStop = void Function(String userId, int streamId);
typedef OnUserVideoMute = void Function(String userId, int streamId);

/// Annotation Manager
///
/// 标注管理器
class AnnotationMgrEventHandler {
  /// Notification of video annotation start
  ///
  /// **Parameter** [userId] User ID
  ///
  /// **Parameter** [streamId] Stream ID
  ///
  ///开始视频标注通知
  ///
  /// **Parameter** [userId] 用户ID
  ///
  /// **Parameter** [streamId] 视频流ID
  OnVideoAnnotationStart? onVideoAnnotationStart;

  /// Notification of video annotation stop
  ///
  /// **Parameter** [userId] User ID
  ///
  /// **Parameter** [streamId] Stream ID
  ///
  ///终止视频标注通知
  ///
  /// **Parameter** [userId] 用户ID
  ///
  /// **Parameter** [streamId] 视频流ID
  OnVideoAnnotationStop? onVideoAnnotationStop;

  /// Notification of share annotation start
  ///
  /// **Parameter** [userId] User ID
  ///
  ///开始共享标注通知
  ///
  /// **Parameter** [userId] 用户ID
  UserIdCallback? onShareAnnotationStart;

  /// Notification of share annotation stop
  ///
  /// **Parameter** [userId] User ID
  ///
  ///终止共享标注通知
  ///
  /// **Parameter** [userId] 用户ID
  UserIdCallback? onShareAnnotationStop;

  /// Constructs a [AnnotationMgrEventHandler]
  AnnotationMgrEventHandler(
      {this.onVideoAnnotationStart,
      this.onVideoAnnotationStop,
      this.onShareAnnotationStart,
      this.onShareAnnotationStop});

  /// @nodoc
  void process(String? methodName, List<dynamic> data) {
    switch (methodName) {
      case 'onVideoAnnotationStart':
        onVideoAnnotationStart?.call(data[0], data[1]);
        break;
      case 'onVideoAnnotationStop':
        onVideoAnnotationStop?.call(data[0], data[1]);
        break;
      case 'onShareAnnotationStart':
        onShareAnnotationStart?.call(data[0]);
        break;
      case 'onShareAnnotationStop':
        onShareAnnotationStop?.call(data[0]);
        break;
    }
  }
}

typedef OnAnnoRoleChanged = void Function(WBRoleType? newRole);
typedef OnSnapshotComplete = void Function(ResultCode? result, String filename);

/// Callback of PanoAnnotation,  the callback must set to PanoAnnotation to get events notification.
///
/// PanoAnnotation 的回调函数， 在使用 PanoAnnotation 之前必须要设置回调以获取事件通知。
class AnnotationEventHandler {
  /// Notification of annotation role type changed
  ///
  /// **Parameter** [newRole] The new role type.
  ///
  ///标注角色类型变化通知
  ///
  /// **Parameter** [newRole] 新角色。
  OnAnnoRoleChanged? onAnnoRoleChanged;

  /// Notification of annotation snapshot complete
  ///
  /// **Parameter** [result] Snapshot result
  ///
  /// **Parameter** [filename] Snapshot image full path with name.
  ///
  ///标注快照完成通知
  ///
  /// **Parameter** [result] 快照结果
  ///
  /// **Parameter** [filename] 快照文件名
  OnSnapshotComplete? onSnapshotComplete;

  /// Constructs a [AnnotationEventHandler]
  AnnotationEventHandler({this.onAnnoRoleChanged, this.onSnapshotComplete});

  /// @nodoc
  void process(String? methodName, List<dynamic> data) {
    switch (methodName) {
      case 'onAnnoRoleChanged':
        onAnnoRoleChanged?.call(WBRoleTypeConverter.fromValue(data[0]).e);
        break;
      case 'onSnapshotComplete':
        onSnapshotComplete?.call(
            ResultCodeConverter.fromValue(data[0]).e, data[1]);
        break;
    }
  }
}

//VideoStreamManager
typedef UserStreamCallback = void Function(String userId, int streamId);
typedef OnUserVideoStreamStart = void Function(
    String userId, int streamId, VideoProfileType? maxProfile);
typedef OnUserVideoStreamSubscribe = void Function(
    String userId, int streamId, SubscribeResult? result);
typedef OnVideoStreamSnapshotCompleted = void Function(
    String userId, int streamId, bool succeed, String filename);
typedef OnVideoStreamCaptureStateChanged = void Function(
    int streamId, String deviceId, VideoCaptureState? state);

/// Callback of VideoStreamManager, the callback must be set to stream manager to get events notification.
///
/// VideoStreamManager 的回调函数， 在使用 VideoStreamManager 之前必须要设置回调以获取事件通知。
class VideoStreamEventHandler {
  /// Notification of attendee start video stream
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [streamId] video stream ID
  ///
  /// **Parameter** [maxProfile] user video profile
  ///
  ///用户开启视频流通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  ///
  /// **Parameter** [maxProfile] 用户视频能力
  OnUserVideoStreamStart? onUserVideoStreamStart;

  /// Notification of attendee stop video stream
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [streamId] video stream ID
  ///
  ///用户关闭视频流通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  UserStreamCallback? onUserVideoStreamStop;

  /// Notification of result to subscribe user video stream
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [streamId] video stream ID
  ///
  /// **Parameter** [result] the result of subscribing
  ///
  ///用户视频流订阅结果通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  ///
  /// **Parameter** [result] 订阅结果。
  OnUserVideoStreamSubscribe? onUserVideoStreamSubscribe;

  /// Notification of attendee mute video stream
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [streamId] video stream ID
  ///
  ///用户暂停视频流通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  UserStreamCallback? onUserVideoMute;

  /// Notification of attendee unmute video stream
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [streamId] video stream ID
  ///
  ///用户恢复视频流通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  UserStreamCallback? onUserVideoUnmute;

  /// Notification of first video packet arrived
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [streamId] video stream ID
  ///
  ///第一个视频包到达通知
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  UserStreamCallback? onFirstVideoDataReceived;

  /// Notification of first video frame will be rendered.
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [streamId] video stream ID
  ///
  ///第一个视频帧渲染通知。
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  UserStreamCallback? onFirstVideoFrameRendered;

  /// Notification of first video frame will be rendered.
  ///
  /// **Parameter** [userId] user ID
  ///
  /// **Parameter** [streamId] video stream ID
  ///
  ///第一个视频帧渲染通知。
  ///
  /// **Parameter** [userId] 用户ID。
  ///
  /// **Parameter** [streamId] 视频流 ID。
  OnVideoStreamSnapshotCompleted? onVideoStreamSnapshotCompleted;

  /// Notification of user's video snapshot completed
  ///
  /// **Parameter** [userId] The userId of snapshot source
  ///
  /// **Parameter** [streamId] The video stream ID
  ///
  /// **Parameter** [succeed] Succeed to write the image.
  ///
  /// **Parameter** [filename] The snapshot image full path with name.
  ///
  ///用户视频快照完成通知
  ///
  /// **Parameter** [userId] 快照所属的用户ID
  ///
  /// **Parameter** [streamId] 视频流 ID。
  ///
  /// **Parameter** [succeed] 是否成功写入文件
  ///
  /// **Parameter** [filename] 快照文件完整路径
  OnVideoStreamCaptureStateChanged? onVideoCaptureStateChanged;

  /// Constructs a [VideoStreamEventHandler]
  VideoStreamEventHandler(
      {this.onUserVideoStreamStart,
      this.onUserVideoStreamStop,
      this.onUserVideoStreamSubscribe,
      this.onUserVideoMute,
      this.onUserVideoUnmute,
      this.onFirstVideoDataReceived,
      this.onFirstVideoFrameRendered,
      this.onVideoStreamSnapshotCompleted,
      this.onVideoCaptureStateChanged});

  /// @nodoc
  void process(String? methodName, List<dynamic> data) {
    switch (methodName) {
      case 'onUserVideoStreamStart':
        onUserVideoStreamStart?.call(
            data[0], data[1], VideoProfileTypeConverter.fromValue(data[2]).e);
        break;
      case 'onUserVideoStreamStop':
        onUserVideoStreamStop?.call(data[0], data[1]);
        break;
      case 'onUserVideoStreamSubscribe':
        onUserVideoStreamSubscribe?.call(
            data[0], data[1], SubscribeResultConverter.fromValue(data[2]).e);
        break;
      case 'onUserVideoMute':
        onUserVideoMute?.call(data[0], data[1]);
        break;
      case 'onUserVideoUnmute':
        onUserVideoUnmute?.call(data[0], data[1]);
        break;
      case 'onFirstVideoDataReceived':
        onFirstVideoDataReceived?.call(data[0], data[1]);
        break;
      case 'onFirstVideoFrameRendered':
        onFirstVideoFrameRendered?.call(data[0], data[1]);
        break;
      case 'onVideoStreamSnapshotCompleted':
        onVideoStreamSnapshotCompleted?.call(
            data[0], data[1], data[2], data[3]);
        break;
      case 'onVideoCaptureStateChanged':
        onVideoCaptureStateChanged?.call(
            data[0], data[1], VideoCaptureStateConverter.fromValue(data[2]).e);
        break;
    }
  }
}

typedef OnNetworkTestComplete = void Function(RtcNetworkQuality quality);

/// Callback of RtcNetworkManager, the callback must be set to network manager to get events notification.
///
/// RtcNetworkManager 的回调函数， 在使用 RtcNetworkManager 之前必须要设置回调以获取事件通知。
class RtcNetworkMgrHandler {
  /// Callback the result of network test.
  ///
  /// **Parameter** [quality] Network quality report
  ///
  /// 回调网络检测的结果。
  ///
  /// **Parameter** [quality] 网络质量报告
  OnNetworkTestComplete? onNetworkTestComplete;

  /// Constructs a [RtcNetworkMgrHandler]
  RtcNetworkMgrHandler({this.onNetworkTestComplete});

  /// @nodoc
  void process(String? methodName, List<dynamic> data) {
    switch (methodName) {
      case 'onNetworkTestComplete':
        onNetworkTestComplete?.call(
            RtcNetworkQuality.fromJson(Map<String, dynamic>.from(data[0])));
        break;
    }
  }
}

typedef OnServiceStateChanged = void Function(MessageServiceState? state);
typedef OnUserMessage = void Function(String userId, Uint8List byte);
typedef OnSubscribeResult = void Function(String topic, ResultCode? result);
typedef OnTopicMessage = void Function(String topic, String userId, Uint8List data);
typedef OnPropertyChanged = void Function(List<RtcPropertyAction> props);

/// Callback of RtcMessageService, the callback must be set to RtcMessageService to get events notification.
///
/// RtcMessageService 的回调函数， 在使用 RtcMessageService 之前必须要设置回调以获取事件通知。
class RtcMessageServiceHandler {
  /// Notification of message service state change.
  /// **Parameter** [state] The service state, You can send message when state is [MessageServiceState.Available].
  /// **Parameter** [reason] The reason of the state change.
  ///
  /// **Note**
  /// Send the message when the callback service status is available, otherwise
  /// sending a message when the service is unavailable may cause the message to
  /// be lost.
  /// The status callback will return immediately after joining the channel.
  /// It is recommended to set a callback before joining the channel to ensure
  /// that the service status is correctly obtained.
  ///
  /// 消息服务状态变更的通知。
  /// **Parameter** [state] 服务状态，[MessageServiceState.Available] 时可以发送消息。
  /// **Parameter** [reason] 状态变更的原因。
  ///
  /// **Note**
  /// 当回调服务状态可用后再发送消息，否则当服务不可用时发送消息可能造成消息丢失。
  /// 状态回调会在加入频道后立即返回，建议在加入频道前设置回调，以确保正确获取服务状态。
  OnServiceStateChanged? onServiceStateChanged;

  /// Notification of user message.
  /// **Parameter** [userId] The user who sent the message.
  /// **Parameter** [data] The message data.
  ///
  /// 用户消息通知。
  /// **Parameter** [userId] 发送消息的用户标识。
  /// **Parameter** [data]  消息数据。
  OnUserMessage? onUserMessage;

  /// Notification of topic subscribe result.
  /// **Parameter** [topic] The topic.
  /// **Parameter** [result] The result of topic subscription.
  ///
  /// 主题消息订阅成功与否的通知。
  /// **Parameter** [topic] 主题标识。
  /// **Parameter** [result] 主题订阅的结果。
  OnSubscribeResult? onSubscribeResult;

  /// Notification of topic message.
  /// **Parameter** [topic] The topic.
  /// **Parameter** [userId] The user who published the message.
  /// **Parameter** [data] The topic data.
  ///
  /// 用户主题消息通知。
  /// **Parameter** [topic] 主题标识。
  /// **Parameter** [userId] 发布主题消息的用户标识。
  /// **Parameter** [data] 主题消息数据。
  OnTopicMessage? onTopicMessage;

  /// Notification of message service property change.
  /// **Parameter** [props] The property action array.
  ///
  /// 消息服务属性变更通知。
  /// **Parameter** [props] 变更属性的数组。
  OnPropertyChanged? onPropertyChanged;

  /// Constructs a [RtcMessageServiceHandler]
  RtcMessageServiceHandler({
    this.onServiceStateChanged,
    this.onUserMessage,
    this.onSubscribeResult,
    this.onTopicMessage,
    this.onPropertyChanged
  });

  /// @nodoc
  void process(String? methodName, List<dynamic> data) {
    switch (methodName) {
      case 'onServiceStateChanged':
        onServiceStateChanged
            ?.call(MessageServiceStateConverter.fromValue(data[0]).e);
        break;
      case 'onUserMessage':
        onUserMessage?.call(data[0], data[1]);
        break;
      case 'onSubscribeResult':
        onSubscribeResult?.call(data[0], ResultCodeConverter.fromValue(data[1]).e);
        break;
      case 'onTopicMessage':
        onTopicMessage?.call(data[0], data[1], data[2]);
        break;
      case 'onPropertyChanged':
        var props = <RtcPropertyAction>[];
        var propList = data[0] as List<dynamic>;
        propList.forEach((element) {
          var actionType = ActionTypeConverter.fromValue(element['actionType']).e;
          var propName = element['propName'];
          var propValue = element['propValue'];
          props.add(RtcPropertyAction(actionType, propName, propValue));
        });
        onPropertyChanged?.call(props);
        break;
    }
  }
}

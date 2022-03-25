import 'package:json_annotation/json_annotation.dart';

import 'rtc_enums.dart';

part 'rtc_objects.g.dart';

/// The configurations class of the PanoRtcEngineKit object.
///
/// PanoRtcEngineKit 对象的配置类。
@JsonSerializable(explicitToJson: true)
class RtcEngineConfig {
  /// The application ID applied from PANO.
  ///
  /// 从PANO申请的应用标识。
  String appId;

  /// The PANO server address. Format: <"domain name">[:port].
  ///
  /// PANO服务器地址。格式：<"域名">[:端口]
  String rtcServer;

  /// Whether the video codec is enabled for hardware acceleration. Default: NO.
  ///
  /// 视频编解码器是否启用硬件加速。默认值：否。
  bool? videoCodecHwAcceleration;

  /// The audio Scenario. Default: 0(voip).
  ///
  /// 音频场景。默认值：0(voip)
  int? audioScenario;

  /// Constructs a [RtcEngineConfig]
  RtcEngineConfig(this.appId,
      {this.rtcServer = '',
      this.videoCodecHwAcceleration = false,
      this.audioScenario = 0});

  /// @nodoc
  factory RtcEngineConfig.fromJson(Map<String, dynamic> json) =>
      _$RtcEngineConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcEngineConfigToJson(this);
}

/// The configurations class for joinning a channel.
///
/// 用于加入频道的配置类。
@JsonSerializable(explicitToJson: true)
class RtcChannelConfig {
  /// Channel working mode. Default: ChannelMode.OneOnOne.
  ///
  /// 频道工作模式。默认值：ChannelMode.OneOnOne。
  ChannelMode? mode;

  /// Channel service serviceFlags. Default: ChannelService.Media | ChannelService.Whiteboard | ChannelService.Message.
  ///
  /// 频道服务标志。默认值：ChannelService.Media | ChannelService.Whiteboard | ChannelService.Message
  Set<ChannelService?>? serviceFlags;

  /// Whether to subscribe audio automatically. Default: YES.
  ///
  /// 是否自动订阅所有音频。默认值：是。
  bool? subscribeAudioAll;

  /// The user display name. It must compliance with the following rules:
  /// - max length is 128 bytes.
  /// - UTF8 string.
  ///
  /// 用户显示名字。必须符合以下规则:
  /// - 最大长度是128字节；
  /// - UTF8 字符串。*/
  String? userName;

  /// Constructs a [RtcChannelConfig]
  RtcChannelConfig(
      {this.mode = ChannelMode.OneOnOne,
      this.serviceFlags = const {
        ChannelService.Media,
        ChannelService.Whiteboard,
        ChannelService.Message
      },
      this.subscribeAudioAll = true,
      this.userName});

  /// @nodoc
  factory RtcChannelConfig.fromJson(Map<String, dynamic> json) =>
      _$RtcChannelConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcChannelConfigToJson(this);
}

/// The configurations class of the video renderer.
///
/// 视频渲染器的配置类。
@JsonSerializable(explicitToJson: true)
class RtcVideoConfig {
  /// The video profile. Default: Standard.
  ///
  /// 视频设定档。默认值：Standard。
  VideoProfileType? profileType;

  /// Enable Video Source Mirror. Default: NO
  ///
  ///  启用视频源镜像, 默认值: NO。*/
  bool? sourceMirror;

  /// The video scaling mode. Default: kPanoScalingFit.
  ///
  /// 视频缩放模式。默认值：kPanoScalingFit。
  VideoScalingMode? scalingMode;

  /// Whether to enable video mirroring. Default: NO.
  ///
  /// 是否启用视频镜像。默认值：NO。
  bool? mirror;

  /// Constructs a [RtcVideoConfig]
  RtcVideoConfig(
      {this.profileType = VideoProfileType.Standard,
      this.sourceMirror = false,
      this.scalingMode = VideoScalingMode.Fit,
      this.mirror = false});

  /// @nodoc
  factory RtcVideoConfig.fromJson(Map<String, dynamic> json) =>
      _$RtcVideoConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcVideoConfigToJson(this);
}

/// The audio format class.
///
/// 音频格式类。
@JsonSerializable(explicitToJson: true)
class RtcAudioFormat {
  /// The audio type. Default: kPanoPCM.
  ///
  /// 音频类型。默认值：kPanoPCM。
  final AudioType? type;

  /// The number of audio channels.
  ///
  /// 音频通道数。
  final int? channels;

  /// The audio sample rate.
  ///
  /// 音频采样率。
  final int? sampleRate;

  /// The bytes per audio frame.
  ///
  /// 音频每帧的字节数。
  final int? bytesPerSample;

  /// Constructs a [RtcAudioFormat]
  RtcAudioFormat(
      {this.type = AudioType.PCM,
      this.channels = 0,
      this.sampleRate = 0,
      this.bytesPerSample = 0});

  /// @nodoc
  factory RtcAudioFormat.fromJson(Map<String, dynamic> json) =>
      _$RtcAudioFormatFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcAudioFormatToJson(this);
}

/// The video format class.
///
/// 视频格式类。
@JsonSerializable(explicitToJson: true)
class RtcVideoFormat {
  /// The video type. Default: kPanoI420.
  ///
  /// 视频类型。默认值：kPanoI420。
  final VideoType? type;

  /// The video width.
  ///
  /// 视频宽度。
  final int? width;

  /// The video height.
  ///
  /// 视频高度。
  final int? height;

  /// The count of video block array.
  ///
  /// **Note**
  /// If the video type is kPanoI420, the count should be 3.
  ///
  /// 视频块数组的项目数。
  ///
  /// **Note**
  /// 如果视频类型为kPanoI420，则计数应为3。
  final int? count;

  /// The video block offset array. Item type: UInt32.
  ///
  /// **Note**
  /// The offsets are for the first address of the video block.
  ///
  /// 视频块偏移量数组。项目类型：UInt32。
  ///
  /// **Note**
  /// 偏移量都是针对视频块首地址的。
  final List<int> offset;

  /// The video block stride array. Item type: UInt32.
  ///
  /// 视频块步幅数组。项目类型：UInt32。
  final List<int> stride;

  /// The video rotation degrees. Default: kPanoRotation0.
  ///
  /// 视频旋转角度。默认值：kPanoRotation0。
  final VideoRotation? rotation;

  /// Constructs a [RtcVideoFormat]
  RtcVideoFormat(this.offset, this.stride,
      {this.type = VideoType.I420,
      this.width = 0,
      this.height = 0,
      this.count = 0,
      this.rotation = VideoRotation.Rotation0});

  /// @nodoc
  factory RtcVideoFormat.fromJson(Map<String, dynamic> json) =>
      _$RtcVideoFormatFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcVideoFormatToJson(this);
}

/// The statistics class of user audio level.
///
/// 音频接收统计类。
@JsonSerializable(explicitToJson: true)
class RtcAudioLevel {
  ///
  /// The user ID of received audio.
  ///
  /// **Note**
  /// The propertie is the user of the audio that has been subscribed.
  ///
  /// 音频接收用户标识。
  ///
  /// **Note**
  /// 此属性是已被订阅音频的用户。
  final String userId;

  /// The audio output strength level. Valid value ranges between 0 and 32768.
  ///
  /// **Note**
  /// The propertie is the instantaneous value when callbacking statistics.
  ///
  /// 音频输出强度级别。有效值范围0到32768。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时值。
  final int? level;

  /// The audio active flag.
  ///
  /// **Note**
  /// The propertie is the instantaneous flag when callbacking statistics.
  ///
  /// 音频活跃标志。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时音频活跃标志。
  final bool? active;

  /// Constructs a [RtcAudioLevel]
  RtcAudioLevel(this.userId, {this.level = 0, this.active = false});

  /// @nodoc
  factory RtcAudioLevel.fromJson(Map<String, dynamic> json) =>
      _$RtcAudioLevelFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcAudioLevelToJson(this);
}

/// Audio profile.
///
/// 音频配置。
@JsonSerializable(explicitToJson: true)
class RtcAudioProfile {
  ///
  /// The audio sample rate.
  ///
  /// 音频采样率。*/
  final AudioSampleRate? sampleRate;

  /// The audio channel.
  ///
  /// 音频通道数。*/
  final AudioChannel? channel;

  /// The audio codec sending bitrate per channel (32000bps-320000bps, defualt:64000bps).
  ///
  /// 音频发送码率(32000bps-320000bps, 默认:64000bps)。
  final int? encodeBitrate;

  /// Constructs a [RtcAudioProfile]
  RtcAudioProfile(
      {this.sampleRate = AudioSampleRate.Rate48K,
      this.channel = AudioChannel.Mono,
      this.encodeBitrate = 64000});

  /// @nodoc
  factory RtcAudioProfile.fromJson(Map<String, dynamic> json) =>
      _$RtcAudioProfileFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcAudioProfileToJson(this);
}

/// The statistics class of sent audio.
///
/// 音频发送统计类。
@JsonSerializable(explicitToJson: true)
class RtcAudioSendStats {
  ///
  /// The audio sent bytes.
  ///
  /// **Note**
  /// The propertie is the total bytes after the audio is started.
  ///
  /// 音频发送字节数。
  ///
  /// **Note**
  /// 此属性是音频开启之后的累计字节。
  final int bytesSent;

  /// The audio sent bitrate. Unit: bps.
  ///
  /// **Note**
  /// The propertie is the instantaneous bitrate when callbacking statistics.
  ///
  /// 音频发送比特率。单位：比特每秒。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时比特率。
  final int sendBitrate;

  /// The numnber of audio sent lost packets.
  ///
  /// **Note**
  /// The propertie is the total packets after the audio is started.
  ///
  /// 音频发送丢包数。
  ///
  /// **Note**
  /// 此属性是音频开启之后的累计包数。
  final int packetsLost;

  /// The audio sent loss ratio.
  ///
  /// **Note**
  /// The propertie is the instantaneous ratio when callbacking statistics.
  ///
  /// 音频发送丢包率。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时比率。
  final double lossRatio;

  /// The audio round-trip time.
  ///
  /// **Note**
  /// The propertie is the recent RTT value when callbacking statistics.
  ///
  /// 音频往返时延。
  ///
  /// **Note**
  /// 此属性是回调统计时的最近往返时延值。
  final int rtt;

  /// The audio input strength level. Valid value ranges between 0 and 32767.
  ///
  /// **Note**
  /// The propertie is the instantaneous value when callbacking statistics.
  ///
  /// 音频输入强度级别。有效值范围0到32767。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时值。
  final int inputLevel;

  /// The local audio input active detection
  ///
  /// **Note**
  /// The propertie is the instantaneous value when callbacking statistics.
  ///
  /// 本地用户(麦克风采集)说话检测。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时值。
  final bool inputActiveFlag; //  true: active, false: inactive

  ///
  /// The type of audio codec.
  ///
  /// **Note**
  /// The propertie is the dynamic value during audio sending.
  ///
  /// 音频编码器类型。
  ///
  /// **Note**
  /// 此属性是在音频发送期间是个动态值。
  final AudioCodecType codecType;

  /// Constructs a [RtcAudioSendStats]
  RtcAudioSendStats(
      this.bytesSent,
      this.sendBitrate,
      this.packetsLost,
      this.lossRatio,
      this.rtt,
      this.inputLevel,
      this.inputActiveFlag,
      this.codecType);

  /// @nodoc
  factory RtcAudioSendStats.fromJson(Map<String, dynamic> json) =>
      _$RtcAudioSendStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcAudioSendStatsToJson(this);
}

/// The statistics class of received audio.
///
/// 音频接收统计类。
@JsonSerializable(explicitToJson: true)
class RtcAudioRecvStats {
  ///
  /// The user ID of received audio.
  ///
  /// **Note**
  /// The propertie is the user of the audio that has been subscribed.
  ///
  /// 音频接收用户标识。
  ///
  /// **Note**
  /// 此属性是已被订阅音频的用户。
  final String userId;

  /// The audio received bytes.
  ///
  /// **Note**
  /// The propertie is the total bytes after the audio is subscribed.
  ///
  /// 音频接收字节数。
  ///
  /// **Note**
  /// 此属性是音频订阅之后的累计字节。
  final int bytesRecv;

  /// The audio received bitrate. Unit: bps.
  ///
  /// **Note**
  /// The propertie is the instantaneous bitrate when callbacking statistics.
  ///
  /// 音频接收比特率。单位：比特每秒。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时比特率。
  final int recvBitrate;

  /// The numnber of audio received lost packets.
  ///
  /// **Note**
  /// The propertie is the total packets after the audio is subscribed.
  ///
  /// 音频接收丢包数。
  ///
  /// **Note**
  /// 此属性是音频订阅之后的累计包数。
  final int packetsLost;

  /// The audio received loss ratio.
  ///
  /// **Note**
  /// The propertie is the instantaneous ratio when callbacking statistics.
  ///
  /// 音频接收丢包率。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时比率。
  final double lossRatio;

  /// The audio output strength level. Valid value ranges between 0 and 32767.
  ///
  /// **Note**
  /// The propertie is the instantaneous value when callbacking statistics.
  ///
  /// 音频输出强度级别。有效值范围0到32767。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时值。
  final int outputLevel;

  /// The type of audio codec.
  ///
  /// **Note**
  /// The propertie is the dynamic value during audio receiving.
  ///
  /// 音频解码器类型。
  ///
  /// **Note**
  /// 此属性是在音频接收期间是个动态值。
  final AudioCodecType codecType;

  /// Constructs a [RtcAudioRecvStats]
  RtcAudioRecvStats(this.userId, this.bytesRecv, this.recvBitrate,
      this.packetsLost, this.lossRatio, this.outputLevel, this.codecType);

  /// @nodoc
  factory RtcAudioRecvStats.fromJson(Map<String, dynamic> json) =>
      _$RtcAudioRecvStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcAudioRecvStatsToJson(this);
}

/// The statistics class of sent video.
///
/// 视频发送统计类。
@JsonSerializable(explicitToJson: true)
class RtcVideoSendStats {
  ///
  /// The stream ID of received video.
  ///
  /// 视频流标识。*/
  final int streamId;

  /// The video sent bytes.
  ///
  /// **Note**
  /// The propertie is the total bytes after the video is started.
  ///
  /// 视频发送字节数。
  ///
  /// **Note**
  /// 此属性是视频开启之后的累计字节。
  final int bytesSent;

  /// The video sent bitrate. Unit: bps.
  ///
  /// **Note**
  /// The propertie is the instantaneous bitrate when callbacking statistics.
  ///
  /// 视频发送比特率。单位：比特每秒。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时比特率。
  final int sendBitrate;

  /// The numnber of video sent lost packets.
  ///
  /// **Note**
  /// The propertie is the total packets after the video is started.
  ///
  /// 视频发送丢包数。
  ///
  /// **Note**
  /// 此属性是视频开启之后的累计包数。
  final int packetsLost;

  /// The video sent loss ratio.
  ///
  /// **Note**
  /// The propertie is the instantaneous ratio when callbacking statistics.
  ///
  /// 视频发送丢包率。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时比率。
  final double lossRatio;

  /// The with of video sent resolution.
  ///
  /// **Note**
  /// The propertie is the dynamic value during video sending.
  ///
  /// 视频发送分辨率的宽度值。
  ///
  /// **Note**
  /// 此属性是在视频发送期间是个动态值。
  final int width;

  /// The height of video sent resolution.
  ///
  /// **Note**
  /// The propertie is the dynamic value during video sending.
  ///
  /// 视频发送分辨率的高度值。
  ///
  /// **Note**
  /// 此属性是在视频发送期间是个动态值。
  final int height;

  /// The video sent frame rate.
  ///
  /// **Note**
  /// The propertie is the dynamic value during video sending.
  ///
  /// 视频发送帧率。
  ///
  /// **Note**
  /// 此属性是在视频发送期间是个动态值。
  final int framerate;

  /// The number of received PLI packets during video sending.
  ///
  /// **Note**
  /// The propertie is the total packets after the video is started.
  ///
  /// 视频发送期间接收到的PLI包数。
  ///
  /// **Note**
  /// 此属性是视频开启之后的累计包数。
  final int plisReceived;

  /// The video round-trip time.
  ///
  /// **Note**
  /// The propertie is the recent RTT value when callbacking statistics.
  ///
  /// 视频往返时延。
  ///
  /// **Note**
  /// 此属性是回调统计时的最近往返时延值。
  final int rtt;

  /// The type of video codec.
  ///
  /// **Note**
  /// The propertie is the dynamic value during video sending.
  ///
  /// 视频编码器类型。
  ///
  /// **Note**
  /// 此属性是在视频发送期间是个动态值。
  final VideoCodecType codecType;

  /// Constructs a [RtcVideoSendStats]
  RtcVideoSendStats(
      this.streamId,
      this.bytesSent,
      this.sendBitrate,
      this.packetsLost,
      this.lossRatio,
      this.width,
      this.height,
      this.framerate,
      this.plisReceived,
      this.rtt,
      this.codecType);

  /// @nodoc
  factory RtcVideoSendStats.fromJson(Map<String, dynamic> json) =>
      _$RtcVideoSendStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcVideoSendStatsToJson(this);
}

/// The statistics class of received video.
///
/// 视频接收统计类。
@JsonSerializable(explicitToJson: true)
class RtcVideoRecvStats {
  ///
  /// The user ID of received video.
  ///
  /// **Note**
  /// The propertie is the user of the video that has been subscribed.
  ///
  /// 视频接收用户标识。
  ///
  /// **Note**
  /// 此属性是已被订阅视频的用户。
  final String userId;

  /// The stream ID of received video.
  ///
  /// 视频流标识。*/
  final int streamId;

  /// The video received bytes.
  ///
  /// **Note**
  /// The propertie is the total bytes after the video is subscribed.
  ///
  /// 视频接收字节数。
  ///
  /// **Note**
  /// 此属性是视频订阅之后的累计字节。
  final int bytesRecv;

  /// The video received bitrate. Unit: bps.
  ///
  /// **Note**
  /// The propertie is the instantaneous bitrate when callbacking statistics.
  ///
  /// 视频接收比特率。单位：比特每秒。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时比特率。
  final int recvBitrate;

  /// The numnber of video received lost packets.
  ///
  /// **Note**
  /// The propertie is the total packets after the video is subscribed.
  ///
  /// 视频接收丢包数。
  ///
  /// **Note**
  /// 此属性是视频订阅之后的累计包数。
  final int packetsLost;

  /// The video received loss ratio.
  ///
  /// **Note**
  /// The propertie is the instantaneous ratio when callbacking statistics.
  ///
  /// 视频接收丢包率。
  ///
  /// **Note**
  /// 此属性是回调统计时的瞬时比率。
  final double lossRatio;

  /// The width of video received resolution.
  ///
  /// **Note**
  /// The propertie is the dynamic value during video receiving.
  ///
  /// 视频接收分辨率的宽度值。
  ///
  /// **Note**
  /// 此属性是在视频接收期间是个动态值。
  final int width;

  /// The height of video received resolution.
  ///
  /// **Note**
  /// The propertie is the dynamic value during video receiving.
  ///
  /// 视频接收分辨率的高度值。
  ///
  /// **Note**
  /// 此属性是在视频接收期间是个动态值。
  final int height;

  /// The video received frame rate.
  ///
  /// **Note**
  /// The propertie is the dynamic value during video receiving.
  ///
  /// 视频接收帧率。
  ///
  /// **Note**
  /// 此属性是在视频接收期间是个动态值。
  final int framerate;

  /// The number of sent PLI packets during video receiving.
  ///
  /// **Note**
  /// The propertie is the total packets after the video is subscribed.
  ///
  /// 视频接收期间发送出的PLI包数。
  ///
  /// **Note**
  /// 此属性是视频订阅之后的累计包数。
  final int plisSent;

  /// The type of video codec.
  ///
  /// **Note**
  /// The propertie is the dynamic value during video receiving.
  ///
  /// 视频解码器类型。
  ///
  /// **Note**
  /// 此属性是在视频接收期间是个动态值。
  final VideoCodecType codecType;

  /// Constructs a [RtcVideoRecvStats]
  RtcVideoRecvStats(
      this.userId,
      this.streamId,
      this.bytesRecv,
      this.recvBitrate,
      this.packetsLost,
      this.lossRatio,
      this.width,
      this.height,
      this.framerate,
      this.plisSent,
      this.codecType);

  /// @nodoc
  factory RtcVideoRecvStats.fromJson(Map<String, dynamic> json) =>
      _$RtcVideoRecvStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcVideoRecvStatsToJson(this);
}

/// The statistics class of bandwidth estimation of sent video.
///
/// 视频发送带宽评估统计类。
@JsonSerializable(explicitToJson: true)
class RtcVideoSendBweStats {
  ///
  /// The evaluated bandwidth of sent video.
  ///
  /// **Note**
  /// The propertie is the total bandwidth of video and screen sharing.
  ///
  /// 视频发送的评估带宽。
  ///
  /// **Note**
  /// 此属性是视频和屏幕共享的总带宽。
  final int bandwidth;

  /// The encode bitrate of sent video. Unit: bps.
  ///
  /// **Note**
  /// The propertie is the total encode bitrate of video and screen sharing.
  ///
  /// 视频发送的编码比特率。单位：比特每秒。
  ///
  /// **Note**
  /// 此属性是视频和屏幕共享的总编码比特率。
  final int encodeBitrate;

  /// The transmit bitrate of sent video. Unit: bps.
  ///
  /// **Note**
  /// The propertie is the total transmit bitrate of video and screen sharing.
  ///
  /// 视频发送的传输比特率。单位：比特每秒。
  ///
  /// **Note**
  /// 此属性是视频和屏幕共享的总传输比特率。
  final int transmitBitrate;

  /// The retransmit bitrate of sent video. Unit: bps.
  ///
  /// **Note**
  /// The propertie is the total retransmit bitrate of video and screen sharing.
  ///
  /// 视频发送的重传比特率。单位：比特每秒。
  ///
  /// **Note**
  /// 此属性是视频和屏幕共享的总重传比特率。
  final int retransmitBitrate;

  /// Constructs a [RtcVideoSendBweStats]
  RtcVideoSendBweStats(this.bandwidth, this.encodeBitrate, this.transmitBitrate,
      this.retransmitBitrate);

  /// @nodoc
  factory RtcVideoSendBweStats.fromJson(Map<String, dynamic> json) =>
      _$RtcVideoSendBweStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcVideoSendBweStatsToJson(this);
}

/// The statistics class of bandwidth estimation of received video.
///
/// 视频接收带宽评估统计类。
@JsonSerializable(explicitToJson: true)
class RtcVideoRecvBweStats {
  ///
  /// The user ID of received video.
  ///
  /// **Note**
  /// The propertie is the user of the video that has been subscribed.
  ///
  /// 视频接收用户标识。
  ///
  /// **Note**
  /// 此属性是已被订阅视频的用户。
  final String userId;

  /// The evaluated bandwidth of received video.
  ///
  /// **Note**
  /// The propertie is the total bandwidth of video and screen sharing.
  ///
  /// 视频接收的评估带宽。
  ///
  /// **Note**
  /// 此属性是视频和屏幕共享的总带宽。
  final int bandwidth;

  /// Constructs a [RtcVideoRecvBweStats]
  RtcVideoRecvBweStats(this.userId, this.bandwidth);

  /// @nodoc
  factory RtcVideoRecvBweStats.fromJson(Map<String, dynamic> json) =>
      _$RtcVideoRecvBweStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcVideoRecvBweStatsToJson(this);
}

/// The statistics class of system information.
///
/// 系统信息统计类。
@JsonSerializable(explicitToJson: true)
class RtcSystemStats {
  ///
  /// The total cpu usage. Unit: percentage.
  ///
  /// 总CPU负载。单位：百分比。
  final int totalCpuUsage;

  /// The total physical memory. Unit: KByte.
  ///
  /// 总物理内存。单位：千字节。
  final int totalPhysMemory;

  /// The memory used by current process. Unit: KByte.
  ///
  /// 当前进程使用内存。单位：千字节。
  final int workingSetSize;

  /// The total memory usage. Unit: percentage.
  ///
  /// 总内存负载。单位：百分比。
  final int memoryUsage;

  /// Constructs a [RtcVideoRecvBweStats]
  RtcSystemStats(this.totalCpuUsage, this.totalPhysMemory, this.workingSetSize,
      this.memoryUsage);

  /// @nodoc
  factory RtcSystemStats.fromJson(Map<String, dynamic> json) =>
      _$RtcSystemStatsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcSystemStatsToJson(this);
}

/// The device information class.
///
/// 设备信息类。
@JsonSerializable(explicitToJson: true)
class RtcDeviceInfo {
  /// The device unque ID.
  ///
  /// 设备唯一标识。
  final String? deviceId;

  /// The device display name.
  ///
  /// 设备可显示名字。
  final String? deviceName;

  /// Constructs a [RtcDeviceInfo]
  RtcDeviceInfo({this.deviceId, this.deviceName});

  /// @nodoc
  factory RtcDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$RtcDeviceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcDeviceInfoToJson(this);
}

/// The screen source information class.
///
/// 屏幕源信息类。
@JsonSerializable(explicitToJson: true)
class RtcScreenSourceInfo {
  /// The screen source unque ID.
  ///
  /// 屏幕源唯一标识。
  final int sourceId;

  /// The screen source display name.
  ///
  /// 屏幕源可显示名字。
  final String sourceName;

  /// Constructs a [RtcScreenSourceInfo]
  RtcScreenSourceInfo(this.sourceId, this.sourceName);

  /// @nodoc
  factory RtcScreenSourceInfo.fromJson(Map<String, dynamic> json) =>
      _$RtcScreenSourceInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcScreenSourceInfoToJson(this);
}

/// The whiteboard color class.
///
/// 白板颜色类。
@JsonSerializable(explicitToJson: true)
class WBColor {
  /// The red component, valid value ranges between 0.0 and 1.0. Default: 0.0.
  ///
  /// 红色成分，有效值范围0.0到1.0。默认值：0.0。
  double? red;

  /// The green component, valid value ranges between 0.0 and 1.0. Default: 0.0.
  ///
  /// 绿色成分，有效值范围0.0到1.0。默认值：0.0。
  double? green;

  /// The blue component, valid value ranges between 0.0 and 1.0. Default: 0.0.
  ///
  /// 蓝色成分，有效值范围0.0到1.0。默认值：0.0。
  double? blue;

  /// The alpha component, valid value ranges between 0.0 and 1.0. Default: 1.0.
  ///
  /// 透明度成分，有效值范围0.0到1.0。默认值：1.0。
  double? alpha;

  /// Constructs a [WBColor]
  WBColor(
      {this.red = 0.0, this.green = 0.0, this.blue = 0.0, this.alpha = 1.0});

  /// @nodoc
  factory WBColor.fromJson(Map<String, dynamic> json) =>
      _$WBColorFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WBColorToJson(this);
}

/// The whiteboard text format class.
///
/// 白板文本格式类。
@JsonSerializable(explicitToJson: true)
class WBTextFormat {
  /// The font style, PanoWBFontStyle enum type. Default: kPanoWBFontNormal.
  ///
  /// 字体样式，PanoWBFontStyle 枚举类型。默认值：kPanoWBFontNormal。
  WBFontStyle? style;

  /// The font size, valid value ranges between 10 and 96. Default: 12.
  ///
  /// 字体大小，有效值范围10到96。默认值：12。
  int? size;

  /// Constructs a [WBTextFormat]
  WBTextFormat({this.style = WBFontStyle.Normal, this.size = 12});

  /// @nodoc
  factory WBTextFormat.fromJson(Map<String, dynamic> json) =>
      _$WBTextFormatFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WBTextFormatToJson(this);
}

/// The whiteboard stamp class.
///
/// 白板图章类。
@JsonSerializable(explicitToJson: true)
class WBStamp {
  /// Stamp resource ID.
  ///
  /// 图章资源ID
  String stampId;

  /// Stamp resource local path.
  ///
  /// 图章资源本地路径
  String path;

  /// stamp could be resized or not. Default: false.
  ///
  /// 图章是否可以改变大小。默认值：false
  bool? resizable;

  /// Constructs a [WBStamp]
  WBStamp(this.stampId, this.path, {this.resizable = false});

  /// @nodoc
  factory WBStamp.fromJson(Map<String, dynamic> json) =>
      _$WBStampFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WBStampToJson(this);
}

/// Whiteboard doc content class.
///
/// **Note**
/// Use Pano whiteboard convert service result to fill urls and count
/// For H5 convert result, The first url is H5 file url, the second is file download url.
///
/// 白板文件内容类。
///
/// **Note**
/// 使用Pano白板转码服务结果填充urls和count参数
/// 对H5转码结果，第一个参数为H5文件url，第二个参数为下载url。
@JsonSerializable(explicitToJson: true)
class WBDocContents {
  /// Whiteboard file name
  ///
  /// 白板文件名称。
  String name;

  /// url array (remote url only)
  ///
  /// url地址数组（仅支持远程url）。
  List<String> urls;

  /// thumbnail url array (remote url only)
  ///
  /// thumbnail url地址数组（仅支持远程url）。
  List<String> thumbUrls;

  /// upload doc ID.
  ///
  /// 上传文档的ID。
  String docId;

  /// WBDocType enum type. Default: Normal
  /// WBDocType枚举类型。默认值：Normal
  WBDocType type;

  /// Constructs a [WBDocContents]
  WBDocContents(this.name, this.urls, this.thumbUrls,
      {this.docId = '', this.type = WBDocType.Normal});

  /// @nodoc
  factory WBDocContents.fromJson(Map<String, dynamic> json) =>
      _$WBDocContentsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WBDocContentsToJson(this);
}

/// Whiteboard doc external Html content.
///
/// **Note**
/// If need synchronize web contents, the web page must integrate PanoExternalHtml SDK.
///
/// 白板文件外部Html内容。
///
/// **Note**
/// 如果需要同步网页内容，网页需要集成PanoExternalHtml SDK
@JsonSerializable(explicitToJson: true)
class WBDocExtHtml {
  /// Whiteboard file name
  ///
  /// 白板文件名称。
  String? name;

  /// url (remote url only)
  ///
  /// url地址（仅支持远程url）。
  String url;

  /// thumbnail url array (remote url only)
  ///
  /// thumbnail url地址数组（仅支持远程url）。
  List<String> thumbUrls;

  /// Constructs a [WBDocExtHtml]
  WBDocExtHtml(this.url, this.thumbUrls, {this.name = ''});

  /// @nodoc
  factory WBDocExtHtml.fromJson(Map<String, dynamic> json) =>
      _$WBDocExtHtmlFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WBDocExtHtmlToJson(this);
}

/// Whiteboard doc external background contents.
///
/// **Note**
/// Whiteboard would be transparent and sync draws only for external contents.
/// Application should sync external background contents by itself.
///
/// 白板文件外部内容。
///
/// **Note**
/// 对外部背景内容，白板是透明的且仅同步绘制内容。应用层需要自行同步外部背景内容。
@JsonSerializable(explicitToJson: true)
class WBDocExtContents {
  /// Whiteboard file name.
  ///
  /// 白板文件名称。
  String? name;

  /// total page number.
  ///
  /// 总页数。
  int totalPages;

  /// Whiteboard file width.
  ///
  /// 白板文件宽度。
  int width;

  /// Whiteboard file height.
  ///
  /// 白板文件高度。
  int height;

  /// Constructs a [WBDocExtContents]
  WBDocExtContents(this.totalPages, this.width, this.height, {this.name = ''});

  /// @nodoc
  factory WBDocExtContents.fromJson(Map<String, dynamic> json) =>
      _$WBDocExtContentsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WBDocExtContentsToJson(this);
}

/// The configurations class of whiteboard doc convert.
///
/// 白板文件转码配置类。
@JsonSerializable(explicitToJson: true)
class WBConvertConfig {
  /// Whiteboard doc convert type, [WBConvertType] enum type. Default: [WBConvertType.JPG].
  ///
  /// 白板文件转码类型 [WBConvertType] 枚举类型。默认值：[WBConvertType.JPG]。
  WBConvertType? type;

  /// Whether need thumbnails. Default: false.
  ///
  /// 是否需要缩略图。默认值：false。
  bool? needThumb;

  /// Constructs a [WBConvertConfig]
  WBConvertConfig({this.type = WBConvertType.JPG, this.needThumb = false});

  /// @nodoc
  factory WBConvertConfig.fromJson(Map<String, dynamic> json) =>
      _$WBConvertConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WBConvertConfigToJson(this);
}

/// The whiteboard file information class.
///
/// 白板文件信息类。
@JsonSerializable(explicitToJson: true)
class WBDocInfo {
  /// The whiteboard file ID.
  ///
  /// 白板文件ID。
  String fileId;

  /// The whiteboard file name.
  ///
  /// 白板文件名称。
  String name;

  /// The whiteboard file creator userId.
  ///
  /// 白板文件创建者用户ID。
  String creator;

  /// Whiteboard file type.
  ///
  /// 白板文件类型。
  WBDocType type;

  /// upload doc ID.
  ///
  /// 上传文档的ID。
  String docId;

  /// Constructs a [WBDocInfo]
  WBDocInfo(this.fileId, this.name, this.creator, this.type, this.docId);

  /// @nodoc
  factory WBDocInfo.fromJson(Map<String, dynamic> json) =>
      _$WBDocInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WBDocInfoToJson(this);
}

/// Whiteboard vision configuration.
///
/// 白板视口配置。
@JsonSerializable(explicitToJson: true)
class WBVisionConfig {
  /// Whiteboard width
  ///
  /// 白板宽度。
  int width;

  /// Whiteboard height
  ///
  /// 白板高度。
  int height;

  /// Whether whiteboard size is limited
  ///
  /// 白板大小是否固定。
  bool limited;

  /// Constructs a [WBVisionConfig]
  WBVisionConfig(this.width, this.height, this.limited);

  /// @nodoc
  factory WBVisionConfig.fromJson(Map<String, dynamic> json) =>
      _$WBVisionConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$WBVisionConfigToJson(this);
}

/// The face beautify option class.
///
/// 美颜选项类。
@JsonSerializable(explicitToJson: true)
class FaceBeautifyOption {
  /// Whether to enable face beautify. Default: NO.
  ///
  /// 是否开启美颜。默认值：否。
  bool? enable;

  /// The intensity of face beautify, valid value ranges between 0.0 and 1.0. Default: 0.5.
  ///
  /// 美颜强度，有效值范围0.0到1.0。默认值：0.5。
  double? intensity;

  /// Constructs a [FaceBeautifyOption]
  FaceBeautifyOption({this.enable = false, this.intensity = 0.5});

  /// @nodoc
  factory FaceBeautifyOption.fromJson(Map<String, dynamic> json) =>
      _$FaceBeautifyOptionFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$FaceBeautifyOptionToJson(this);
}

/// (Deprecated) The built-in video transform option class.
///
/// （已废弃）视频内嵌变换选项类。
@deprecated
@JsonSerializable(explicitToJson: true)
class BuiltinTransformOption {
  /// Whether to enable built-in transform on video. Default: NO.
  ///
  /// 是否开启视频内嵌变换。默认值：否。
  bool? enable;

  /// True to reset all parameters， false don't reset parameters. Default: NO.
  ///
  /// true 重置所有的视频形变参数， false 不重置视频形变参数。默认值：否。
  bool? bReset;

  /// scaling factor in X axis (1.0: no scaling). Default: 1.0.
  ///
  /// X轴缩放比例 （1.0：no scaling）。默认值：1.0。
  double? xScaling;

  /// scaling factor in Y axis (1.0: no scaling). Default: 1.0.
  ///
  /// Y轴缩放比例 （1.0：no scaling）。默认值：1.0。
  double? yScaling;

  /// Delta angle of the rotation (in radians) in X axis. Default: 0.0
  ///
  /// X轴旋转角度的差值。默认值：0.0。
  double? xRotation;

  /// Delta Angle of the rotation (in radians) in Y axis. Default: 0.0
  ///
  /// Y轴旋转角度的差值。默认值：0.0。
  double? yRotation;

  /// Delta Angle of the rotation (in radians) in Z axis. Default: 0.0
  ///
  /// Z轴旋转角度的差值。默认值：0.0。
  double? zRotation;

  /// Projection Depth along X axis. Default: 0.0.
  ///
  /// X轴的投影深度。 默认值：0.0。
  double? xProjection;

  /// Projection Depth along Y axis. Default: 0.0.
  ///
  /// Y轴的投影深度。 默认值：0.0。
  double? yProjection;

  /// Constructs a [BuiltinTransformOption]
  BuiltinTransformOption(
      {this.enable = false,
      this.bReset = false,
      this.xScaling = 1.0,
      this.yScaling = 1.0,
      this.xRotation = 0.0,
      this.yRotation = 0.0,
      this.zRotation = 0.0,
      this.xProjection = 0.0,
      this.yProjection = 0.0});

  /// @nodoc
  factory BuiltinTransformOption.fromJson(Map<String, dynamic> json) =>
      _$BuiltinTransformOptionFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$BuiltinTransformOptionToJson(this);
}

/// The quadrilateral video transform option class.
///
/// 视频四边形变换选项类。
@JsonSerializable(explicitToJson: true)
class QuadTransformOption {
  /// Whether to enable quadrilateral transform on video. Default: NO.
  ///
  /// 是否开启视频四边形变换。默认值：否。
  bool? enable;

  /// True to reset all quadrilateral transform parameters， false don't reset quadrilateral transform parameters. Default: NO.
  ///
  /// true 重置所有的视频四边形形变参数， false 不重置视频四边形形变参数。默认值：否。
  bool? bReset;

  /// Vertex index of a quadrilateral. TopLeft: 0, TopRight: 1, BottomLeft: 2, BottomRight: 3
  ///
  /// 四边形顶点索引。 左上角：0，右上角：1，左下角：2，右下角：3*/
  QuadIndex? index;

  /// Delta of x axis, The origin (0,0) of the video is the top left, the whole size of video is 1x1, can be negative (top or left is out of view), and can be greater than 1 (bottom or right is out of view).
  ///
  /// X坐标轴的差值，视频的左上角为坐标系的原点（0，0），视频完整大小为1x1，可以为负值（左侧超出屏幕），可以为大于1的值（右侧超出屏幕）*/
  double? xDeltaAxis;

  /// Delta of y axis, The origin (0,0) of the video is the top left, the whole size of video is 1x1, can be negative (top or left is out of view), and can be greater than 1 (bottom or right is out of view).
  ///
  /// Y坐标轴的差值，视频的左上角为坐标系的原点（0，0），视频完整大小为1x1，可以为负值（左或上超出屏幕），可以为大于1的值（右或下超出屏幕）*/
  double? yDeltaAxis;

  /// Set Mirror mode for video transform (exchange left and right). Note: Set mirror mode to true when using front facing camera, false when using back facing camera. Reset doesn't reset this, but keeps last value.
  ///
  /// 设置视频变换为镜像模式(左右交换）。注意：使用前置摄像头时需要设置为true，使用后置摄像头时需要设置为false。重置参数时，并不会改变mirror的值，仍将保持上次的设置。*/
  bool? bMirror;

  /// Constructs a [QuadTransformOption]
  QuadTransformOption(
      {this.enable = false,
      this.bReset = false,
      this.index = QuadIndex.TopLeft,
      this.xDeltaAxis = 0.0,
      this.yDeltaAxis = 0.0,
      this.bMirror = false});

  /// @nodoc
  factory QuadTransformOption.fromJson(Map<String, dynamic> json) =>
      _$QuadTransformOptionFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$QuadTransformOptionToJson(this);
}

/// Feedback info class, user can send feedback to PANO.
///
/// 用户反馈信息类，用于发送用户反馈。*/
@JsonSerializable(explicitToJson: true)
class FeedbackInfo {
  /// Feedback type. Default: kPanoFeedbackGeneral.
  ///
  /// 反馈类型。默认值：kPanoFeedbackGeneral。
  FeedbackType type;

  /// Product name, max length 128 bytes.
  ///
  /// 产品名，最多128字节。
  String productName;

  /// Detail description of problem, max length 1024 bytes.
  ///
  /// 问题详细描述，最多1024字节。
  String detailDescription;

  /// User contact, max length 128 bytes.
  ///
  /// 联系信息，最多128字节。
  String? contact;

  /// User extra info, max length 256 bytes.
  ///
  /// 附加信息，最多256字节。
  String? extraInfo;

  /// Whether to upload logs. Default: NO.
  ///
  /// 是否上传日志。默认值：否。
  bool? uploadLogs;

  /// Constructs a [FeedbackInfo]
  FeedbackInfo(this.type, this.productName, this.detailDescription,
      {this.contact, this.extraInfo, this.uploadLogs = false});

  /// @nodoc
  factory FeedbackInfo.fromJson(Map<String, dynamic> json) =>
      _$FeedbackInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$FeedbackInfoToJson(this);
}

/// The configurations class of audio mixing.
///
/// 音频混音配置类。
@JsonSerializable(explicitToJson: true)
class RtcAudioMixingConfig {
  /// Enable publish. Default: YES
  ///
  /// 是否发送。默认值：是。
  bool? enablePublish;

  /// publish volume. 0~200. Default: 100.
  ///
  /// **Note**
  /// There could be cracking sounds when the volume is larger than 100.
  ///
  /// 发送音量。0～200。默认值：100。
  ///
  /// **Note**
  /// 音量超过100后可能产生破音。
  int? publishVolume;

  /// Enable loopback. Default: YES
  ///
  /// 是否发送。默认值：是。
  bool? enableLoopback;

  /// loopback volume. 0~200. Default: 100.
  ///
  /// **Note**
  /// There could be cracking sounds when the volume is larger than 100.
  ///
  /// 回放音量。0～200。默认值：100。
  ///
  /// **Note**
  /// 音量超过100后可能产生破音。
  int? loopbackVolume;

  /// Times to play. 0 means loop forever. Default: 1.
  ///
  /// 播放次数。0指无限循环。默认值：1。
  int? cycle;

  /// YES: Replace microphone data. NO: Mix with microphone data. Default: NO.
  ///
  /// 是: 替换麦克风数据。否: 与麦克风数据混音。默认值：否。
  bool? replaceMicrophone;

  /// Constructs a [RtcAudioMixingConfig]
  RtcAudioMixingConfig(
      {this.enablePublish = true,
      this.publishVolume = 100,
      this.enableLoopback = true,
      this.loopbackVolume = 100,
      this.cycle = 1,
      this.replaceMicrophone = false});

  /// @nodoc
  factory RtcAudioMixingConfig.fromJson(Map<String, dynamic> json) =>
      _$RtcAudioMixingConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcAudioMixingConfigToJson(this);
}

/// The option class of video snapshot.
///
/// 视频快照选项类。
@JsonSerializable(explicitToJson: true)
class RtcSnapshotVideoOption {
  /// The format of snapshot. Default: kPanoImageFileJPEG.
  ///
  /// 快照格式。默认值：kPanoImageFileJPEG。
  ImageFileFormat? format;

  /// Whether to mirror. Default: NO.
  ///
  /// 是否镜像。默认值：否。
  bool? mirror;

  /// Constructs a [RtcSnapshotVideoOption]
  RtcSnapshotVideoOption(
      {this.format = ImageFileFormat.JPEG, this.mirror = false});

  /// @nodoc
  factory RtcSnapshotVideoOption.fromJson(Map<String, dynamic> json) =>
      _$RtcSnapshotVideoOptionFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcSnapshotVideoOptionToJson(this);
}

/// Network quality report.
///
/// 网络质量报告。
@JsonSerializable(explicitToJson: true)
class RtcNetworkQuality {
  /// Quality rating. Default: kPanoQualityUnavailable.
  ///
  /// 网络质量评分。默认值：kPanoQualityUnavailable。
  final QualityRating? rating;

  /// Uplink loss rate. Default: 0.
  ///
  /// 上行丢包率。默认值：0。
  final double? txLoss;

  /// Downlink loss rate. Default: 0.
  ///
  /// 下行丢包率。默认值：0。
  final double? rxLoss;

  /// Round-Trip Time in millisecond. Default: 0.
  ///
  /// RTT延迟, 单位：毫秒。默认值：0。
  final int? rtt;

  /// Constructs a [RtcNetworkQuality]
  RtcNetworkQuality(
      {this.rating = QualityRating.Unavailable,
      this.txLoss = 0,
      this.rxLoss = 0,
      this.rtt = 0});

  /// @nodoc
  factory RtcNetworkQuality.fromJson(Map<String, dynamic> json) =>
      _$RtcNetworkQualityFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcNetworkQualityToJson(this);
}

/// The parameters when joining a group.
///
/// 分组配置参数，用于加入分组。
@JsonSerializable(explicitToJson: true)
class GroupConfig {

  /// Extra data defined by APP, it will be sent to all users in group, max length is 128 bytes.
  ///
  /// 用户定义的附加数据，此数据会广播给所有分组用户。最大长度 128 字节。
  String? userData;

  /// Constructs a [GroupConfig]
  GroupConfig(this.userData);

  /// @nodoc
  factory GroupConfig.fromJson(Map<String, dynamic> json) =>
      _$GroupConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$GroupConfigToJson(this);
}

/// The information of the group member.
///
/// 分组成员信息。
@JsonSerializable(explicitToJson: true)
class UserInfo {
  /// The user ID.
  ///
  /// 用户ID。
  String userId;

  /// Extra data defined by APP, it will be sent to all users in group, max length is 128 bytes.
  ///
  /// 用户定义的附加数据，此数据会广播给所有分组用户。最大长度 128 字节。
  String userData;

  /// Constructs a [UserInfo]
  UserInfo(this.userId, this.userData);

  /// @nodoc
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
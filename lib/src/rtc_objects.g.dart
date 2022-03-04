// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rtc_objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RtcEngineConfig _$RtcEngineConfigFromJson(Map<String, dynamic> json) =>
    RtcEngineConfig(
      json['appId'] as String,
      rtcServer: json['rtcServer'] as String? ?? '',
      videoCodecHwAcceleration:
          json['videoCodecHwAcceleration'] as bool? ?? false,
      audioScenario: json['audioScenario'] as int? ?? 0,
    );

Map<String, dynamic> _$RtcEngineConfigToJson(RtcEngineConfig instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'rtcServer': instance.rtcServer,
      'videoCodecHwAcceleration': instance.videoCodecHwAcceleration,
      'audioScenario': instance.audioScenario,
    };

RtcChannelConfig _$RtcChannelConfigFromJson(Map<String, dynamic> json) =>
    RtcChannelConfig(
      mode: $enumDecodeNullable(_$ChannelModeEnumMap, json['mode']) ??
          ChannelMode.OneOnOne,
      serviceFlags: (json['serviceFlags'] as List<dynamic>?)
              ?.map((e) => $enumDecodeNullable(_$ChannelServiceEnumMap, e))
              .toSet() ??
          const {
            ChannelService.Media,
            ChannelService.Whiteboard,
            ChannelService.Message
          },
      subscribeAudioAll: json['subscribeAudioAll'] as bool? ?? true,
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$RtcChannelConfigToJson(RtcChannelConfig instance) =>
    <String, dynamic>{
      'mode': _$ChannelModeEnumMap[instance.mode],
      'serviceFlags': instance.serviceFlags
          ?.map((e) => _$ChannelServiceEnumMap[e])
          .toList(),
      'subscribeAudioAll': instance.subscribeAudioAll,
      'userName': instance.userName,
    };

const _$ChannelModeEnumMap = {
  ChannelMode.OneOnOne: 0,
  ChannelMode.Meeting: 1,
};

const _$ChannelServiceEnumMap = {
  ChannelService.Media: 1,
  ChannelService.Whiteboard: 2,
  ChannelService.Message: 4,
};

RtcVideoConfig _$RtcVideoConfigFromJson(Map<String, dynamic> json) =>
    RtcVideoConfig(
      profileType:
          $enumDecodeNullable(_$VideoProfileTypeEnumMap, json['profileType']) ??
              VideoProfileType.Standard,
      sourceMirror: json['sourceMirror'] as bool? ?? false,
      scalingMode:
          $enumDecodeNullable(_$VideoScalingModeEnumMap, json['scalingMode']) ??
              VideoScalingMode.Fit,
      mirror: json['mirror'] as bool? ?? false,
    );

Map<String, dynamic> _$RtcVideoConfigToJson(RtcVideoConfig instance) =>
    <String, dynamic>{
      'profileType': _$VideoProfileTypeEnumMap[instance.profileType],
      'sourceMirror': instance.sourceMirror,
      'scalingMode': _$VideoScalingModeEnumMap[instance.scalingMode],
      'mirror': instance.mirror,
    };

const _$VideoProfileTypeEnumMap = {
  VideoProfileType.Lowest: 0,
  VideoProfileType.Low: 1,
  VideoProfileType.Standard: 2,
  VideoProfileType.HD720P: 3,
  VideoProfileType.HD1080P: 4,
  VideoProfileType.None: 5,
  VideoProfileType.Max: 4,
};

const _$VideoScalingModeEnumMap = {
  VideoScalingMode.Fit: 0,
  VideoScalingMode.FullFill: 1,
  VideoScalingMode.CropFill: 2,
};

RtcAudioFormat _$RtcAudioFormatFromJson(Map<String, dynamic> json) =>
    RtcAudioFormat(
      type: $enumDecodeNullable(_$AudioTypeEnumMap, json['type']) ??
          AudioType.PCM,
      channels: json['channels'] as int? ?? 0,
      sampleRate: json['sampleRate'] as int? ?? 0,
      bytesPerSample: json['bytesPerSample'] as int? ?? 0,
    );

Map<String, dynamic> _$RtcAudioFormatToJson(RtcAudioFormat instance) =>
    <String, dynamic>{
      'type': _$AudioTypeEnumMap[instance.type],
      'channels': instance.channels,
      'sampleRate': instance.sampleRate,
      'bytesPerSample': instance.bytesPerSample,
    };

const _$AudioTypeEnumMap = {
  AudioType.PCM: 0,
};

RtcVideoFormat _$RtcVideoFormatFromJson(Map<String, dynamic> json) =>
    RtcVideoFormat(
      (json['offset'] as List<dynamic>).map((e) => e as int).toList(),
      (json['stride'] as List<dynamic>).map((e) => e as int).toList(),
      type: $enumDecodeNullable(_$VideoTypeEnumMap, json['type']) ??
          VideoType.I420,
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      count: json['count'] as int? ?? 0,
      rotation: $enumDecodeNullable(_$VideoRotationEnumMap, json['rotation']) ??
          VideoRotation.Rotation0,
    );

Map<String, dynamic> _$RtcVideoFormatToJson(RtcVideoFormat instance) =>
    <String, dynamic>{
      'type': _$VideoTypeEnumMap[instance.type],
      'width': instance.width,
      'height': instance.height,
      'count': instance.count,
      'offset': instance.offset,
      'stride': instance.stride,
      'rotation': _$VideoRotationEnumMap[instance.rotation],
    };

const _$VideoTypeEnumMap = {
  VideoType.I420: 0,
};

const _$VideoRotationEnumMap = {
  VideoRotation.Rotation0: 0,
  VideoRotation.Rotation90: 90,
  VideoRotation.Rotation180: 180,
  VideoRotation.Rotation270: 270,
};

RtcAudioLevel _$RtcAudioLevelFromJson(Map<String, dynamic> json) =>
    RtcAudioLevel(
      json['userId'] as String,
      level: json['level'] as int? ?? 0,
      active: json['active'] as bool? ?? false,
    );

Map<String, dynamic> _$RtcAudioLevelToJson(RtcAudioLevel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'level': instance.level,
      'active': instance.active,
    };

RtcAudioProfile _$RtcAudioProfileFromJson(Map<String, dynamic> json) =>
    RtcAudioProfile(
      sampleRate:
          $enumDecodeNullable(_$AudioSampleRateEnumMap, json['sampleRate']) ??
              AudioSampleRate.Rate48K,
      channel: $enumDecodeNullable(_$AudioChannelEnumMap, json['channel']) ??
          AudioChannel.Mono,
      encodeBitrate: json['encodeBitrate'] as int? ?? 64000,
    );

Map<String, dynamic> _$RtcAudioProfileToJson(RtcAudioProfile instance) =>
    <String, dynamic>{
      'sampleRate': _$AudioSampleRateEnumMap[instance.sampleRate],
      'channel': _$AudioChannelEnumMap[instance.channel],
      'encodeBitrate': instance.encodeBitrate,
    };

const _$AudioSampleRateEnumMap = {
  AudioSampleRate.Rate16K: 16000,
  AudioSampleRate.Rate48K: 48000,
};

const _$AudioChannelEnumMap = {
  AudioChannel.Mono: 1,
  AudioChannel.Stereo: 2,
};

RtcAudioSendStats _$RtcAudioSendStatsFromJson(Map<String, dynamic> json) =>
    RtcAudioSendStats(
      json['bytesSent'] as int,
      json['sendBitrate'] as int,
      json['packetsLost'] as int,
      (json['lossRatio'] as num).toDouble(),
      json['rtt'] as int,
      json['inputLevel'] as int,
      json['inputActiveFlag'] as bool,
      $enumDecode(_$AudioCodecTypeEnumMap, json['codecType']),
    );

Map<String, dynamic> _$RtcAudioSendStatsToJson(RtcAudioSendStats instance) =>
    <String, dynamic>{
      'bytesSent': instance.bytesSent,
      'sendBitrate': instance.sendBitrate,
      'packetsLost': instance.packetsLost,
      'lossRatio': instance.lossRatio,
      'rtt': instance.rtt,
      'inputLevel': instance.inputLevel,
      'inputActiveFlag': instance.inputActiveFlag,
      'codecType': _$AudioCodecTypeEnumMap[instance.codecType],
    };

const _$AudioCodecTypeEnumMap = {
  AudioCodecType.Unknown: 0,
  AudioCodecType.G711: 1,
  AudioCodecType.G722: 2,
  AudioCodecType.ILBC: 3,
  AudioCodecType.ISAC: 4,
  AudioCodecType.OPUS: 5,
};

RtcAudioRecvStats _$RtcAudioRecvStatsFromJson(Map<String, dynamic> json) =>
    RtcAudioRecvStats(
      json['userId'] as String,
      json['bytesRecv'] as int,
      json['recvBitrate'] as int,
      json['packetsLost'] as int,
      (json['lossRatio'] as num).toDouble(),
      json['outputLevel'] as int,
      $enumDecode(_$AudioCodecTypeEnumMap, json['codecType']),
    );

Map<String, dynamic> _$RtcAudioRecvStatsToJson(RtcAudioRecvStats instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'bytesRecv': instance.bytesRecv,
      'recvBitrate': instance.recvBitrate,
      'packetsLost': instance.packetsLost,
      'lossRatio': instance.lossRatio,
      'outputLevel': instance.outputLevel,
      'codecType': _$AudioCodecTypeEnumMap[instance.codecType],
    };

RtcVideoSendStats _$RtcVideoSendStatsFromJson(Map<String, dynamic> json) =>
    RtcVideoSendStats(
      json['streamId'] as int,
      json['bytesSent'] as int,
      json['sendBitrate'] as int,
      json['packetsLost'] as int,
      (json['lossRatio'] as num).toDouble(),
      json['width'] as int,
      json['height'] as int,
      json['framerate'] as int,
      json['plisReceived'] as int,
      json['rtt'] as int,
      $enumDecode(_$VideoCodecTypeEnumMap, json['codecType']),
    );

Map<String, dynamic> _$RtcVideoSendStatsToJson(RtcVideoSendStats instance) =>
    <String, dynamic>{
      'streamId': instance.streamId,
      'bytesSent': instance.bytesSent,
      'sendBitrate': instance.sendBitrate,
      'packetsLost': instance.packetsLost,
      'lossRatio': instance.lossRatio,
      'width': instance.width,
      'height': instance.height,
      'framerate': instance.framerate,
      'plisReceived': instance.plisReceived,
      'rtt': instance.rtt,
      'codecType': _$VideoCodecTypeEnumMap[instance.codecType],
    };

const _$VideoCodecTypeEnumMap = {
  VideoCodecType.Unknown: 0,
  VideoCodecType.H264: 1,
  VideoCodecType.AV1: 2,
};

RtcVideoRecvStats _$RtcVideoRecvStatsFromJson(Map<String, dynamic> json) =>
    RtcVideoRecvStats(
      json['userId'] as String,
      json['streamId'] as int,
      json['bytesRecv'] as int,
      json['recvBitrate'] as int,
      json['packetsLost'] as int,
      (json['lossRatio'] as num).toDouble(),
      json['width'] as int,
      json['height'] as int,
      json['framerate'] as int,
      json['plisSent'] as int,
      $enumDecode(_$VideoCodecTypeEnumMap, json['codecType']),
    );

Map<String, dynamic> _$RtcVideoRecvStatsToJson(RtcVideoRecvStats instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'streamId': instance.streamId,
      'bytesRecv': instance.bytesRecv,
      'recvBitrate': instance.recvBitrate,
      'packetsLost': instance.packetsLost,
      'lossRatio': instance.lossRatio,
      'width': instance.width,
      'height': instance.height,
      'framerate': instance.framerate,
      'plisSent': instance.plisSent,
      'codecType': _$VideoCodecTypeEnumMap[instance.codecType],
    };

RtcVideoSendBweStats _$RtcVideoSendBweStatsFromJson(
        Map<String, dynamic> json) =>
    RtcVideoSendBweStats(
      json['bandwidth'] as int,
      json['encodeBitrate'] as int,
      json['transmitBitrate'] as int,
      json['retransmitBitrate'] as int,
    );

Map<String, dynamic> _$RtcVideoSendBweStatsToJson(
        RtcVideoSendBweStats instance) =>
    <String, dynamic>{
      'bandwidth': instance.bandwidth,
      'encodeBitrate': instance.encodeBitrate,
      'transmitBitrate': instance.transmitBitrate,
      'retransmitBitrate': instance.retransmitBitrate,
    };

RtcVideoRecvBweStats _$RtcVideoRecvBweStatsFromJson(
        Map<String, dynamic> json) =>
    RtcVideoRecvBweStats(
      json['userId'] as String,
      json['bandwidth'] as int,
    );

Map<String, dynamic> _$RtcVideoRecvBweStatsToJson(
        RtcVideoRecvBweStats instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'bandwidth': instance.bandwidth,
    };

RtcSystemStats _$RtcSystemStatsFromJson(Map<String, dynamic> json) =>
    RtcSystemStats(
      json['totalCpuUsage'] as int,
      json['totalPhysMemory'] as int,
      json['workingSetSize'] as int,
      json['memoryUsage'] as int,
    );

Map<String, dynamic> _$RtcSystemStatsToJson(RtcSystemStats instance) =>
    <String, dynamic>{
      'totalCpuUsage': instance.totalCpuUsage,
      'totalPhysMemory': instance.totalPhysMemory,
      'workingSetSize': instance.workingSetSize,
      'memoryUsage': instance.memoryUsage,
    };

RtcDeviceInfo _$RtcDeviceInfoFromJson(Map<String, dynamic> json) =>
    RtcDeviceInfo(
      deviceId: json['deviceId'] as String?,
      deviceName: json['deviceName'] as String?,
    );

Map<String, dynamic> _$RtcDeviceInfoToJson(RtcDeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
    };

RtcScreenSourceInfo _$RtcScreenSourceInfoFromJson(Map<String, dynamic> json) =>
    RtcScreenSourceInfo(
      json['sourceId'] as int,
      json['sourceName'] as String,
    );

Map<String, dynamic> _$RtcScreenSourceInfoToJson(
        RtcScreenSourceInfo instance) =>
    <String, dynamic>{
      'sourceId': instance.sourceId,
      'sourceName': instance.sourceName,
    };

WBColor _$WBColorFromJson(Map<String, dynamic> json) => WBColor(
      red: (json['red'] as num?)?.toDouble() ?? 0.0,
      green: (json['green'] as num?)?.toDouble() ?? 0.0,
      blue: (json['blue'] as num?)?.toDouble() ?? 0.0,
      alpha: (json['alpha'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$WBColorToJson(WBColor instance) => <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
      'alpha': instance.alpha,
    };

WBTextFormat _$WBTextFormatFromJson(Map<String, dynamic> json) => WBTextFormat(
      style: $enumDecodeNullable(_$WBFontStyleEnumMap, json['style']) ??
          WBFontStyle.Normal,
      size: json['size'] as int? ?? 12,
    );

Map<String, dynamic> _$WBTextFormatToJson(WBTextFormat instance) =>
    <String, dynamic>{
      'style': _$WBFontStyleEnumMap[instance.style],
      'size': instance.size,
    };

const _$WBFontStyleEnumMap = {
  WBFontStyle.Normal: 0,
  WBFontStyle.Bold: 1,
  WBFontStyle.Italic: 2,
  WBFontStyle.BoldItalic: 3,
};

WBStamp _$WBStampFromJson(Map<String, dynamic> json) => WBStamp(
      json['stampId'] as String,
      json['path'] as String,
      resizable: json['resizable'] as bool? ?? false,
    );

Map<String, dynamic> _$WBStampToJson(WBStamp instance) => <String, dynamic>{
      'stampId': instance.stampId,
      'path': instance.path,
      'resizable': instance.resizable,
    };

WBDocContents _$WBDocContentsFromJson(Map<String, dynamic> json) =>
    WBDocContents(
      json['name'] as String,
      (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
      (json['thumbUrls'] as List<dynamic>).map((e) => e as String).toList(),
      docId: json['docId'] as String? ?? '',
      type: $enumDecodeNullable(_$WBDocTypeEnumMap, json['type']) ??
          WBDocType.Normal,
    );

Map<String, dynamic> _$WBDocContentsToJson(WBDocContents instance) =>
    <String, dynamic>{
      'name': instance.name,
      'urls': instance.urls,
      'thumbUrls': instance.thumbUrls,
      'docId': instance.docId,
      'type': _$WBDocTypeEnumMap[instance.type],
    };

const _$WBDocTypeEnumMap = {
  WBDocType.Normal: 1,
  WBDocType.H5: 2,
  WBDocType.ExtHtml: 3,
  WBDocType.External: 4,
  WBDocType.PDF: 5,
};

WBDocExtHtml _$WBDocExtHtmlFromJson(Map<String, dynamic> json) => WBDocExtHtml(
      json['url'] as String,
      (json['thumbUrls'] as List<dynamic>).map((e) => e as String).toList(),
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$WBDocExtHtmlToJson(WBDocExtHtml instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'thumbUrls': instance.thumbUrls,
    };

WBDocExtContents _$WBDocExtContentsFromJson(Map<String, dynamic> json) =>
    WBDocExtContents(
      json['totalPages'] as int,
      json['width'] as int,
      json['height'] as int,
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$WBDocExtContentsToJson(WBDocExtContents instance) =>
    <String, dynamic>{
      'name': instance.name,
      'totalPages': instance.totalPages,
      'width': instance.width,
      'height': instance.height,
    };

WBConvertConfig _$WBConvertConfigFromJson(Map<String, dynamic> json) =>
    WBConvertConfig(
      type: $enumDecodeNullable(_$WBConvertTypeEnumMap, json['type']) ??
          WBConvertType.JPG,
      needThumb: json['needThumb'] as bool? ?? false,
    );

Map<String, dynamic> _$WBConvertConfigToJson(WBConvertConfig instance) =>
    <String, dynamic>{
      'type': _$WBConvertTypeEnumMap[instance.type],
      'needThumb': instance.needThumb,
    };

const _$WBConvertTypeEnumMap = {
  WBConvertType.JPG: 1,
  WBConvertType.PNG: 2,
  WBConvertType.H5: 3,
};

WBDocInfo _$WBDocInfoFromJson(Map<String, dynamic> json) => WBDocInfo(
      json['fileId'] as String,
      json['name'] as String,
      json['creator'] as String,
      $enumDecode(_$WBDocTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$WBDocInfoToJson(WBDocInfo instance) => <String, dynamic>{
      'fileId': instance.fileId,
      'name': instance.name,
      'creator': instance.creator,
      'type': _$WBDocTypeEnumMap[instance.type],
    };

WBVisionConfig _$WBVisionConfigFromJson(Map<String, dynamic> json) =>
    WBVisionConfig(
      json['width'] as int,
      json['height'] as int,
      json['limited'] as bool,
    );

Map<String, dynamic> _$WBVisionConfigToJson(WBVisionConfig instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'limited': instance.limited,
    };

FaceBeautifyOption _$FaceBeautifyOptionFromJson(Map<String, dynamic> json) =>
    FaceBeautifyOption(
      enable: json['enable'] as bool? ?? false,
      intensity: (json['intensity'] as num?)?.toDouble() ?? 0.5,
    );

Map<String, dynamic> _$FaceBeautifyOptionToJson(FaceBeautifyOption instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'intensity': instance.intensity,
    };

BuiltinTransformOption _$BuiltinTransformOptionFromJson(
        Map<String, dynamic> json) =>
    BuiltinTransformOption(
      enable: json['enable'] as bool? ?? false,
      bReset: json['bReset'] as bool? ?? false,
      xScaling: (json['xScaling'] as num?)?.toDouble() ?? 1.0,
      yScaling: (json['yScaling'] as num?)?.toDouble() ?? 1.0,
      xRotation: (json['xRotation'] as num?)?.toDouble() ?? 0.0,
      yRotation: (json['yRotation'] as num?)?.toDouble() ?? 0.0,
      zRotation: (json['zRotation'] as num?)?.toDouble() ?? 0.0,
      xProjection: (json['xProjection'] as num?)?.toDouble() ?? 0.0,
      yProjection: (json['yProjection'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$BuiltinTransformOptionToJson(
        BuiltinTransformOption instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'bReset': instance.bReset,
      'xScaling': instance.xScaling,
      'yScaling': instance.yScaling,
      'xRotation': instance.xRotation,
      'yRotation': instance.yRotation,
      'zRotation': instance.zRotation,
      'xProjection': instance.xProjection,
      'yProjection': instance.yProjection,
    };

QuadTransformOption _$QuadTransformOptionFromJson(Map<String, dynamic> json) =>
    QuadTransformOption(
      enable: json['enable'] as bool? ?? false,
      bReset: json['bReset'] as bool? ?? false,
      index: $enumDecodeNullable(_$QuadIndexEnumMap, json['index']) ??
          QuadIndex.TopLeft,
      xDeltaAxis: (json['xDeltaAxis'] as num?)?.toDouble() ?? 0.0,
      yDeltaAxis: (json['yDeltaAxis'] as num?)?.toDouble() ?? 0.0,
      bMirror: json['bMirror'] as bool? ?? false,
    );

Map<String, dynamic> _$QuadTransformOptionToJson(
        QuadTransformOption instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'bReset': instance.bReset,
      'index': _$QuadIndexEnumMap[instance.index],
      'xDeltaAxis': instance.xDeltaAxis,
      'yDeltaAxis': instance.yDeltaAxis,
      'bMirror': instance.bMirror,
    };

const _$QuadIndexEnumMap = {
  QuadIndex.TopLeft: 0,
  QuadIndex.TopRight: 1,
  QuadIndex.BottomLeft: 2,
  QuadIndex.BottomRight: 3,
};

FeedbackInfo _$FeedbackInfoFromJson(Map<String, dynamic> json) => FeedbackInfo(
      $enumDecode(_$FeedbackTypeEnumMap, json['type']),
      json['productName'] as String,
      json['detailDescription'] as String,
      contact: json['contact'] as String?,
      extraInfo: json['extraInfo'] as String?,
      uploadLogs: json['uploadLogs'] as bool? ?? false,
    );

Map<String, dynamic> _$FeedbackInfoToJson(FeedbackInfo instance) =>
    <String, dynamic>{
      'type': _$FeedbackTypeEnumMap[instance.type],
      'productName': instance.productName,
      'detailDescription': instance.detailDescription,
      'contact': instance.contact,
      'extraInfo': instance.extraInfo,
      'uploadLogs': instance.uploadLogs,
    };

const _$FeedbackTypeEnumMap = {
  FeedbackType.General: 0,
  FeedbackType.Audio: 1,
  FeedbackType.Video: 2,
  FeedbackType.Whiteboard: 3,
  FeedbackType.Screen: 4,
};

RtcAudioMixingConfig _$RtcAudioMixingConfigFromJson(
        Map<String, dynamic> json) =>
    RtcAudioMixingConfig(
      enablePublish: json['enablePublish'] as bool? ?? true,
      publishVolume: json['publishVolume'] as int? ?? 100,
      enableLoopback: json['enableLoopback'] as bool? ?? true,
      loopbackVolume: json['loopbackVolume'] as int? ?? 100,
      cycle: json['cycle'] as int? ?? 1,
      replaceMicrophone: json['replaceMicrophone'] as bool? ?? false,
    );

Map<String, dynamic> _$RtcAudioMixingConfigToJson(
        RtcAudioMixingConfig instance) =>
    <String, dynamic>{
      'enablePublish': instance.enablePublish,
      'publishVolume': instance.publishVolume,
      'enableLoopback': instance.enableLoopback,
      'loopbackVolume': instance.loopbackVolume,
      'cycle': instance.cycle,
      'replaceMicrophone': instance.replaceMicrophone,
    };

RtcSnapshotVideoOption _$RtcSnapshotVideoOptionFromJson(
        Map<String, dynamic> json) =>
    RtcSnapshotVideoOption(
      format: $enumDecodeNullable(_$ImageFileFormatEnumMap, json['format']) ??
          ImageFileFormat.JPEG,
      mirror: json['mirror'] as bool? ?? false,
    );

Map<String, dynamic> _$RtcSnapshotVideoOptionToJson(
        RtcSnapshotVideoOption instance) =>
    <String, dynamic>{
      'format': _$ImageFileFormatEnumMap[instance.format],
      'mirror': instance.mirror,
    };

const _$ImageFileFormatEnumMap = {
  ImageFileFormat.JPEG: 0,
  ImageFileFormat.PNG: 1,
  ImageFileFormat.BMP: 2,
};

RtcNetworkQuality _$RtcNetworkQualityFromJson(Map<String, dynamic> json) =>
    RtcNetworkQuality(
      rating: $enumDecodeNullable(_$QualityRatingEnumMap, json['rating']) ??
          QualityRating.Unavailable,
      txLoss: (json['txLoss'] as num?)?.toDouble() ?? 0,
      rxLoss: (json['rxLoss'] as num?)?.toDouble() ?? 0,
      rtt: json['rtt'] as int? ?? 0,
    );

Map<String, dynamic> _$RtcNetworkQualityToJson(RtcNetworkQuality instance) =>
    <String, dynamic>{
      'rating': _$QualityRatingEnumMap[instance.rating],
      'txLoss': instance.txLoss,
      'rxLoss': instance.rxLoss,
      'rtt': instance.rtt,
    };

const _$QualityRatingEnumMap = {
  QualityRating.Unavailable: 0,
  QualityRating.VeryBad: 1,
  QualityRating.Bad: 2,
  QualityRating.Poor: 3,
  QualityRating.Good: 4,
  QualityRating.Excellent: 5,
};

_$GroupConfigFromJson(Map<String, dynamic> json) =>
    GroupConfig(
      json['userData'] as String? ?? ''
    );

Map<String, dynamic> _$GroupConfigToJson(GroupConfig instance) =>
    <String, dynamic>{'userData': instance.userData};

_$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
    json['userId'] as String,
    json['userData'] as String? ?? ''
);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) =>
    <String, dynamic>{'userId': instance.userId, 'userData': instance.userData};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rtc_objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RtcEngineConfig _$RtcEngineConfigFromJson(Map<String, dynamic> json) {
  return RtcEngineConfig(
    json['appId'] as String,
    json['rtcServer'] as String,
    videoCodecHwAcceleration: json['videoCodecHwAcceleration'] as bool,
    audioScenario: json['audioScenario'] as int,
  );
}

Map<String, dynamic> _$RtcEngineConfigToJson(RtcEngineConfig instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'rtcServer': instance.rtcServer,
      'videoCodecHwAcceleration': instance.videoCodecHwAcceleration,
      'audioScenario': instance.audioScenario,
    };

RtcChannelConfig _$RtcChannelConfigFromJson(Map<String, dynamic> json) {
  return RtcChannelConfig(
    mode: _$enumDecodeNullable(_$ChannelModeEnumMap, json['mode']),
    serviceFlags: (json['serviceFlags'] as List)
        ?.map((e) => _$enumDecodeNullable(_$ChannelServiceEnumMap, e))
        ?.toSet(),
    subscribeAudioAll: json['subscribeAudioAll'] as bool,
    userName: json['userName'] as String,
  );
}

Map<String, dynamic> _$RtcChannelConfigToJson(RtcChannelConfig instance) =>
    <String, dynamic>{
      'mode': _$ChannelModeEnumMap[instance.mode],
      'serviceFlags': instance.serviceFlags
          ?.map((e) => _$ChannelServiceEnumMap[e])
          ?.toList(),
      'subscribeAudioAll': instance.subscribeAudioAll,
      'userName': instance.userName,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ChannelModeEnumMap = {
  ChannelMode.OneOnOne: 0,
  ChannelMode.Meeting: 1,
};

const _$ChannelServiceEnumMap = {
  ChannelService.Media: 1,
  ChannelService.Whiteboard: 2,
};

RtcRenderConfig _$RtcRenderConfigFromJson(Map<String, dynamic> json) {
  return RtcRenderConfig(
    profileType:
        _$enumDecodeNullable(_$VideoProfileTypeEnumMap, json['profileType']),
    sourceMirror: json['sourceMirror'] as bool,
    scalingMode:
        _$enumDecodeNullable(_$VideoScalingModeEnumMap, json['scalingMode']),
    mirror: json['mirror'] as bool,
  );
}

Map<String, dynamic> _$RtcRenderConfigToJson(RtcRenderConfig instance) =>
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

RtcAudioFormat _$RtcAudioFormatFromJson(Map<String, dynamic> json) {
  return RtcAudioFormat(
    type: _$enumDecodeNullable(_$AudioTypeEnumMap, json['type']),
    channels: json['channels'] as int,
    sampleRate: json['sampleRate'] as int,
    bytesPerSample: json['bytesPerSample'] as int,
  );
}

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

RtcVideoFormat _$RtcVideoFormatFromJson(Map<String, dynamic> json) {
  return RtcVideoFormat(
    (json['offset'] as List)?.map((e) => e as int)?.toList(),
    (json['stride'] as List)?.map((e) => e as int)?.toList(),
    type: _$enumDecodeNullable(_$VideoTypeEnumMap, json['type']),
    width: json['width'] as int,
    height: json['height'] as int,
    count: json['count'] as int,
    rotation: _$enumDecodeNullable(_$VideoRotationEnumMap, json['rotation']),
  );
}

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

RtcAudioLevel _$RtcAudioLevelFromJson(Map<String, dynamic> json) {
  return RtcAudioLevel(
    json['userId'] as String,
    level: json['level'] as int,
    active: json['active'] as bool,
  );
}

Map<String, dynamic> _$RtcAudioLevelToJson(RtcAudioLevel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'level': instance.level,
      'active': instance.active,
    };

RtcAudioProfile _$RtcAudioProfileFromJson(Map<String, dynamic> json) {
  return RtcAudioProfile(
    sampleRate:
        _$enumDecodeNullable(_$AudioSampleRateEnumMap, json['sampleRate']),
    channel: _$enumDecodeNullable(_$AudioChannelEnumMap, json['channel']),
    profileQuality: _$enumDecodeNullable(
        _$AudioProfileQualityEnumMap, json['profileQuality']),
  );
}

Map<String, dynamic> _$RtcAudioProfileToJson(RtcAudioProfile instance) =>
    <String, dynamic>{
      'sampleRate': _$AudioSampleRateEnumMap[instance.sampleRate],
      'channel': _$AudioChannelEnumMap[instance.channel],
      'profileQuality': _$AudioProfileQualityEnumMap[instance.profileQuality],
    };

const _$AudioSampleRateEnumMap = {
  AudioSampleRate.Rate16K: 16000,
  AudioSampleRate.Rate48K: 48000,
};

const _$AudioChannelEnumMap = {
  AudioChannel.Mono: 1,
  AudioChannel.Stereo: 2,
};

const _$AudioProfileQualityEnumMap = {
  AudioProfileQuality.Default: 0,
  AudioProfileQuality.High: 1,
};

RtcAudioSendStats _$RtcAudioSendStatsFromJson(Map<String, dynamic> json) {
  return RtcAudioSendStats(
    json['bytesSent'] as int,
    json['sendBitrate'] as int,
    json['packetsLost'] as int,
    (json['lossRatio'] as num)?.toDouble(),
    json['rtt'] as int,
    json['inputLevel'] as int,
    json['inputActiveFlag'] as bool,
    _$enumDecodeNullable(_$AudioCodecTypeEnumMap, json['codecType']),
  );
}

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

RtcAudioRecvStats _$RtcAudioRecvStatsFromJson(Map<String, dynamic> json) {
  return RtcAudioRecvStats(
    json['userId'] as String,
    json['bytesRecv'] as int,
    json['recvBitrate'] as int,
    json['packetsLost'] as int,
    (json['lossRatio'] as num)?.toDouble(),
    json['outputLevel'] as int,
    _$enumDecodeNullable(_$AudioCodecTypeEnumMap, json['codecType']),
  );
}

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

RtcVideoSendStats _$RtcVideoSendStatsFromJson(Map<String, dynamic> json) {
  return RtcVideoSendStats(
    json['streamId'] as int,
    json['bytesSent'] as int,
    json['sendBitrate'] as int,
    json['packetsLost'] as int,
    (json['lossRatio'] as num)?.toDouble(),
    json['width'] as int,
    json['height'] as int,
    json['framerate'] as int,
    json['plisReceived'] as int,
    json['rtt'] as int,
    _$enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
  );
}

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

RtcVideoRecvStats _$RtcVideoRecvStatsFromJson(Map<String, dynamic> json) {
  return RtcVideoRecvStats(
    json['userId'] as String,
    json['streamId'] as int,
    json['bytesRecv'] as int,
    json['recvBitrate'] as int,
    json['packetsLost'] as int,
    (json['lossRatio'] as num)?.toDouble(),
    json['width'] as int,
    json['height'] as int,
    json['framerate'] as int,
    json['plisSent'] as int,
    _$enumDecodeNullable(_$VideoCodecTypeEnumMap, json['codecType']),
  );
}

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

RtcVideoSendBweStats _$RtcVideoSendBweStatsFromJson(Map<String, dynamic> json) {
  return RtcVideoSendBweStats(
    json['bandwidth'] as int,
    json['encodeBitrate'] as int,
    json['transmitBitrate'] as int,
    json['retransmitBitrate'] as int,
  );
}

Map<String, dynamic> _$RtcVideoSendBweStatsToJson(
        RtcVideoSendBweStats instance) =>
    <String, dynamic>{
      'bandwidth': instance.bandwidth,
      'encodeBitrate': instance.encodeBitrate,
      'transmitBitrate': instance.transmitBitrate,
      'retransmitBitrate': instance.retransmitBitrate,
    };

RtcVideoRecvBweStats _$RtcVideoRecvBweStatsFromJson(Map<String, dynamic> json) {
  return RtcVideoRecvBweStats(
    json['userId'] as String,
    json['bandwidth'] as int,
  );
}

Map<String, dynamic> _$RtcVideoRecvBweStatsToJson(
        RtcVideoRecvBweStats instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'bandwidth': instance.bandwidth,
    };

RtcSystemStats _$RtcSystemStatsFromJson(Map<String, dynamic> json) {
  return RtcSystemStats(
    json['totalCpuUsage'] as int,
    json['totalPhysMemory'] as int,
    json['workingSetSize'] as int,
    json['memoryUsage'] as int,
  );
}

Map<String, dynamic> _$RtcSystemStatsToJson(RtcSystemStats instance) =>
    <String, dynamic>{
      'totalCpuUsage': instance.totalCpuUsage,
      'totalPhysMemory': instance.totalPhysMemory,
      'workingSetSize': instance.workingSetSize,
      'memoryUsage': instance.memoryUsage,
    };

RtcDeviceInfo _$RtcDeviceInfoFromJson(Map<String, dynamic> json) {
  return RtcDeviceInfo(
    deviceId: json['deviceId'] as String,
    deviceName: json['deviceName'] as String,
  );
}

Map<String, dynamic> _$RtcDeviceInfoToJson(RtcDeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
    };

RtcScreenSourceInfo _$RtcScreenSourceInfoFromJson(Map<String, dynamic> json) {
  return RtcScreenSourceInfo(
    json['sourceId'] as int,
    json['sourceName'] as String,
  );
}

Map<String, dynamic> _$RtcScreenSourceInfoToJson(
        RtcScreenSourceInfo instance) =>
    <String, dynamic>{
      'sourceId': instance.sourceId,
      'sourceName': instance.sourceName,
    };

WBColor _$WBColorFromJson(Map<String, dynamic> json) {
  return WBColor(
    red: (json['red'] as num)?.toDouble(),
    green: (json['green'] as num)?.toDouble(),
    blue: (json['blue'] as num)?.toDouble(),
    alpha: (json['alpha'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$WBColorToJson(WBColor instance) => <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
      'alpha': instance.alpha,
    };

WBTextFormat _$WBTextFormatFromJson(Map<String, dynamic> json) {
  return WBTextFormat(
    style: _$enumDecodeNullable(_$WBFontStyleEnumMap, json['style']),
    size: json['size'] as int,
  );
}

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

WBStamp _$WBStampFromJson(Map<String, dynamic> json) {
  return WBStamp(
    resizable: json['resizable'] as bool,
  )
    ..stampId = json['stampId'] as String
    ..path = json['path'] as String;
}

Map<String, dynamic> _$WBStampToJson(WBStamp instance) => <String, dynamic>{
      'stampId': instance.stampId,
      'path': instance.path,
      'resizable': instance.resizable,
    };

WBDocContents _$WBDocContentsFromJson(Map<String, dynamic> json) {
  return WBDocContents(
    json['name'] as String,
    (json['urls'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$WBDocContentsToJson(WBDocContents instance) =>
    <String, dynamic>{
      'name': instance.name,
      'urls': instance.urls,
    };

WBConvertConfig _$WBConvertConfigFromJson(Map<String, dynamic> json) {
  return WBConvertConfig(
    type: _$enumDecodeNullable(_$WBConvertTypeEnumMap, json['type']),
    needThumb: json['needThumb'] as bool,
  );
}

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

WBDocInfo _$WBDocInfoFromJson(Map<String, dynamic> json) {
  return WBDocInfo(
    json['fileId'] as String,
    json['name'] as String,
    json['creator'] as String,
    _$enumDecodeNullable(_$WBDocTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$WBDocInfoToJson(WBDocInfo instance) => <String, dynamic>{
      'fileId': instance.fileId,
      'name': instance.name,
      'creator': instance.creator,
      'type': _$WBDocTypeEnumMap[instance.type],
    };

const _$WBDocTypeEnumMap = {
  WBDocType.Normal: 1,
  WBDocType.H5: 2,
};

FaceBeautifyOption _$FaceBeautifyOptionFromJson(Map<String, dynamic> json) {
  return FaceBeautifyOption(
    enable: json['enable'] as bool,
    intensity: (json['intensity'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$FaceBeautifyOptionToJson(FaceBeautifyOption instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'intensity': instance.intensity,
    };

BuiltinTransformOption _$BuiltinTransformOptionFromJson(
    Map<String, dynamic> json) {
  return BuiltinTransformOption(
    enable: json['enable'] as bool,
    bReset: json['bReset'] as bool,
    xScaling: (json['xScaling'] as num)?.toDouble(),
    yScaling: (json['yScaling'] as num)?.toDouble(),
    xRotation: (json['xRotation'] as num)?.toDouble(),
    yRotation: (json['yRotation'] as num)?.toDouble(),
    zRotation: (json['zRotation'] as num)?.toDouble(),
    xProjection: (json['xProjection'] as num)?.toDouble(),
    yProjection: (json['yProjection'] as num)?.toDouble(),
  );
}

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

QuadTransformOption _$QuadTransformOptionFromJson(Map<String, dynamic> json) {
  return QuadTransformOption(
    enable: json['enable'] as bool,
    bReset: json['bReset'] as bool,
    index: _$enumDecodeNullable(_$QuadIndexEnumMap, json['index']),
    xDeltaAxis: (json['xDeltaAxis'] as num)?.toDouble(),
    yDeltaAxis: (json['yDeltaAxis'] as num)?.toDouble(),
    bMirror: json['bMirror'] as bool,
  );
}

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

FeedbackInfo _$FeedbackInfoFromJson(Map<String, dynamic> json) {
  return FeedbackInfo(
    _$enumDecodeNullable(_$FeedbackTypeEnumMap, json['type']),
    json['productName'] as String,
    json['detailDescription'] as String,
    contact: json['contact'] as String,
    extraInfo: json['extraInfo'] as String,
    uploadLogs: json['uploadLogs'] as bool,
  );
}

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

RtcAudioMixingConfig _$RtcAudioMixingConfigFromJson(Map<String, dynamic> json) {
  return RtcAudioMixingConfig(
    enablePublish: json['enablePublish'] as bool,
    publishVolume: json['publishVolume'] as int,
    enableLoopback: json['enableLoopback'] as bool,
    loopbackVolume: json['loopbackVolume'] as int,
    cycle: json['cycle'] as int,
    replaceMicrophone: json['replaceMicrophone'] as bool,
  );
}

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
    Map<String, dynamic> json) {
  return RtcSnapshotVideoOption(
    format: _$enumDecodeNullable(_$ImageFileFormatEnumMap, json['format']),
    mirror: json['mirror'] as bool,
  );
}

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

RtcNetworkQuality _$RtcNetworkQualityFromJson(Map<String, dynamic> json) {
  return RtcNetworkQuality(
    rating: _$enumDecodeNullable(_$QualityRatingEnumMap, json['rating']),
    txLoss: (json['txLoss'] as num)?.toDouble(),
    rxLoss: (json['rxLoss'] as num)?.toDouble(),
    rtt: json['rtt'] as int,
  );
}

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

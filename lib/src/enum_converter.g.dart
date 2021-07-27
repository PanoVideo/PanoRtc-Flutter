// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_converter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultCodeConverter _$ResultCodeConverterFromJson(Map<String, dynamic> json) {
  return ResultCodeConverter(
    _$enumDecodeNullable(_$ResultCodeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$ResultCodeConverterToJson(
        ResultCodeConverter instance) =>
    <String, dynamic>{
      'e': _$ResultCodeEnumMap[instance.e],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ResultCodeEnumMap = {
  ResultCode.OK: 0,
  ResultCode.Failed: -1,
  ResultCode.Fatal: -2,
  ResultCode.InvalidArgs: -3,
  ResultCode.InvalidState: -4,
  ResultCode.InvalidIndex: -5,
  ResultCode.AlreadyExist: -6,
  ResultCode.NotExist: -7,
  ResultCode.NotFound: -8,
  ResultCode.NotSupported: -9,
  ResultCode.NotImplemented: -10,
  ResultCode.NotInitialized: -11,
  ResultCode.LimitReached: -12,
  ResultCode.NoPrivilege: -13,
  ResultCode.InProgress: -14,
  ResultCode.WrongThread: -15,
  ResultCode.AuthFailed: -101,
  ResultCode.UserRejected: -102,
  ResultCode.UserExpelled: -103,
  ResultCode.UserDuplicate: -104,
  ResultCode.ChannelClosed: -151,
  ResultCode.ChannelFull: -152,
  ResultCode.ChannelLocked: -153,
  ResultCode.ChannelModeMismatch: -154,
  ResultCode.NetworkError: -301,
};

FailoverStateConverter _$FailoverStateConverterFromJson(
    Map<String, dynamic> json) {
  return FailoverStateConverter(
    _$enumDecodeNullable(_$FailoverStateEnumMap, json['e']),
  );
}

Map<String, dynamic> _$FailoverStateConverterToJson(
        FailoverStateConverter instance) =>
    <String, dynamic>{
      'e': _$FailoverStateEnumMap[instance.e],
    };

const _$FailoverStateEnumMap = {
  FailoverState.Reconnecting: 0,
  FailoverState.Success: 1,
  FailoverState.Failed: 2,
};

ChannelModeConverter _$ChannelModeConverterFromJson(Map<String, dynamic> json) {
  return ChannelModeConverter(
    _$enumDecodeNullable(_$ChannelModeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$ChannelModeConverterToJson(
        ChannelModeConverter instance) =>
    <String, dynamic>{
      'e': _$ChannelModeEnumMap[instance.e],
    };

const _$ChannelModeEnumMap = {
  ChannelMode.OneOnOne: 0,
  ChannelMode.Meeting: 1,
};

ChannelServiceConverter _$ChannelServiceConverterFromJson(
    Map<String, dynamic> json) {
  return ChannelServiceConverter(
    _$enumDecodeNullable(_$ChannelServiceEnumMap, json['e']),
  );
}

Map<String, dynamic> _$ChannelServiceConverterToJson(
        ChannelServiceConverter instance) =>
    <String, dynamic>{
      'e': _$ChannelServiceEnumMap[instance.e],
    };

const _$ChannelServiceEnumMap = {
  ChannelService.Media: 1,
  ChannelService.Whiteboard: 2,
  ChannelService.Message: 4,
};

UserLeaveReasonConverter _$UserLeaveReasonConverterFromJson(
    Map<String, dynamic> json) {
  return UserLeaveReasonConverter(
    _$enumDecodeNullable(_$UserLeaveReasonEnumMap, json['e']),
  );
}

Map<String, dynamic> _$UserLeaveReasonConverterToJson(
        UserLeaveReasonConverter instance) =>
    <String, dynamic>{
      'e': _$UserLeaveReasonEnumMap[instance.e],
    };

const _$UserLeaveReasonEnumMap = {
  UserLeaveReason.Normal: 0,
  UserLeaveReason.Expelled: 1,
  UserLeaveReason.Disconnected: 2,
  UserLeaveReason.ChannelEnd: 3,
  UserLeaveReason.DuplicateUserID: 4,
};

SubscribeResultConverter _$SubscribeResultConverterFromJson(
    Map<String, dynamic> json) {
  return SubscribeResultConverter(
    _$enumDecodeNullable(_$SubscribeResultEnumMap, json['e']),
  );
}

Map<String, dynamic> _$SubscribeResultConverterToJson(
        SubscribeResultConverter instance) =>
    <String, dynamic>{
      'e': _$SubscribeResultEnumMap[instance.e],
    };

const _$SubscribeResultEnumMap = {
  SubscribeResult.Success: 0,
  SubscribeResult.Failed: 1,
  SubscribeResult.UserNotFound: 2,
  SubscribeResult.LimitReached: 3,
};

VideoProfileTypeConverter _$VideoProfileTypeConverterFromJson(
    Map<String, dynamic> json) {
  return VideoProfileTypeConverter(
    _$enumDecodeNullable(_$VideoProfileTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$VideoProfileTypeConverterToJson(
        VideoProfileTypeConverter instance) =>
    <String, dynamic>{
      'e': _$VideoProfileTypeEnumMap[instance.e],
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

VideoScalingModeConverter _$VideoScalingModeConverterFromJson(
    Map<String, dynamic> json) {
  return VideoScalingModeConverter(
    _$enumDecodeNullable(_$VideoScalingModeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$VideoScalingModeConverterToJson(
        VideoScalingModeConverter instance) =>
    <String, dynamic>{
      'e': _$VideoScalingModeEnumMap[instance.e],
    };

const _$VideoScalingModeEnumMap = {
  VideoScalingMode.Fit: 0,
  VideoScalingMode.FullFill: 1,
  VideoScalingMode.CropFill: 2,
};

AudioTypeConverter _$AudioTypeConverterFromJson(Map<String, dynamic> json) {
  return AudioTypeConverter(
    _$enumDecodeNullable(_$AudioTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$AudioTypeConverterToJson(AudioTypeConverter instance) =>
    <String, dynamic>{
      'e': _$AudioTypeEnumMap[instance.e],
    };

const _$AudioTypeEnumMap = {
  AudioType.PCM: 0,
};

VideoTypeConverter _$VideoTypeConverterFromJson(Map<String, dynamic> json) {
  return VideoTypeConverter(
    _$enumDecodeNullable(_$VideoTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$VideoTypeConverterToJson(VideoTypeConverter instance) =>
    <String, dynamic>{
      'e': _$VideoTypeEnumMap[instance.e],
    };

const _$VideoTypeEnumMap = {
  VideoType.I420: 0,
};

VideoRotationConverter _$VideoRotationConverterFromJson(
    Map<String, dynamic> json) {
  return VideoRotationConverter(
    _$enumDecodeNullable(_$VideoRotationEnumMap, json['e']),
  );
}

Map<String, dynamic> _$VideoRotationConverterToJson(
        VideoRotationConverter instance) =>
    <String, dynamic>{
      'e': _$VideoRotationEnumMap[instance.e],
    };

const _$VideoRotationEnumMap = {
  VideoRotation.Rotation0: 0,
  VideoRotation.Rotation90: 90,
  VideoRotation.Rotation180: 180,
  VideoRotation.Rotation270: 270,
};

AudioDeviceTypeConverter _$AudioDeviceTypeConverterFromJson(
    Map<String, dynamic> json) {
  return AudioDeviceTypeConverter(
    _$enumDecodeNullable(_$AudioDeviceTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$AudioDeviceTypeConverterToJson(
        AudioDeviceTypeConverter instance) =>
    <String, dynamic>{
      'e': _$AudioDeviceTypeEnumMap[instance.e],
    };

const _$AudioDeviceTypeEnumMap = {
  AudioDeviceType.Unknown: 0,
  AudioDeviceType.Record: 1,
  AudioDeviceType.Playout: 2,
};

AudioDeviceStateConverter _$AudioDeviceStateConverterFromJson(
    Map<String, dynamic> json) {
  return AudioDeviceStateConverter(
    _$enumDecodeNullable(_$AudioDeviceStateEnumMap, json['e']),
  );
}

Map<String, dynamic> _$AudioDeviceStateConverterToJson(
        AudioDeviceStateConverter instance) =>
    <String, dynamic>{
      'e': _$AudioDeviceStateEnumMap[instance.e],
    };

const _$AudioDeviceStateEnumMap = {
  AudioDeviceState.Active: 0,
  AudioDeviceState.Inactive: 1,
};

VideoDeviceTypeConverter _$VideoDeviceTypeConverterFromJson(
    Map<String, dynamic> json) {
  return VideoDeviceTypeConverter(
    _$enumDecodeNullable(_$VideoDeviceTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$VideoDeviceTypeConverterToJson(
        VideoDeviceTypeConverter instance) =>
    <String, dynamic>{
      'e': _$VideoDeviceTypeEnumMap[instance.e],
    };

const _$VideoDeviceTypeEnumMap = {
  VideoDeviceType.Unknown: 0,
  VideoDeviceType.Capture: 1,
};

VideoDeviceStateConverter _$VideoDeviceStateConverterFromJson(
    Map<String, dynamic> json) {
  return VideoDeviceStateConverter(
    _$enumDecodeNullable(_$VideoDeviceStateEnumMap, json['e']),
  );
}

Map<String, dynamic> _$VideoDeviceStateConverterToJson(
        VideoDeviceStateConverter instance) =>
    <String, dynamic>{
      'e': _$VideoDeviceStateEnumMap[instance.e],
    };

const _$VideoDeviceStateEnumMap = {
  VideoDeviceState.Added: 0,
  VideoDeviceState.Removed: 1,
};

VideoCaptureStateConverter _$VideoCaptureStateConverterFromJson(
    Map<String, dynamic> json) {
  return VideoCaptureStateConverter(
    _$enumDecodeNullable(_$VideoCaptureStateEnumMap, json['e']),
  );
}

Map<String, dynamic> _$VideoCaptureStateConverterToJson(
        VideoCaptureStateConverter instance) =>
    <String, dynamic>{
      'e': _$VideoCaptureStateEnumMap[instance.e],
    };

const _$VideoCaptureStateEnumMap = {
  VideoCaptureState.Unknown: 0,
  VideoCaptureState.Normal: 1,
  VideoCaptureState.Suspended: 2,
};

ScreenCaptureStateConverter _$ScreenCaptureStateConverterFromJson(
    Map<String, dynamic> json) {
  return ScreenCaptureStateConverter(
    _$enumDecodeNullable(_$ScreenCaptureStateEnumMap, json['e']),
  );
}

Map<String, dynamic> _$ScreenCaptureStateConverterToJson(
        ScreenCaptureStateConverter instance) =>
    <String, dynamic>{
      'e': _$ScreenCaptureStateEnumMap[instance.e],
    };

const _$ScreenCaptureStateEnumMap = {
  ScreenCaptureState.Unknown: 0,
  ScreenCaptureState.Normal: 1,
  ScreenCaptureState.Stopped: 2,
};

ScreenSourceTypeConverter _$ScreenSourceTypeConverterFromJson(
    Map<String, dynamic> json) {
  return ScreenSourceTypeConverter(
    _$enumDecodeNullable(_$ScreenSourceTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$ScreenSourceTypeConverterToJson(
        ScreenSourceTypeConverter instance) =>
    <String, dynamic>{
      'e': _$ScreenSourceTypeEnumMap[instance.e],
    };

const _$ScreenSourceTypeEnumMap = {
  ScreenSourceType.Screen: 0,
  ScreenSourceType.Applicaition: 1,
  ScreenSourceType.Window: 2,
};

ScreenScalingRatioConverter _$ScreenScalingRatioConverterFromJson(
    Map<String, dynamic> json) {
  return ScreenScalingRatioConverter(
    _$enumDecodeNullable(_$ScreenScalingRatioEnumMap, json['e']),
  );
}

Map<String, dynamic> _$ScreenScalingRatioConverterToJson(
        ScreenScalingRatioConverter instance) =>
    <String, dynamic>{
      'e': _$ScreenScalingRatioEnumMap[instance.e],
    };

const _$ScreenScalingRatioEnumMap = {
  ScreenScalingRatio.FitRatio: 0,
  ScreenScalingRatio.OriginalRatio: 1,
};

WBRoleTypeConverter _$WBRoleTypeConverterFromJson(Map<String, dynamic> json) {
  return WBRoleTypeConverter(
    _$enumDecodeNullable(_$WBRoleTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$WBRoleTypeConverterToJson(
        WBRoleTypeConverter instance) =>
    <String, dynamic>{
      'e': _$WBRoleTypeEnumMap[instance.e],
    };

const _$WBRoleTypeEnumMap = {
  WBRoleType.Admin: 0,
  WBRoleType.Attendee: 1,
  WBRoleType.Viewer: 2,
};

WBToolTypeConverter _$WBToolTypeConverterFromJson(Map<String, dynamic> json) {
  return WBToolTypeConverter(
    _$enumDecodeNullable(_$WBToolTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$WBToolTypeConverterToJson(
        WBToolTypeConverter instance) =>
    <String, dynamic>{
      'e': _$WBToolTypeEnumMap[instance.e],
    };

const _$WBToolTypeEnumMap = {
  WBToolType.None: 0,
  WBToolType.Select: 1,
  WBToolType.Path: 2,
  WBToolType.Line: 3,
  WBToolType.Rect: 4,
  WBToolType.Ellipse: 5,
  WBToolType.Image: 6,
  WBToolType.Text: 7,
  WBToolType.Eraser: 8,
  WBToolType.Brush: 9,
  WBToolType.Arrow: 10,
  WBToolType.Polyline: 11,
  WBToolType.Polygon: 12,
  WBToolType.Arc: 13,
  WBToolType.Curve: 14,
  WBToolType.Laser: 15,
};

WBFillTypeConverter _$WBFillTypeConverterFromJson(Map<String, dynamic> json) {
  return WBFillTypeConverter(
    _$enumDecodeNullable(_$WBFillTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$WBFillTypeConverterToJson(
        WBFillTypeConverter instance) =>
    <String, dynamic>{
      'e': _$WBFillTypeEnumMap[instance.e],
    };

const _$WBFillTypeEnumMap = {
  WBFillType.None: 0,
  WBFillType.Color: 1,
};

WBFontStyleConverter _$WBFontStyleConverterFromJson(Map<String, dynamic> json) {
  return WBFontStyleConverter(
    _$enumDecodeNullable(_$WBFontStyleEnumMap, json['e']),
  );
}

Map<String, dynamic> _$WBFontStyleConverterToJson(
        WBFontStyleConverter instance) =>
    <String, dynamic>{
      'e': _$WBFontStyleEnumMap[instance.e],
    };

const _$WBFontStyleEnumMap = {
  WBFontStyle.Normal: 0,
  WBFontStyle.Bold: 1,
  WBFontStyle.Italic: 2,
  WBFontStyle.BoldItalic: 3,
};

WBImageScalingModeConverter _$WBImageScalingModeConverterFromJson(
    Map<String, dynamic> json) {
  return WBImageScalingModeConverter(
    _$enumDecodeNullable(_$WBImageScalingModeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$WBImageScalingModeConverterToJson(
        WBImageScalingModeConverter instance) =>
    <String, dynamic>{
      'e': _$WBImageScalingModeEnumMap[instance.e],
    };

const _$WBImageScalingModeEnumMap = {
  WBImageScalingMode.Fit: 0,
  WBImageScalingMode.AutoFill: 1,
  WBImageScalingMode.FillWidth: 2,
  WBImageScalingMode.FillHeight: 3,
  WBImageScalingMode.FitCenter: 4,
};

WBImageStateConverter _$WBImageStateConverterFromJson(
    Map<String, dynamic> json) {
  return WBImageStateConverter(
    _$enumDecodeNullable(_$WBImageStateEnumMap, json['e']),
  );
}

Map<String, dynamic> _$WBImageStateConverterToJson(
        WBImageStateConverter instance) =>
    <String, dynamic>{
      'e': _$WBImageStateEnumMap[instance.e],
    };

const _$WBImageStateEnumMap = {
  WBImageState.LoadStart: 0,
  WBImageState.LoadComplete: 1,
  WBImageState.LoadFail: 2,
};

WBConvertTypeConverter _$WBConvertTypeConverterFromJson(
    Map<String, dynamic> json) {
  return WBConvertTypeConverter(
    _$enumDecodeNullable(_$WBConvertTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$WBConvertTypeConverterToJson(
        WBConvertTypeConverter instance) =>
    <String, dynamic>{
      'e': _$WBConvertTypeEnumMap[instance.e],
    };

const _$WBConvertTypeEnumMap = {
  WBConvertType.JPG: 1,
  WBConvertType.PNG: 2,
  WBConvertType.H5: 3,
};

WBClearTypeConverter _$WBClearTypeConverterFromJson(Map<String, dynamic> json) {
  return WBClearTypeConverter(
    _$enumDecodeNullable(_$WBClearTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$WBClearTypeConverterToJson(
        WBClearTypeConverter instance) =>
    <String, dynamic>{
      'e': _$WBClearTypeEnumMap[instance.e],
    };

const _$WBClearTypeEnumMap = {
  WBClearType.Draws: 1,
  WBClearType.BackgroundImage: 2,
  WBClearType.All: 255,
};

WBDocTypeConverter _$WBDocTypeConverterFromJson(Map<String, dynamic> json) {
  return WBDocTypeConverter(
    _$enumDecodeNullable(_$WBDocTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$WBDocTypeConverterToJson(WBDocTypeConverter instance) =>
    <String, dynamic>{
      'e': _$WBDocTypeEnumMap[instance.e],
    };

const _$WBDocTypeEnumMap = {
  WBDocType.Normal: 1,
  WBDocType.H5: 2,
};

WBSnapshotModeConverter _$WBSnapshotModeConverterFromJson(
    Map<String, dynamic> json) {
  return WBSnapshotModeConverter(
    _$enumDecodeNullable(_$WBSnapshotModeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$WBSnapshotModeConverterToJson(
        WBSnapshotModeConverter instance) =>
    <String, dynamic>{
      'e': _$WBSnapshotModeEnumMap[instance.e],
    };

const _$WBSnapshotModeEnumMap = {
  WBSnapshotMode.View: 0,
  WBSnapshotMode.All: 1,
};

WBOptionTypeConverter _$WBOptionTypeConverterFromJson(
    Map<String, dynamic> json) {
  return WBOptionTypeConverter(
    _$enumDecodeNullable(_$WBOptionTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$WBOptionTypeConverterToJson(
        WBOptionTypeConverter instance) =>
    <String, dynamic>{
      'e': _$WBOptionTypeEnumMap[instance.e],
    };

const _$WBOptionTypeEnumMap = {
  WBOptionType.FileCachePath: 1,
  WBOptionType.EnableUIResponse: 2,
  WBOptionType.ShowDraws: 3,
  WBOptionType.ScaleMove: 4,
  WBOptionType.AutoSelected: 5,
};

OptionTypeConverter _$OptionTypeConverterFromJson(Map<String, dynamic> json) {
  return OptionTypeConverter(
    _$enumDecodeNullable(_$OptionTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$OptionTypeConverterToJson(
        OptionTypeConverter instance) =>
    <String, dynamic>{
      'e': _$OptionTypeEnumMap[instance.e],
    };

const _$OptionTypeEnumMap = {
  OptionType.FaceBeautify: 0,
  OptionType.UploadLogs: 1,
  OptionType.UploadAudioDump: 2,
  OptionType.AudioEqualizationMode: 3,
  OptionType.AudioReverbMode: 4,
  OptionType.VideoFrameRate: 5,
  OptionType.AudioEarMonitoring: 6,
  OptionType.BuiltinTransform: 7,
  OptionType.UploadLogsAtFailure: 8,
  OptionType.CpuAdaption: 9,
  OptionType.AudioProfile: 10,
  OptionType.QuadTransform: 11,
  OptionType.ScreenOptimization: 17,
};

LogLevelConverter _$LogLevelConverterFromJson(Map<String, dynamic> json) {
  return LogLevelConverter(
    _$enumDecodeNullable(_$LogLevelEnumMap, json['e']),
  );
}

Map<String, dynamic> _$LogLevelConverterToJson(LogLevelConverter instance) =>
    <String, dynamic>{
      'e': _$LogLevelEnumMap[instance.e],
    };

const _$LogLevelEnumMap = {
  LogLevel.Fatal: 0,
  LogLevel.Error: 1,
  LogLevel.Warning: 2,
  LogLevel.Info: 3,
  LogLevel.Verbose: 4,
  LogLevel.Debug: 5,
};

FeedbackTypeConverter _$FeedbackTypeConverterFromJson(
    Map<String, dynamic> json) {
  return FeedbackTypeConverter(
    _$enumDecodeNullable(_$FeedbackTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$FeedbackTypeConverterToJson(
        FeedbackTypeConverter instance) =>
    <String, dynamic>{
      'e': _$FeedbackTypeEnumMap[instance.e],
    };

const _$FeedbackTypeEnumMap = {
  FeedbackType.General: 0,
  FeedbackType.Audio: 1,
  FeedbackType.Video: 2,
  FeedbackType.Whiteboard: 3,
  FeedbackType.Screen: 4,
};

AudioMixingStateConverter _$AudioMixingStateConverterFromJson(
    Map<String, dynamic> json) {
  return AudioMixingStateConverter(
    _$enumDecodeNullable(_$AudioMixingStateEnumMap, json['e']),
  );
}

Map<String, dynamic> _$AudioMixingStateConverterToJson(
        AudioMixingStateConverter instance) =>
    <String, dynamic>{
      'e': _$AudioMixingStateEnumMap[instance.e],
    };

const _$AudioMixingStateEnumMap = {
  AudioMixingState.Started: 0,
  AudioMixingState.Finished: 1,
};

ImageFileFormatConverter _$ImageFileFormatConverterFromJson(
    Map<String, dynamic> json) {
  return ImageFileFormatConverter(
    _$enumDecodeNullable(_$ImageFileFormatEnumMap, json['e']),
  );
}

Map<String, dynamic> _$ImageFileFormatConverterToJson(
        ImageFileFormatConverter instance) =>
    <String, dynamic>{
      'e': _$ImageFileFormatEnumMap[instance.e],
    };

const _$ImageFileFormatEnumMap = {
  ImageFileFormat.JPEG: 0,
  ImageFileFormat.PNG: 1,
  ImageFileFormat.BMP: 2,
};

AudioEqualizationModeConverter _$AudioEqualizationModeConverterFromJson(
    Map<String, dynamic> json) {
  return AudioEqualizationModeConverter(
    _$enumDecodeNullable(_$AudioEqualizationModeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$AudioEqualizationModeConverterToJson(
        AudioEqualizationModeConverter instance) =>
    <String, dynamic>{
      'e': _$AudioEqualizationModeEnumMap[instance.e],
    };

const _$AudioEqualizationModeEnumMap = {
  AudioEqualizationMode.None: 0,
  AudioEqualizationMode.Bass: 1,
  AudioEqualizationMode.Loud: 2,
  AudioEqualizationMode.VocalMusic: 3,
  AudioEqualizationMode.Strong: 4,
  AudioEqualizationMode.Pop: 5,
  AudioEqualizationMode.Live: 6,
  AudioEqualizationMode.DanceMusic: 7,
  AudioEqualizationMode.Club: 8,
  AudioEqualizationMode.Soft: 9,
  AudioEqualizationMode.Rock: 10,
  AudioEqualizationMode.Party: 11,
  AudioEqualizationMode.Classical: 12,
  AudioEqualizationMode.Test: 13,
};

AudioReverbModeConverter _$AudioReverbModeConverterFromJson(
    Map<String, dynamic> json) {
  return AudioReverbModeConverter(
    _$enumDecodeNullable(_$AudioReverbModeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$AudioReverbModeConverterToJson(
        AudioReverbModeConverter instance) =>
    <String, dynamic>{
      'e': _$AudioReverbModeEnumMap[instance.e],
    };

const _$AudioReverbModeEnumMap = {
  AudioReverbMode.None: 0,
  AudioReverbMode.VocalI: 1,
  AudioReverbMode.VocalII: 2,
  AudioReverbMode.Bathroom: 3,
  AudioReverbMode.SmallRoomBright: 4,
  AudioReverbMode.SmallRoomDark: 5,
  AudioReverbMode.MediumRoom: 6,
  AudioReverbMode.LargeRoom: 7,
  AudioReverbMode.ChurchHall: 8,
  AudioReverbMode.Cathedral: 9,
};

VideoFrameRateTypeConverter _$VideoFrameRateTypeConverterFromJson(
    Map<String, dynamic> json) {
  return VideoFrameRateTypeConverter(
    _$enumDecodeNullable(_$VideoFrameRateTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$VideoFrameRateTypeConverterToJson(
        VideoFrameRateTypeConverter instance) =>
    <String, dynamic>{
      'e': _$VideoFrameRateTypeEnumMap[instance.e],
    };

const _$VideoFrameRateTypeEnumMap = {
  VideoFrameRateType.Low: 0,
  VideoFrameRateType.Standard: 1,
};

VideoCodecTypeConverter _$VideoCodecTypeConverterFromJson(
    Map<String, dynamic> json) {
  return VideoCodecTypeConverter(
    _$enumDecodeNullable(_$VideoCodecTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$VideoCodecTypeConverterToJson(
        VideoCodecTypeConverter instance) =>
    <String, dynamic>{
      'e': _$VideoCodecTypeEnumMap[instance.e],
    };

const _$VideoCodecTypeEnumMap = {
  VideoCodecType.Unknown: 0,
  VideoCodecType.H264: 1,
  VideoCodecType.AV1: 2,
};

AudioCodecTypeConverter _$AudioCodecTypeConverterFromJson(
    Map<String, dynamic> json) {
  return AudioCodecTypeConverter(
    _$enumDecodeNullable(_$AudioCodecTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$AudioCodecTypeConverterToJson(
        AudioCodecTypeConverter instance) =>
    <String, dynamic>{
      'e': _$AudioCodecTypeEnumMap[instance.e],
    };

const _$AudioCodecTypeEnumMap = {
  AudioCodecType.Unknown: 0,
  AudioCodecType.G711: 1,
  AudioCodecType.G722: 2,
  AudioCodecType.ILBC: 3,
  AudioCodecType.ISAC: 4,
  AudioCodecType.OPUS: 5,
};

AudioSampleRateConverter _$AudioSampleRateConverterFromJson(
    Map<String, dynamic> json) {
  return AudioSampleRateConverter(
    _$enumDecodeNullable(_$AudioSampleRateEnumMap, json['e']),
  );
}

Map<String, dynamic> _$AudioSampleRateConverterToJson(
        AudioSampleRateConverter instance) =>
    <String, dynamic>{
      'e': _$AudioSampleRateEnumMap[instance.e],
    };

const _$AudioSampleRateEnumMap = {
  AudioSampleRate.Rate16K: 16000,
  AudioSampleRate.Rate48K: 48000,
};

AudioChannelConverter _$AudioChannelConverterFromJson(
    Map<String, dynamic> json) {
  return AudioChannelConverter(
    _$enumDecodeNullable(_$AudioChannelEnumMap, json['e']),
  );
}

Map<String, dynamic> _$AudioChannelConverterToJson(
        AudioChannelConverter instance) =>
    <String, dynamic>{
      'e': _$AudioChannelEnumMap[instance.e],
    };

const _$AudioChannelEnumMap = {
  AudioChannel.Mono: 1,
  AudioChannel.Stereo: 2,
};

AudioProfileQualityConverter _$AudioProfileQualityConverterFromJson(
    Map<String, dynamic> json) {
  return AudioProfileQualityConverter(
    _$enumDecodeNullable(_$AudioProfileQualityEnumMap, json['e']),
  );
}

Map<String, dynamic> _$AudioProfileQualityConverterToJson(
        AudioProfileQualityConverter instance) =>
    <String, dynamic>{
      'e': _$AudioProfileQualityEnumMap[instance.e],
    };

const _$AudioProfileQualityEnumMap = {
  AudioProfileQuality.Default: 0,
  AudioProfileQuality.High: 1,
};

QualityRatingConverter _$QualityRatingConverterFromJson(
    Map<String, dynamic> json) {
  return QualityRatingConverter(
    _$enumDecodeNullable(_$QualityRatingEnumMap, json['e']),
  );
}

Map<String, dynamic> _$QualityRatingConverterToJson(
        QualityRatingConverter instance) =>
    <String, dynamic>{
      'e': _$QualityRatingEnumMap[instance.e],
    };

const _$QualityRatingEnumMap = {
  QualityRating.Unavailable: 0,
  QualityRating.VeryBad: 1,
  QualityRating.Bad: 2,
  QualityRating.Poor: 3,
  QualityRating.Good: 4,
  QualityRating.Excellent: 5,
};

MediaProcessorTypeConverter _$MediaProcessorTypeConverterFromJson(
    Map<String, dynamic> json) {
  return MediaProcessorTypeConverter(
    _$enumDecodeNullable(_$MediaProcessorTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$MediaProcessorTypeConverterToJson(
        MediaProcessorTypeConverter instance) =>
    <String, dynamic>{
      'e': _$MediaProcessorTypeEnumMap[instance.e],
    };

const _$MediaProcessorTypeEnumMap = {
  MediaProcessorType.AudioCaptureExProcessor: 1,
  MediaProcessorType.AudioCaptureExEffectProcessor: 2,
  MediaProcessorType.AudioRenderExProcessor: 3,
  MediaProcessorType.VideoPreprocessor: 100,
};

QuadIndexConverter _$QuadIndexConverterFromJson(Map<String, dynamic> json) {
  return QuadIndexConverter(
    _$enumDecodeNullable(_$QuadIndexEnumMap, json['e']),
  );
}

Map<String, dynamic> _$QuadIndexConverterToJson(QuadIndexConverter instance) =>
    <String, dynamic>{
      'e': _$QuadIndexEnumMap[instance.e],
    };

const _$QuadIndexEnumMap = {
  QuadIndex.TopLeft: 0,
  QuadIndex.TopRight: 1,
  QuadIndex.BottomLeft: 2,
  QuadIndex.BottomRight: 3,
};

MessageServiceStateConverter _$MessageServiceStateConverterFromJson(
    Map<String, dynamic> json) {
  return MessageServiceStateConverter(
    _$enumDecodeNullable(_$MessageServiceStateEnumMap, json['e']),
  );
}

Map<String, dynamic> _$MessageServiceStateConverterToJson(
        MessageServiceStateConverter instance) =>
    <String, dynamic>{
      'e': _$MessageServiceStateEnumMap[instance.e],
    };

const _$MessageServiceStateEnumMap = {
  MessageServiceState.Unavailable: 0,
  MessageServiceState.Available: 1,
};

ActionTypeConverter _$ActionTypeConverterFromJson(Map<String, dynamic> json) {
  return ActionTypeConverter(
    _$enumDecodeNullable(_$ActionTypeEnumMap, json['e']),
  );
}

Map<String, dynamic> _$ActionTypeConverterToJson(
        ActionTypeConverter instance) =>
    <String, dynamic>{
      'e': _$ActionTypeEnumMap[instance.e],
    };

const _$ActionTypeEnumMap = {
  ActionType.Add: 0,
  ActionType.Update: 1,
  ActionType.Remove: 2,
};

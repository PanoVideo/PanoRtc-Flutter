// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

import 'rtc_enums.dart';

part 'enum_converter.g.dart';

abstract class EnumConverter<E, T> {
  E e;

  EnumConverter(this.e);

  EnumConverter.fromValue(Map<E, T> map, T t) {
    e = _$enumDecodeNullable(map, t);
  }

  T toValue(Map<E, T> map) {
    return map[e];
  }
}

@JsonSerializable()
class ResultCodeConverter extends EnumConverter<ResultCode, int> {
  ResultCodeConverter(ResultCode e) : super(e);

  ResultCodeConverter.fromValue(int value)
      : super.fromValue(_$ResultCodeEnumMap, value);

  int value() {
    return super.toValue(_$ResultCodeEnumMap);
  }
}

@JsonSerializable()
class FailoverStateConverter extends EnumConverter<FailoverState, int> {
  FailoverStateConverter(FailoverState e) : super(e);

  FailoverStateConverter.fromValue(int value)
      : super.fromValue(_$FailoverStateEnumMap, value);

  int value() {
    return super.toValue(_$FailoverStateEnumMap);
  }
}

@JsonSerializable()
class ChannelModeConverter extends EnumConverter<ChannelMode, int> {
  ChannelModeConverter(ChannelMode e) : super(e);

  ChannelModeConverter.fromValue(int value)
      : super.fromValue(_$ChannelModeEnumMap, value);

  int value() {
    return super.toValue(_$ChannelModeEnumMap);
  }
}

@JsonSerializable()
class ChannelServiceConverter extends EnumConverter<ChannelService, int> {
  ChannelServiceConverter(ChannelService e) : super(e);

  ChannelServiceConverter.fromValue(int value)
      : super.fromValue(_$ChannelServiceEnumMap, value);

  int value() {
    return super.toValue(_$ChannelServiceEnumMap);
  }
}

@JsonSerializable()
class UserLeaveReasonConverter extends EnumConverter<UserLeaveReason, int> {
  UserLeaveReasonConverter(UserLeaveReason e) : super(e);

  UserLeaveReasonConverter.fromValue(int value)
      : super.fromValue(_$UserLeaveReasonEnumMap, value);

  int value() {
    return super.toValue(_$UserLeaveReasonEnumMap);
  }
}

@JsonSerializable()
class SubscribeResultConverter extends EnumConverter<SubscribeResult, int> {
  SubscribeResultConverter(SubscribeResult e) : super(e);

  SubscribeResultConverter.fromValue(int value)
      : super.fromValue(_$SubscribeResultEnumMap, value);

  int value() {
    return super.toValue(_$SubscribeResultEnumMap);
  }
}

@JsonSerializable()
class VideoProfileTypeConverter extends EnumConverter<VideoProfileType, int> {
  VideoProfileTypeConverter(VideoProfileType e) : super(e);

  VideoProfileTypeConverter.fromValue(int value)
      : super.fromValue(_$VideoProfileTypeEnumMap, value);

  int value() {
    return super.toValue(_$VideoProfileTypeEnumMap);
  }
}

@JsonSerializable()
class VideoScalingModeConverter extends EnumConverter<VideoScalingMode, int> {
  VideoScalingModeConverter(VideoScalingMode e) : super(e);

  VideoScalingModeConverter.fromValue(int value)
      : super.fromValue(_$VideoScalingModeEnumMap, value);

  int value() {
    return super.toValue(_$VideoScalingModeEnumMap);
  }
}

@JsonSerializable()
class AudioTypeConverter extends EnumConverter<AudioType, int> {
  AudioTypeConverter(AudioType e) : super(e);

  AudioTypeConverter.fromValue(int value)
      : super.fromValue(_$AudioTypeEnumMap, value);

  int value() {
    return super.toValue(_$AudioTypeEnumMap);
  }
}

@JsonSerializable()
class VideoTypeConverter extends EnumConverter<VideoType, int> {
  VideoTypeConverter(VideoType e) : super(e);

  VideoTypeConverter.fromValue(int value)
      : super.fromValue(_$VideoTypeEnumMap, value);

  int value() {
    return super.toValue(_$VideoTypeEnumMap);
  }
}

@JsonSerializable()
class VideoRotationConverter extends EnumConverter<VideoRotation, int> {
  VideoRotationConverter(VideoRotation e) : super(e);

  VideoRotationConverter.fromValue(int value)
      : super.fromValue(_$VideoRotationEnumMap, value);

  int value() {
    return super.toValue(_$VideoRotationEnumMap);
  }
}

@JsonSerializable()
class AudioDeviceTypeConverter extends EnumConverter<AudioDeviceType, int> {
  AudioDeviceTypeConverter(AudioDeviceType e) : super(e);

  AudioDeviceTypeConverter.fromValue(int value)
      : super.fromValue(_$AudioDeviceTypeEnumMap, value);

  int value() {
    return super.toValue(_$AudioDeviceTypeEnumMap);
  }
}

@JsonSerializable()
class AudioDeviceStateConverter extends EnumConverter<AudioDeviceState, int> {
  AudioDeviceStateConverter(AudioDeviceState e) : super(e);

  AudioDeviceStateConverter.fromValue(int value)
      : super.fromValue(_$AudioDeviceStateEnumMap, value);

  int value() {
    return super.toValue(_$AudioDeviceStateEnumMap);
  }
}

@JsonSerializable()
class VideoDeviceTypeConverter extends EnumConverter<VideoDeviceType, int> {
  VideoDeviceTypeConverter(VideoDeviceType e) : super(e);

  VideoDeviceTypeConverter.fromValue(int value)
      : super.fromValue(_$VideoDeviceTypeEnumMap, value);

  int value() {
    return super.toValue(_$VideoDeviceTypeEnumMap);
  }
}

@JsonSerializable()
class VideoDeviceStateConverter extends EnumConverter<VideoDeviceState, int> {
  VideoDeviceStateConverter(VideoDeviceState e) : super(e);

  VideoDeviceStateConverter.fromValue(int value)
      : super.fromValue(_$VideoDeviceStateEnumMap, value);

  int value() {
    return super.toValue(_$VideoDeviceStateEnumMap);
  }
}

@JsonSerializable()
class VideoCaptureStateConverter extends EnumConverter<VideoCaptureState, int> {
  VideoCaptureStateConverter(VideoCaptureState e) : super(e);

  VideoCaptureStateConverter.fromValue(int value)
      : super.fromValue(_$VideoCaptureStateEnumMap, value);

  int value() {
    return super.toValue(_$VideoCaptureStateEnumMap);
  }
}

@JsonSerializable()
class ScreenCaptureStateConverter
    extends EnumConverter<ScreenCaptureState, int> {
  ScreenCaptureStateConverter(ScreenCaptureState e) : super(e);

  ScreenCaptureStateConverter.fromValue(int value)
      : super.fromValue(_$ScreenCaptureStateEnumMap, value);

  int value() {
    return super.toValue(_$ScreenCaptureStateEnumMap);
  }
}

@JsonSerializable()
class ScreenSourceTypeConverter extends EnumConverter<ScreenSourceType, int> {
  ScreenSourceTypeConverter(ScreenSourceType e) : super(e);

  ScreenSourceTypeConverter.fromValue(int value)
      : super.fromValue(_$ScreenSourceTypeEnumMap, value);

  int value() {
    return super.toValue(_$ScreenSourceTypeEnumMap);
  }
}

@JsonSerializable()
class ScreenScalingRatioConverter
    extends EnumConverter<ScreenScalingRatio, int> {
  ScreenScalingRatioConverter(ScreenScalingRatio e) : super(e);

  ScreenScalingRatioConverter.fromValue(int value)
      : super.fromValue(_$ScreenScalingRatioEnumMap, value);

  int value() {
    return super.toValue(_$ScreenScalingRatioEnumMap);
  }
}

@JsonSerializable()
class WBRoleTypeConverter extends EnumConverter<WBRoleType, int> {
  WBRoleTypeConverter(WBRoleType e) : super(e);

  WBRoleTypeConverter.fromValue(int value)
      : super.fromValue(_$WBRoleTypeEnumMap, value);

  int value() {
    return super.toValue(_$WBRoleTypeEnumMap);
  }
}

@JsonSerializable()
class WBToolTypeConverter extends EnumConverter<WBToolType, int> {
  WBToolTypeConverter(WBToolType e) : super(e);

  WBToolTypeConverter.fromValue(int value)
      : super.fromValue(_$WBToolTypeEnumMap, value);

  int value() {
    return super.toValue(_$WBToolTypeEnumMap);
  }
}

@JsonSerializable()
class WBFillTypeConverter extends EnumConverter<WBFillType, int> {
  WBFillTypeConverter(WBFillType e) : super(e);

  WBFillTypeConverter.fromValue(int value)
      : super.fromValue(_$WBFillTypeEnumMap, value);

  int value() {
    return super.toValue(_$WBFillTypeEnumMap);
  }
}

@JsonSerializable()
class WBFontStyleConverter extends EnumConverter<WBFontStyle, int> {
  WBFontStyleConverter(WBFontStyle e) : super(e);

  WBFontStyleConverter.fromValue(int value)
      : super.fromValue(_$WBFontStyleEnumMap, value);

  int value() {
    return super.toValue(_$WBFontStyleEnumMap);
  }
}

@JsonSerializable()
class WBImageScalingModeConverter
    extends EnumConverter<WBImageScalingMode, int> {
  WBImageScalingModeConverter(WBImageScalingMode e) : super(e);

  WBImageScalingModeConverter.fromValue(int value)
      : super.fromValue(_$WBImageScalingModeEnumMap, value);

  int value() {
    return super.toValue(_$WBImageScalingModeEnumMap);
  }
}

@JsonSerializable()
class WBImageStateConverter extends EnumConverter<WBImageState, int> {
  WBImageStateConverter(WBImageState e) : super(e);

  WBImageStateConverter.fromValue(int value)
      : super.fromValue(_$WBImageStateEnumMap, value);

  int value() {
    return super.toValue(_$WBImageStateEnumMap);
  }
}

@JsonSerializable()
class WBConvertTypeConverter extends EnumConverter<WBConvertType, int> {
  WBConvertTypeConverter(WBConvertType e) : super(e);

  WBConvertTypeConverter.fromValue(int value)
      : super.fromValue(_$WBConvertTypeEnumMap, value);

  int value() {
    return super.toValue(_$WBConvertTypeEnumMap);
  }
}

@JsonSerializable()
class WBClearTypeConverter extends EnumConverter<WBClearType, int> {
  WBClearTypeConverter(WBClearType e) : super(e);

  WBClearTypeConverter.fromValue(int value)
      : super.fromValue(_$WBClearTypeEnumMap, value);

  int value() {
    return super.toValue(_$WBClearTypeEnumMap);
  }
}

@JsonSerializable()
class WBDocTypeConverter extends EnumConverter<WBDocType, int> {
  WBDocTypeConverter(WBDocType e) : super(e);

  WBDocTypeConverter.fromValue(int value)
      : super.fromValue(_$WBDocTypeEnumMap, value);

  int value() {
    return super.toValue(_$WBDocTypeEnumMap);
  }
}

@JsonSerializable()
class WBSnapshotModeConverter extends EnumConverter<WBSnapshotMode, int> {
  WBSnapshotModeConverter(WBSnapshotMode e) : super(e);

  WBSnapshotModeConverter.fromValue(int value)
      : super.fromValue(_$WBSnapshotModeEnumMap, value);

  int value() {
    return super.toValue(_$WBSnapshotModeEnumMap);
  }
}

@JsonSerializable()
class WBOptionTypeConverter extends EnumConverter<WBOptionType, int> {
  WBOptionTypeConverter(WBOptionType e) : super(e);

  WBOptionTypeConverter.fromValue(int value)
      : super.fromValue(_$WBOptionTypeEnumMap, value);

  int value() {
    return super.toValue(_$WBOptionTypeEnumMap);
  }
}

@JsonSerializable()
class OptionTypeConverter extends EnumConverter<OptionType, int> {
  OptionTypeConverter(OptionType e) : super(e);

  OptionTypeConverter.fromValue(int value)
      : super.fromValue(_$OptionTypeEnumMap, value);

  int value() {
    return super.toValue(_$OptionTypeEnumMap);
  }
}

@JsonSerializable()
class LogLevelConverter extends EnumConverter<LogLevel, int> {
  LogLevelConverter(LogLevel e) : super(e);

  LogLevelConverter.fromValue(int value)
      : super.fromValue(_$LogLevelEnumMap, value);

  int value() {
    return super.toValue(_$LogLevelEnumMap);
  }
}

@JsonSerializable()
class FeedbackTypeConverter extends EnumConverter<FeedbackType, int> {
  FeedbackTypeConverter(FeedbackType e) : super(e);

  FeedbackTypeConverter.fromValue(int value)
      : super.fromValue(_$FeedbackTypeEnumMap, value);

  int value() {
    return super.toValue(_$FeedbackTypeEnumMap);
  }
}

@JsonSerializable()
class AudioMixingStateConverter extends EnumConverter<AudioMixingState, int> {
  AudioMixingStateConverter(AudioMixingState e) : super(e);

  AudioMixingStateConverter.fromValue(int value)
      : super.fromValue(_$AudioMixingStateEnumMap, value);

  int value() {
    return super.toValue(_$AudioMixingStateEnumMap);
  }
}

@JsonSerializable()
class ImageFileFormatConverter extends EnumConverter<ImageFileFormat, int> {
  ImageFileFormatConverter(ImageFileFormat e) : super(e);

  ImageFileFormatConverter.fromValue(int value)
      : super.fromValue(_$ImageFileFormatEnumMap, value);

  int value() {
    return super.toValue(_$ImageFileFormatEnumMap);
  }
}

@JsonSerializable()
class AudioEqualizationModeConverter
    extends EnumConverter<AudioEqualizationMode, int> {
  AudioEqualizationModeConverter(AudioEqualizationMode e) : super(e);

  AudioEqualizationModeConverter.fromValue(int value)
      : super.fromValue(_$AudioEqualizationModeEnumMap, value);

  int value() {
    return super.toValue(_$AudioEqualizationModeEnumMap);
  }
}

@JsonSerializable()
class AudioReverbModeConverter extends EnumConverter<AudioReverbMode, int> {
  AudioReverbModeConverter(AudioReverbMode e) : super(e);

  AudioReverbModeConverter.fromValue(int value)
      : super.fromValue(_$AudioReverbModeEnumMap, value);

  int value() {
    return super.toValue(_$AudioReverbModeEnumMap);
  }
}

@JsonSerializable()
class VideoFrameRateTypeConverter
    extends EnumConverter<VideoFrameRateType, int> {
  VideoFrameRateTypeConverter(VideoFrameRateType e) : super(e);

  VideoFrameRateTypeConverter.fromValue(int value)
      : super.fromValue(_$VideoFrameRateTypeEnumMap, value);

  int value() {
    return super.toValue(_$VideoFrameRateTypeEnumMap);
  }
}

@JsonSerializable()
class VideoCodecTypeConverter extends EnumConverter<VideoCodecType, int> {
  VideoCodecTypeConverter(VideoCodecType e) : super(e);

  VideoCodecTypeConverter.fromValue(int value)
      : super.fromValue(_$VideoCodecTypeEnumMap, value);

  int value() {
    return super.toValue(_$VideoCodecTypeEnumMap);
  }
}

@JsonSerializable()
class AudioCodecTypeConverter extends EnumConverter<AudioCodecType, int> {
  AudioCodecTypeConverter(AudioCodecType e) : super(e);

  AudioCodecTypeConverter.fromValue(int value)
      : super.fromValue(_$AudioCodecTypeEnumMap, value);

  int value() {
    return super.toValue(_$AudioCodecTypeEnumMap);
  }
}

@JsonSerializable()
class AudioSampleRateConverter extends EnumConverter<AudioSampleRate, int> {
  AudioSampleRateConverter(AudioSampleRate e) : super(e);

  AudioSampleRateConverter.fromValue(int value)
      : super.fromValue(_$AudioSampleRateEnumMap, value);

  int value() {
    return super.toValue(_$AudioSampleRateEnumMap);
  }
}

@JsonSerializable()
class AudioChannelConverter extends EnumConverter<AudioChannel, int> {
  AudioChannelConverter(AudioChannel e) : super(e);

  AudioChannelConverter.fromValue(int value)
      : super.fromValue(_$AudioChannelEnumMap, value);

  int value() {
    return super.toValue(_$AudioChannelEnumMap);
  }
}

@JsonSerializable()
class AudioProfileQualityConverter
    extends EnumConverter<AudioProfileQuality, int> {
  AudioProfileQualityConverter(AudioProfileQuality e) : super(e);

  AudioProfileQualityConverter.fromValue(int value)
      : super.fromValue(_$AudioProfileQualityEnumMap, value);

  int value() {
    return super.toValue(_$AudioProfileQualityEnumMap);
  }
}

@JsonSerializable()
class QualityRatingConverter extends EnumConverter<QualityRating, int> {
  QualityRatingConverter(QualityRating e) : super(e);

  QualityRatingConverter.fromValue(int value)
      : super.fromValue(_$QualityRatingEnumMap, value);

  int value() {
    return super.toValue(_$QualityRatingEnumMap);
  }
}

@JsonSerializable()
class MediaProcessorTypeConverter
    extends EnumConverter<MediaProcessorType, int> {
  MediaProcessorTypeConverter(MediaProcessorType e) : super(e);

  MediaProcessorTypeConverter.fromValue(int value)
      : super.fromValue(_$MediaProcessorTypeEnumMap, value);

  int value() {
    return super.toValue(_$MediaProcessorTypeEnumMap);
  }
}

@JsonSerializable()
class QuadIndexConverter extends EnumConverter<QuadIndex, int> {
  QuadIndexConverter(QuadIndex e) : super(e);

  QuadIndexConverter.fromValue(int value)
      : super.fromValue(_$QuadIndexEnumMap, value);

  int value() {
    return super.toValue(_$QuadIndexEnumMap);
  }
}

@JsonSerializable()
class MessageServiceStateConverter
    extends EnumConverter<MessageServiceState, int> {
  MessageServiceStateConverter(MessageServiceState e) : super(e);

  MessageServiceStateConverter.fromValue(int value)
      : super.fromValue(_$MessageServiceStateEnumMap, value);

  int value() {
    return super.toValue(_$MessageServiceStateEnumMap);
  }
}

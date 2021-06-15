import 'package:json_annotation/json_annotation.dart';

/// Result value.
///
/// **Note**
/// The result value returned by PANO methods, indicating the execution status.
///
/// 返回。
///
/// **Note**
/// PANO方法返回值，指示执行的情况。
enum ResultCode {
  /// Execution succeed
  ///
  /// 执行成功。
  @JsonValue(0)
  OK,

  /// Execution failed
  ///
  /// 执行失败。
  @JsonValue(-1)
  Failed,

  /// Fatal error
  ///
  /// 致命错误。
  @JsonValue(-2)
  Fatal,

  /// Invalid argument
  ///
  /// 非法参数。
  @JsonValue(-3)
  InvalidArgs,

  /// Invalid state
  ///
  /// 非法状态。
  @JsonValue(-4)
  InvalidState,

  /// Invalid index
  ///
  /// 无效索引。
  @JsonValue(-5)
  InvalidIndex,

  /// The object already exists
  ///
  /// 对象已存在。
  @JsonValue(-6)
  AlreadyExist,

  /// The object does not exist
  ///
  /// 对象不存在。
  @JsonValue(-7)
  NotExist,

  /// The object is not found
  ///
  /// 对象没发现。
  @JsonValue(-8)
  NotFound,

  /// The method is not supported
  ///
  /// 方法不支持。
  @JsonValue(-9)
  NotSupported,

  /// The method is not implemented
  ///
  /// 方法未实现。
  @JsonValue(-10)
  NotImplemented,

  /// The object is not initialized
  ///
  /// 对象未初始化。
  @JsonValue(-11)
  NotInitialized,

  /// The resource limit is reached
  ///
  /// 已达上限。
  @JsonValue(-12)
  LimitReached,

  /// No privilege to do
  ///
  /// 没有权限执行该操作。
  @JsonValue(-13)
  NoPrivilege,

  /// Operation in progress
  ///
  /// 操作正在进行中。
  @JsonValue(-14)
  InProgress,

  /// The operation thread is wrong
  ///
  /// 操作的线程错误。
  @JsonValue(-15)
  WrongThread,

  /// Authentication failed
  ///
  /// 认证失败。
  @JsonValue(-101)
  AuthFailed,

  /// The user is rejected
  ///
  /// 用户被拒绝。
  @JsonValue(-102)
  UserRejected,

  /// The user is expelled
  ///
  /// 用户被驱逐。
  @JsonValue(-103)
  UserExpelled,

  /// The user ID is duplicate
  ///
  /// 用户 ID 重复。
  @JsonValue(-104)
  UserDuplicate,

  /// The channel is closed
  ///
  /// 频道被关闭。
  @JsonValue(-151)
  ChannelClosed,

  /// The channel capacity is full
  ///
  /// 频道容量已满。
  @JsonValue(-152)
  ChannelFull,

  /// The channel is locked
  ///
  /// 频道被锁定。
  @JsonValue(-153)
  ChannelLocked,

  /// The channel mode is mismatch
  ///
  /// 频道模式不匹配。
  @JsonValue(-154)
  ChannelModeMismatch,

  /// A network error occurred
  ///
  /// 出现网络错误。
  @JsonValue(-301)
  NetworkError,
}

/// Failover state
///
/// 故障转移状态。
enum FailoverState {
  /// Failover is reconnecting
  ///
  /// 发生故障转移，正在重新连接。
  @JsonValue(0)
  Reconnecting,

  /// Failover succeeded
  ///
  /// 故障转移成功。
  @JsonValue(1)
  Success,

  /// Failover failed
  ///
  /// 故障转移失败。
  @JsonValue(2)
  Failed,
}

/// Channel mode
///
/// 频道模式。
enum ChannelMode {
  /// 1-on-1 channel mode
  ///
  /// 1对1频道模式。
  @JsonValue(0)
  OneOnOne,

  /// Meeting channel mode
  ///
  /// 会议频道模式。
  @JsonValue(1)
  Meeting,
}

/// Channel service flag
///
/// 频道服务标志。
enum ChannelService {
  /// Channel enable media service
  ///
  /// 频道启用媒体服务。
  @JsonValue(1 << 0)
  Media,

  /// Channel enable whiteboard service
  ///
  /// 频道启用白板服务。
  @JsonValue(1 << 1)
  Whiteboard,
}

/// User leave reason
///
/// 用户离开原因。
enum UserLeaveReason {
  /// The user leaves normally
  ///
  /// 用户正常离开。
  @JsonValue(0)
  Normal,

  /// The user is expelled
  ///
  /// 用户被驱逐。
  @JsonValue(1)
  Expelled,

  /// The user is disconnected
  ///
  /// 用户掉线。
  @JsonValue(2)
  Disconnected,

  /// Channel is end
  ///
  /// 频道结束
  @JsonValue(3)
  ChannelEnd,

  /// The user ID is duplicate
  ///
  /// 用户 ID 重复
  @JsonValue(4)
  DuplicateUserID,
}

/// The result to subscribe user media
///
/// 用户媒体订阅结果。
enum SubscribeResult {
  /// subscribe success
  ///
  /// 订阅成功。
  @JsonValue(0)
  Success,

  /// subscribe failed
  ///
  /// 订阅失败。
  @JsonValue(1)
  Failed,

  /// the user is not found
  ///
  /// 被订阅的用户不存在。
  @JsonValue(2)
  UserNotFound,

  /// the subscribe limit is reached
  ///
  /// 达到订阅上限。
  @JsonValue(3)
  LimitReached,
}

/// Video profile type
///
/// 视频设定类型。
enum VideoProfileType {
  /// The lowest video profile. Resolution：160 x 90 or 160 x 120, frame rate: 15 fps.
  ///
  /// 最低档视频设定。分辨率：160 x 90 或 160 x 120，帧率：15 帧/秒。
  @JsonValue(0)
  Lowest,

  /// The lower video profile. 320 x 180 or 320 x 240, frame rate: 15 fps.
  ///
  /// 低档视频设定。分辨率：320 x 180 或 320 x 240，帧率：15 帧/秒。
  @JsonValue(1)
  Low,

  /// The standard video profile. 640 x 360 or 640 x 480, frame rate: 30 fps.
  ///
  /// 标准档视频设定。分辨率：640 x 360 或 640 x 480，帧率：30 帧/秒。
  @JsonValue(2)
  Standard,

  /// The 720P video profile. 1280 x 720, frame rate: 30 fps.
  ///
  /// 高清档视频设定。分辨率：1280 x 720，帧率：30 帧/秒。
  @JsonValue(3)
  HD720P,

  /// The 1080P video profile. 1920 x 1080, frame rate: 30 fps.
  ///
  /// 全高清档视频设定。分辨率：1920 x 1080，帧率：30 帧/秒。
  @JsonValue(4)
  HD1080P,

  /// None video profile
  ///
  /// 无视频设定。
  @JsonValue(5)
  None,

  /// The max video profile
  ///
  /// 最高档视频设定。
  @JsonValue(4)
  Max,
}

/// Video scaling mode
///
/// 视频缩放模式。
enum VideoScalingMode {
  /// Fit the view, maintaining aspect ratio.
  ///
  /// 适合视图，保持宽高比。
  @JsonValue(0)
  Fit,

  /// Fully fill the view, without maintaining aspect ratio.
  ///
  /// 全填充视图，不保持宽高比。
  @JsonValue(1)
  FullFill,

  /// Crop and fill the view, maintaining aspect ratio.
  ///
  /// 裁剪并填充视图，保持宽高比。
  @JsonValue(2)
  CropFill,
}

/// Audio type
///
/// 音频类型。
enum AudioType {
  /// The standard form of digital audio
  ///
  /// 数字音频的标准形式。
  @JsonValue(0)
  PCM,
}

/// Video type
///
/// 视频类型。
enum VideoType {
  /// The YUV standard format 4:2:0
  ///
  /// YUV标准格式4:2:0。
  @JsonValue(0)
  I420,
}

/// Video rotation value
///
/// 视频旋转值。
enum VideoRotation {
  /// The video is rorated 0 degrees
  ///
  /// 视频旋转0度。
  @JsonValue(0)
  Rotation0,

  /// The video is rorated 90 degrees
  ///
  /// 视频旋转90度。
  @JsonValue(90)
  Rotation90,

  /// The video is rorated 180 degrees
  ///
  /// 视频旋转180度。
  @JsonValue(180)
  Rotation180,

  /// The video is rorated 270 degrees
  ///
  /// 视频旋转270度。
  @JsonValue(270)
  Rotation270,
}

/// Audio Device type
///
/// 音频设备类型。
enum AudioDeviceType {
  /// The unknown device
  ///
  /// 未知设备。
  @JsonValue(0)
  Unknown,

  /// The audio record device
  ///
  /// 录音设备。
  @JsonValue(1)
  Record,

  /// The audio playout device
  ///
  /// 音频播放设备。
  @JsonValue(2)
  Playout
}

/// Audio Device state
///
/// 音频设备状态。
enum AudioDeviceState {
  /// The device is actived
  ///
  /// 设备激活。
  @JsonValue(0)
  Active,

  /// The device is inactived
  ///
  /// 设备未激活。
  @JsonValue(1)
  Inactive,
}

/// Video device type
///
/// 视频设备类型。
enum VideoDeviceType {
  /// The unknown device
  ///
  /// 未知设备。
  @JsonValue(0)
  Unknown,

  /// The video capture device
  ///
  /// 视频抓取设备。
  @JsonValue(1)
  Capture
}

/// Video device state
///
/// 视频设备状态。
enum VideoDeviceState {
  /// The device is added
  ///
  /// 设备添加。
  @JsonValue(0)
  Added,

  /// The device is removed
  ///
  /// 设备移除。
  @JsonValue(1)
  Removed,
}

/// Video capture state
///
/// 视频采集状态。
enum VideoCaptureState {
  /// Unknown video capture state
  ///
  /// 未知视频采集状态。
  @JsonValue(0)
  Unknown,

  /// Video capture is normal
  ///
  /// 视频采集正常。
  @JsonValue(1)
  Normal,

  /// Video capture is suspended
  ///
  /// 视频采集暂停。
  @JsonValue(2)
  Suspended,
}

/// Screen Capture State.
///
/// 屏幕采集状态。
enum ScreenCaptureState {
  /// Unknown screen capture state.
  ///
  /// 未知屏幕采集状态。
  @JsonValue(0)
  Unknown,

  /// Screen capture is normal.
  ///
  /// 屏幕采集正常。
  @JsonValue(1)
  Normal,

  /// Screen capture is stopped.
  ///
  /// 屏幕采集停止。
  @JsonValue(2)
  Stopped,
}

/// Screen source type
///
/// 屏幕源类型。
enum ScreenSourceType {
  /// The source type is screen
  ///
  /// 屏幕型。
  @JsonValue(0)
  Screen,

  /// The source type is application
  ///
  /// 应用型。
  @JsonValue(1)
  Applicaition,

  /// The source type is window
  ///
  /// 窗口型。
  @JsonValue(2)
  Window,
}

/// Screen scaling ratio type
///
/// 屏幕缩放比例类型。
enum ScreenScalingRatio {
  /// The image ratio fitted for view
  ///
  /// 适合视图的图像比例。
  @JsonValue(0)
  FitRatio,

  /// The image original ratio
  ///
  /// 图像原始比例。
  @JsonValue(1)
  OriginalRatio,
}

/// Whiteboard role type
///
/// 白板角色类型。
enum WBRoleType {
  /// The admin role
  ///
  /// 白板管理员。
  @JsonValue(0)
  Admin,

  /// The normal attendee
  ///
  /// 普通白板参与者。
  @JsonValue(1)
  Attendee,

  /// The view only attendee
  ///
  /// 只看白板参与者。
  @JsonValue(2)
  Viewer,
}

/// Whiteboard tool type
///
/// 白板工具类型。
enum WBToolType {
  /// None tool
  ///
  /// 空。
  @JsonValue(0)
  None,

  /// Select tool
  ///
  /// 选择工具。
  @JsonValue(1)
  Select,

  /// Path tool
  ///
  /// 路径工具。
  @JsonValue(2)
  Path,

  /// Line tool
  ///
  /// 线条工具。
  @JsonValue(3)
  Line,

  /// Rectangle tool
  ///
  /// 矩形工具。
  @JsonValue(4)
  Rect,

  /// Ellipse tool
  ///
  /// 椭圆工具。
  @JsonValue(5)
  Ellipse,

  /// Image tool
  ///
  /// 图像工具。
  @JsonValue(6)
  Image,

  /// Text tool
  ///
  /// 文本工具。
  @JsonValue(7)
  Text,

  /// Eraser tool
  ///
  /// 橡皮擦工具。
  @JsonValue(8)
  Eraser,

  /// Brush tool
  ///
  /// 刷子工具。
  @JsonValue(9)
  Brush,

  /// Arrow tool
  ///
  /// 箭头工具。
  @JsonValue(10)
  Arrow,

  /// Polyline tool. Windows&MacOS only
  ///
  /// 折线工具。仅支持Windows及macOS平台。
  @JsonValue(11)
  Polyline,

  /// Polygon tool. Windows&MacOS only
  ///
  /// 多边形工具。仅支持Windows及macOS平台。
  @JsonValue(12)
  Polygon,

  /// Arc tool. Windows&MacOS only
  ///
  /// 弧线工具。仅支持Windows及macOS平台。
  @JsonValue(13)
  Arc,

  /// Curve tool. Windows&MacOS only
  ///
  /// 曲线工具。仅支持Windows及macOS平台。
  @JsonValue(14)
  Curve,

  /// LASER.
  ///
  /// 激光笔。
  @JsonValue(15)
  Laser,
}

/// Whiteboard fill type
///
/// 白板填充类型。
enum WBFillType {
  /// Fill none
  ///
  /// 不填充。
  @JsonValue(0)
  None,

  /// Fill color
  ///
  /// 填色。
  @JsonValue(1)
  Color,
}

/// Whiteboard font style
///
/// 白板字体样式。
enum WBFontStyle {
  /// Normal font
  ///
  /// 正常字体。
  @JsonValue(0)
  Normal,

  /// Bold font
  ///
  /// 粗体。
  @JsonValue(1)
  Bold,

  /// Italic font
  ///
  /// 斜体。
  @JsonValue(2)
  Italic,

  /// Bold italic font
  ///
  /// 粗斜体。
  @JsonValue(3)
  BoldItalic,
}

/// Whiteboard image scaling mode
///
/// 白板图片缩放模式。
enum WBImageScalingMode {
  /// Fit the view, maintaining aspect ratio.
  ///
  /// 适合视图，保持宽高比。
  @JsonValue(0)
  Fit,

  /// Fill the view automatically, maintaining aspect ratio, align top and left.
  ///
  /// 自动填充视图，保持宽高比，左上对齐。
  @JsonValue(1)
  AutoFill,

  /// Fill the view width, maintaining aspect ratio, align top.
  ///
  /// 按宽填充视图，保持宽高比，顶侧对齐。
  @JsonValue(2)
  FillWidth,

  /// Fill the view height, maintaining aspect ratio, align left.
  ///
  /// 按高填充视图，保持宽高比，左侧对齐。
  @JsonValue(3)
  FillHeight,

  /// Fit the view, maintaining aspect ratio, align center.
  ///
  /// 适合视图，保持宽高比，居中。
  @JsonValue(4)
  FitCenter,
}

/// Whiteboard image state
///
/// 白板图片状态码。
enum WBImageState {
  /// Start to load the image
  ///
  /// 开始加载图片。
  @JsonValue(0)
  LoadStart,

  /// The image load complete
  ///
  /// 图片加载成功。
  @JsonValue(1)
  LoadComplete,

  /// The image load failed
  ///
  /// 图片加载失败。
  @JsonValue(2)
  LoadFail,
}

/// Whiteboard file convert type.
///
/// 白板文件转码类型。
enum WBConvertType {
  /// JPG image.
  ///
  /// JPG图像。
  @JsonValue(1)
  JPG,

  /// PNG image.
  ///
  /// PNG图像。
  @JsonValue(2)
  PNG,

  /// H5 page.
  ///
  /// H5页面。
  @JsonValue(3)
  H5,
}

/// Whiteboard clear type
///
/// 白板清除类型。
enum WBClearType {
  /// clear whiteboard draws objects
  ///
  /// 清除白板绘制对象
  @JsonValue(1)
  Draws,

  /// clear whiteboard background image
  ///
  /// 清除白板背景图。
  @JsonValue(2)
  BackgroundImage,

  /// clear whiteboard all content
  ///
  /// 清除全部白板内容。
  @JsonValue(255)
  All,
}

/// Whiteboard file type.
///
/// 白板文件类型。
enum WBDocType {
  /// Normal type.
  ///
  /// 普通类型。
  @JsonValue(1)
  Normal,

  /// H5 type.
  ///
  /// H5类型。
  @JsonValue(2)
  H5,
}

/// Whiteboard snapshot mode
///
/// 白板快照模式。
enum WBSnapshotMode {
  /// snapshot whiteboard view area
  ///
  /// 截取白板视图区域
  @JsonValue(0)
  View,

  /// snapshot area with all objects.
  ///
  /// 截取所有白板对象。
  @JsonValue(1)
  All,
}

/// Whiteboard option type
///
/// 白板可选项类型。
enum WBOptionType {
  /// Whiteboard file cache path, object type is String.
  ///
  /// 白板文件缓存路径，对象类型是 String 。
  @JsonValue(1)
  FileCachePath,

  /// Enable whiteboard response UI event flag, object type is bool value. Default is true
  ///
  /// 启用白板响应UI事件，对象类型是bool。默认启用
  @JsonValue(2)
  EnableUIResponse,

  /// Show or hide whiteboard draws, object type is bool value. Default is show
  ///
  /// **Note**
  /// Background image or H5 contents are not affected by this option
  ///
  /// 显示或隐藏白板涂鸦，对象类型是bool。默认显示
  ///
  /// **Note**
  /// 背景图和H5内容不受此选项影响
  @JsonValue(3)
  ShowDraws,

  /// enable whiteboard canvas scale and move, object type is bool value. Default is true
  ///
  /// 启用白板画布缩放移动，对象类型是bool。默认启用
  @JsonValue(4)
  ScaleMove,

  /// set image or audio/video object's default status is selected or not, object type is bool value. Default is true
  /// 设置图片或音视频对象默认选中状态, 对象类型是bool。默认启用 */
  @JsonValue(5)
  AutoSelected,
}

/// Option type
///
/// 可选项类型。
enum OptionType {
  /// Face beacutify option, object type is PanoFaceBeautifyOption.
  ///
  /// 美颜可选项，对象类型是 PanoFaceBeautifyOption 。
  @JsonValue(0)
  FaceBeautify,

  /// Logs upload option, object type is NSNumber with BOOL value.
  ///
  /// 日志上传可选项，对象类型是带 BOOL 值的 NSNumber 。
  @JsonValue(1)
  UploadLogs,

  /// Audio dump file upload option, object type is NSNumber with BOOL value.
  ///
  /// 音频转储文件上传选项，对象类型是带 BOOL 值的 NSNumber 。
  @JsonValue(2)
  UploadAudioDump,

  /// Audio equalization option, object type is NSNumber with PanoAudioEqualizationMode value.
  ///
  /// 音频均衡器选项，对象类型是带 PanoAudioEqualizationMode 值的 NSNumber 。
  @JsonValue(3)
  AudioEqualizationMode,

  /// Audio reverb option, object type is NSNumber with PanoAudioReverbMode value.
  ///
  /// 音频混响器选项，对象类型是带 PanoAudioReverbMode 值的 NSNumber 。
  @JsonValue(4)
  AudioReverbMode,

  /// Adjust video capture frame rate option, object type is NSNumber with PanoVideoFrameRateType value.
  ///
  /// 调整视频采集帧率选项，对象类型是带 PanoVideoFrameRateType 值的 NSNumber 。
  @JsonValue(5)
  VideoFrameRate,

  /// Audio ear Monitoring enable option, object type is NSNumber with BOOL value.
  ///
  /// 音频耳返开关选项，对象类型是带 BOOL 值的 NSNumber 。
  @JsonValue(6)
  AudioEarMonitoring,

  /// (Deprecated) Internal video transform option, object type is PanoBuiltinTransformOption.
  ///
  /// (已废弃)视频内嵌变换可选项，对象类型是 PanoBuiltinTransformOption 。
  @deprecated
  @JsonValue(7)
  BuiltinTransform,

  /// Enable upload PANO SDK logs when failed to join channel, object type is NSNumber with BOOL value.
  ///
  /// **Note**
  /// This flag has been set by default.
  ///
  /// 允许加会失败时上传PANO日志，对象类型是带 BOOL 值的 NSNumber 。
  ///
  /// **Note**
  /// 此标记设置后会一直有效。默认已经启用。
  @JsonValue(8)
  UploadLogsAtFailure,

  /// Allow SDK to adjust video quality according to CPU performance.
  ///           Object type is NSNumber with BOOL value. Default value is ture. Configurable before join room.
  ///
  /// **Note**
  /// We do not recommend disabling CPU adaption in general case.
  ///
  /// 允许SDK根据CPU性能调整视频质量。对象类型是带 BOOL 值的 NSNumber 。默认值是true。仅在加入房间前可以配置。
  ///
  /// **Note**
  /// 通常场景下不建议关闭此功能。
  @JsonValue(9)
  CpuAdaption,

  /// Audio profile option, object type is PanoRtcAudioProfile.
  ///
  /// 音频配置选项，对象类型是 PanoRtcAudioProfile 。
  @JsonValue(10)
  AudioProfile,

  /// Quadrilateral video transform option, object type is PanoQuadTransformOption.
  ///
  /// 视频四边形变换可选项，对象类型是 PanoQuadTransformOption 。
  @JsonValue(11)
  QuadTransform,

  ///Screen Capture Frame Rate. Default value is false, true to enable high frame rate capture, for motion scenario.
  ///
  ///屏幕采集帧率模式。参数类型是Boolean，默认是false, 高帧率采集用于内容变化剧烈场景。
  @JsonValue(17)
  ScreenOptimization,
}

/// Log output level
///
/// 日志输出级别。
enum LogLevel {
  /// Outputs FATAL level log information.
  ///
  /// 输出FATAL级别日志信息。
  @JsonValue(0)
  Fatal,

  /// Outputs FATAL and ERROR level log information.
  ///
  /// 输出FATAL和ERROR级别日志信息。
  @JsonValue(1)
  Error,

  /// Outputs FATAL, ERROR and WARNING level log information.
  ///
  /// 输出FATAL、ERROR和WARNING级别日志信息。
  @JsonValue(2)
  Warning,

  /// Outputs FATAL, ERROR, WARNING and INFO level log information.
  ///
  /// 输出FATAL、ERROR、WARNING和INFO级别日志信息。
  @JsonValue(3)
  Info,

  /// Outputs FATAL, ERROR, WARNING, INFO and VERBOSE level log information.
  ///
  /// 输出FATAL、ERROR、WARNING、INFO和VERBOSE级别日志信息。
  @JsonValue(4)
  Verbose,

  /// Outputs all level log information.
  ///
  /// 输出所有级别日志信息。
  @JsonValue(5)
  Debug,
}

/// Feedback type
///
/// 用户反馈问题类型。
enum FeedbackType {
  /// General problem
  ///
  /// 通用类型。
  @JsonValue(0)
  General,

  /// Audio problem
  ///
  /// 语音问题。
  @JsonValue(1)
  Audio,

  /// Video problem
  ///
  /// 视频问题。
  @JsonValue(2)
  Video,

  /// Whiteboard problem
  ///
  /// 白板问题。
  @JsonValue(3)
  Whiteboard,

  /// Screen sharing problem
  ///
  /// 桌面共享问题。
  @JsonValue(4)
  Screen,
}

/// Audio mixing state
///
/// 混音状态。
enum AudioMixingState {
  /// Mixing started
  ///
  /// 混音开始。
  @JsonValue(0)
  Started,

  /// Mixing finished
  ///
  /// 混音结束。
  @JsonValue(1)
  Finished,
}

/// Image file format
///
/// 图片文件格式。
enum ImageFileFormat {
  /// JPEG. Lossy compression format
  ///
  /// JPEG。有损压缩格式。
  @JsonValue(0)
  JPEG,

  /// PNG. Lossless compression format
  ///
  /// PNG。无损压缩格式。
  @JsonValue(1)
  PNG,

  /// BMP. Uncompressed format
  ///
  /// BMP。无压缩格式。
  @JsonValue(2)
  BMP,
}

/// Audio equalization option
///
/// 音频均衡器选项。
enum AudioEqualizationMode {
  /// None
  ///
  /// 无音效
  @JsonValue(0)
  None,

  /// Bass
  ///
  /// 低音
  @JsonValue(1)
  Bass,

  /// Loud
  ///
  /// 高音
  @JsonValue(2)
  Loud,

  /// Vocal Music
  ///
  /// 声乐
  @JsonValue(3)
  VocalMusic,

  /// Strong
  ///
  /// 增强
  @JsonValue(4)
  Strong,

  /// Pop
  ///
  /// 流行
  @JsonValue(5)
  Pop,

  /// Live
  ///
  /// 现场
  @JsonValue(6)
  Live,

  /// Dance Music
  ///
  /// 舞曲
  @JsonValue(7)
  DanceMusic,

  /// Club
  ///
  /// 俱乐部
  @JsonValue(8)
  Club,

  /// Soft
  ///
  /// 轻柔
  @JsonValue(9)
  Soft,

  /// Rock
  ///
  /// 摇滚
  @JsonValue(10)
  Rock,

  /// Party
  ///
  /// 聚会
  @JsonValue(11)
  Party,

  /// Classical
  ///
  /// 古典
  @JsonValue(12)
  Classical,

  /// Test
  ///
  /// 测试用例
  @JsonValue(13)
  Test,
}

/// Audio rever mode
///
/// 音效模式
enum AudioReverbMode {
  /// None
  ///
  /// 无音效
  @JsonValue(0)
  None,

  /// Vocal I
  ///
  /// 人声 1
  @JsonValue(1)
  VocalI,

  /// Vocal II
  ///
  /// 人声 2
  @JsonValue(2)
  VocalII,

  /// Bathroom
  ///
  /// 浴室
  @JsonValue(3)
  Bathroom,

  /// Small room bright
  ///
  /// 明亮小房间
  @JsonValue(4)
  SmallRoomBright,

  /// Small room dark
  ///
  /// 黑暗小房间
  @JsonValue(5)
  SmallRoomDark,

  /// Medium room
  ///
  /// 中等房间
  @JsonValue(6)
  MediumRoom,

  /// Large room
  ///
  /// 大房间
  @JsonValue(7)
  LargeRoom,

  /// Church hall
  ///
  /// 教堂大厅
  @JsonValue(8)
  ChurchHall,

  /// Cathedral
  ///
  /// 大教堂
  @JsonValue(9)
  Cathedral,
}

/// Video frame rate type
///
/// 视频帧率类型。
enum VideoFrameRateType {
  /// The max frame rate is 15 fps
  ///
  /// 最大帧率 15 fps。
  @JsonValue(0)
  Low,

  /// The max frame rate is 30 fps
  ///
  /// 最大帧率 30 fps。
  @JsonValue(1)
  Standard,
}

/// Video Codec Type
///
/// 视频编解码器类型。
enum VideoCodecType {
  /// unknown Codec
  ///
  /// 未知编解码器.
  @JsonValue(0)
  Unknown,

  /// H.264 Codec
  ///
  /// H.264编解码.
  @JsonValue(1)
  H264,

  /// AV1 Codec
  ///
  /// AV1编解码.
  @JsonValue(2)
  AV1,
}

/// Audio Codec Type
///
/// 音频编解码器类型。
enum AudioCodecType {
  /// unknown Codec
  ///
  /// 未知编解码器.
  @JsonValue(0)
  Unknown,

  /// G.711 Codec
  ///
  /// G.711编解码器.
  @JsonValue(1)
  G711,

  /// G.722 Codec
  ///
  /// G.722编解码器.
  @JsonValue(2)
  G722,

  /// iLBC Codec
  ///
  /// iLBC编解码器.
  @JsonValue(3)
  ILBC,

  /// iSAC Codec
  ///
  /// iSAC编解码器.
  @JsonValue(4)
  ISAC,

  /// Opus Codec
  ///
  /// Opus编解码器.
  @JsonValue(5)
  OPUS,
}

/// Audio Sample Rate
///
/// 音频采样率。
enum AudioSampleRate {
  /// Audio sample rate16000Hz
  ///
  /// 音频采样率16000Hz.
  @JsonValue(16000)
  Rate16K,

  /// Audio sample rate48000Hz
  ///
  /// 音频采样率48000Hz.
  @JsonValue(48000)
  Rate48K,
}

/// Audio Channel
///
/// 音频采样率。
enum AudioChannel {
  /// Audio channel mono
  ///
  /// 音频单通道.
  @JsonValue(1)
  Mono,

  /// Audio channel stereo
  ///
  /// 音频双通道.
  @JsonValue(2)
  Stereo,
}

/// Audio Profile Quality
///
/// 音频质量配置。
enum AudioProfileQuality {
  /// Audio quality default: encode bitrate - 48kbps
  ///
  /// 音频默认质量: 编码最大码率 48kbps
  @JsonValue(0)
  Default,

  /// Audio high quality: encode bitrate - 128kbps
  ///
  /// 音频质量: 编码最大码率 128kbps
  @JsonValue(1)
  High,
}

/// Quality rating values
///
/// 质量评分分值。
enum QualityRating {
  /// Service not available
  ///
  /// 服务不可用。
  @JsonValue(0)
  Unavailable,

  /// The quality is very bad
  ///
  /// 服务质量非常差，几乎不可用。
  @JsonValue(1)
  VeryBad,

  /// The quality is bad
  ///
  /// 服务质量比较差，质量不稳定。
  @JsonValue(2)
  Bad,

  /// The quality is poor
  ///
  /// 服务质量一般。
  @JsonValue(3)
  Poor,

  /// The quality is good
  ///
  /// 服务质量很好。
  @JsonValue(4)
  Good,

  /// The quality is excellent
  ///
  /// 服务质量非常好。
  @JsonValue(5)
  Excellent,
}

/// Media processor type
///
/// 媒体处理类型。
enum MediaProcessorType {
  /// Audio Capture External Processor for data before local process.
  ///
  /// **Note**
  /// The processor must be PanoRtcAudioDataExProcessorDelegate pointer or nullptr.
  /// And the param shoubld be nullptr.
  ///
  /// 音频采集外部处理(位置位于本地采集后，前处理前)。
  ///
  /// **Note**
  /// 对应的处理模块必须为 PanoRtcAudioDataExProcessorDelegate 指针类型或空，对应的处理模块参数必须为空。
  @JsonValue(1)
  AudioCaptureExProcessor,

  /// Audio Capture External Effect Processor for data after local process and before encoder.
  ///
  /// **Note**
  /// The processor must be PanoRtcAudioDataExProcessorDelegate pointer or nullptr.
  /// And the param shoubld be nullptr.
  ///
  /// 音频采集外部处理(位置位于本地处理后，编码前)。
  ///
  /// **Note**
  /// 对应的处理模块必须为 PanoRtcAudioDataExProcessorDelegate 指针类型或空，对应的处理模块参数必须为空。
  @JsonValue(2)
  AudioCaptureExEffectProcessor,

  /// Audio Capture External Processor for before playback.
  ///
  /// **Note**
  /// The processor must be PanoRtcAudioDataExProcessorDelegate pointer or nullptr.
  /// And the param shoubld be nullptr.
  ///
  /// 音频采集外部处理(位置位于播放前)。
  ///
  /// **Note**
  /// 对应的处理模块必须为 PanoRtcAudioDataExProcessorDelegate 指针类型或空，对应的处理模块参数必须为空。
  @JsonValue(3)
  AudioRenderExProcessor,

  /// Video Preprocessor. The processor must be PanoRtcVideoFilterDelegate or nil. And the param should be nil.
  ///
  /// 视频前处理。对应的处理模块必须为 PanoRtcVideoFilterDelegate 代理或空，对应的处理模块参数必须为空。
  @JsonValue(100)
  VideoPreprocessor,
}

/// Quadrilateral vertex index.
///
/// 四边形顶点索引。
enum QuadIndex {
  /// The top left of a quadrilateral.
  ///
  /// 四边形左上角顶点。
  @JsonValue(0)
  TopLeft,

  /// The top right of a quadrilateral.
  ///
  /// 四边形右上角顶点。
  @JsonValue(1)
  TopRight,

  /// The top right of a quadrilateral.
  ///
  /// 四边形右上角顶点。
  @JsonValue(2)
  BottomLeft,

  /// The top right of a quadrilateral.
  ///
  /// 四边形右上角顶点。
  @JsonValue(3)
  BottomRight,
}

enum MessageServiceState {
  @JsonValue(0)
  Unavailable,

  @JsonValue(1)
  Available
}

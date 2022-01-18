import 'package:flutter/material.dart';
import 'package:pano_rtc/pano_rtc.dart';

class UserInfo {
  String userId;
  String userName;
  bool audioEnable;
  bool audioMute;
  bool videoEnable;
  bool videoMute;
  RtcSurfaceViewModel? videoView;
  bool isLocal;
  bool isReadyVideo;

  UserInfo(
      {Key? key,
      required this.userId,
      required this.userName,
      this.audioEnable = false,
      this.audioMute = false,
      this.videoEnable = false,
      this.videoMute = false,
      this.isLocal = false,
      this.isReadyVideo = false,
      this.videoView});
}

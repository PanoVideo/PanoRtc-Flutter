import 'dart:math';

import 'package:pano_rtc/pano_rtc.dart';

class ChannelInfo {
  static String appId = YOUR APPID;
  static String server = 'api.pano.video';
  static String token = YOUR TOKEN;
  static String channelId = '';
  static ChannelMode channelMode = ChannelMode.Meeting;
  static String userId = Random().nextInt(10000).toString();
  static String userName = '';

  static void setUserId(String userId) {
    ChannelInfo.userId = userId;
  }

  static void setChannelId(String channelId) {
    ChannelInfo.channelId = channelId;
  }

  static void setChannelMode(ChannelMode channelMode) {
    ChannelInfo.channelMode = channelMode;
  }

  static void setUserName(String userName) {
    ChannelInfo.userName = userName;
  }
}

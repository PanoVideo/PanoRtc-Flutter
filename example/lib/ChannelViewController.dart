import 'dart:convert';
import 'dart:typed_data';
import 'ChannelInfo.dart';
import 'UserInfo.dart';
import 'UserManager.dart';
import 'WhiteboardViewController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pano_rtc/pano_rtc.dart';
import 'package:permission_handler/permission_handler.dart';

class ChannelViewController extends StatefulWidget {
  ChannelViewController({Key key}) : super(key: key);

  @override
  _ChannelViewControllerState createState() => _ChannelViewControllerState();
}

class _ChannelViewControllerState extends State<ChannelViewController> {
  RtcEngineKit engineKit;

  bool isWhiteboardEnable = false;
  bool isEnableAudio = true;
  bool isEnableVideo = true;
  bool isSpeaker = false;

  RtcSurfaceViewModel bigRemoteView;
  bool isBigView = false;
  RtcWhiteboard whiteboardEngine;
  RtcMessageService rtcMessageService;

  UserInfo bigScreenUser;

  @override
  void initState() {
    super.initState();

    initUserManager();
    createEngineKit();
  }

  void initUserManager() {
    UserManager.shared();
  }

  void enableAudio() {
    isEnableAudio = !isEnableAudio;
    if (isEnableAudio) {
      engineKit.unmuteAudio();
    } else {
      engineKit.muteAudio();
    }
    if (mounted) setState(() {});
  }

  void switchSpeaker() {
    isSpeaker = !isSpeaker;
    engineKit.setLoudspeakerStatus(isSpeaker);

    if (mounted) setState(() {});
  }

  void enableVideo() async {
    isEnableVideo = !isEnableVideo;
    if (isEnableVideo) {
      var res = await startVideo();

      print('---------------------------- muteVideo start ' + res.toString());
    } else {
      var res = await engineKit.stopVideo();
      print('---------------------------- muteVideo end ' + res.toString());
    }
    if (mounted) setState(() {});
  }

  Future<ResultCode> startVideo() async {
    var localUser = UserManager.shared().findLocalUser();

    if (localUser != null && localUser.videoView != null) {
      var renderConfig = RtcRenderConfig(
          profileType: VideoProfileType.HD720P,
          scalingMode: VideoScalingMode.FullFill,
          mirror: true);
      return await engineKit.startVideo(localUser.videoView,
          config: renderConfig);
    } else {
      return ResultCode.Failed;
    }
  }

  void bigSubscribeVideo(UserInfo userObj) async {
    if (userObj.isLocal) {
      await engineKit.stopVideo();
      await Future.delayed(Duration(milliseconds: 400));
    }

    if (bigScreenUser != null) {
      bigScreenUser.isReadyVideo = false;
      bigScreenUser.videoView = null;
      UserManager.shared().userInfos.add(bigScreenUser);
    }
    isBigView = true;
    bigScreenUser = userObj;

    if (bigRemoteView != null) {
      bigScreenUser.isReadyVideo = true;
      bigScreenUser.videoView = bigRemoteView;
    } else {
      bigScreenUser.isReadyVideo = false;
      bigScreenUser.videoView = null;
    }
    UserManager.shared().removeUser(userObj.userId);
    if (mounted) setState(() {});
    bigScreenRenderStart();
  }

  void bigScreenRenderStart() async {
    if (bigScreenUser != null && bigScreenUser.videoView != null) {
      if (bigScreenUser.isLocal) {
        var renderConfig = RtcRenderConfig(
            profileType: VideoProfileType.HD720P,
            scalingMode: VideoScalingMode.CropFill,
            mirror: true);
        await engineKit.startVideo(bigRemoteView, config: renderConfig);
      } else {
        var renderConfig = RtcRenderConfig(
            profileType: VideoProfileType.HD720P,
            scalingMode: VideoScalingMode.CropFill);
        await engineKit.subscribeVideo(bigScreenUser.userId, bigRemoteView,
            config: renderConfig);
      }
    }
  }

  Future<ResultCode> subscribeVideo(
      String userId, RtcSurfaceViewModel view) async {
    var renderConfig = RtcRenderConfig(
        profileType: VideoProfileType.Low,
        scalingMode: VideoScalingMode.CropFill);
    return await engineKit.subscribeVideo(userId, view, config: renderConfig);
  }

  void createEngineKit() async {
    await [Permission.camera, Permission.microphone, Permission.storage]
        .request();
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      Navigator.pop(context);
      return;
    }

    var engineConfig = RtcEngineConfig(ChannelInfo.appId, ChannelInfo.server);
    engineConfig.videoCodecHwAcceleration = true;
    engineKit = await RtcEngineKit.engine(engineConfig);
    rtcMessageService = await engineKit.messageService();

    engineKit.setEventHandler(
      RtcEngineEventHandler(onChannelJoinConfirm: (ResultCode result) async {
        print('onChannelJoinConfirm $result');
        if (result == ResultCode.OK) {
          isSpeaker = true;
          await engineKit.setLoudspeakerStatus(true);
          await engineKit.startAudio();

          UserManager.shared()
              .addUser(ChannelInfo.userId, ChannelInfo.userName, isLocal: true);
        } else {
          print('Join channel failed with error $result');
        }
      }, onChannelLeaveIndication: (ResultCode result) {
        print('onChannelLeaveIndication result $result');
      }, onUserAudioStart: (String userId) {
        print('onUserAudioStart userId $userId');
        var user = UserManager.shared().findUser(userId);
        if (user == null) {
          if (bigScreenUser.userId == userId) {
            user = bigScreenUser;
          }
          return;
        }
        user.audioEnable = true;
      }, onUserVideoStart: (String userId, VideoProfileType maxProfile) async {
        print('onUserVideoStart userId $userId');
        print('onUserVideoStart maxProfile $maxProfile');

        var user = UserManager.shared().findUser(userId);
        user.videoEnable = true;
        if (user.videoView != null) {
          await subscribeVideo(userId, user.videoView);
        }
      }, onActiveSpeakerListUpdated: (List<dynamic> userIds) {
        print('onActiveSpeakerListUpdated userIds $userIds');
      }, onFirstVideoFrameRendered: (String userId) {
        print('onFirstVideoFrameRendered userIds $userId');
      }, onFirstVideoDataReceived: (String userId) {
        print('onFirstVideoDataReceived userIds $userId');
      }, onVideoCaptureStateChanged:
          (String deviceId, VideoCaptureState state) {
        print('onVideoCaptureStateChanged deviceId $deviceId');
        print('onVideoCaptureStateChanged state $state');
      }, onWhiteboardAvailable: () async {
        print('onWhiteboardAvailable');

        whiteboardEngine = await engineKit.whiteboardEngine();

        if (mounted) {
          setState(() {
            isWhiteboardEnable = true;
          });
        }
      }, onWhiteboardUnavailable: () {
        print('onWhiteboardUnavailable');
        setState(() {
          isWhiteboardEnable = false;
        });
      }, onUserJoinIndication: (String userId, String userName) {
        print('onUserJoinIndication userId $userId');
        print('onUserJoinIndication userName $userName');
        UserManager.shared().addUser(userId, userName);
        if (mounted) setState(() {});
      }, onUserVideoMute: (String userId) {
        print('onUserVideoMute userId $userId');
        var user = UserManager.shared().findUser(userId);
        if (user == null) {
          if (bigScreenUser.userId == userId) {
            user = bigScreenUser;
          }
          return;
        }
        user.videoMute = true;
      }, onUserVideoUnmute: (String userId) {
        print('onUserVideoUnmute userId $userId');

        var user = UserManager.shared().findUser(userId);
        if (user == null) {
          if (bigScreenUser.userId == userId) {
            user = bigScreenUser;
          }
          return;
        }
        user.videoMute = false;
      }, onChannelCountDown: (int remain) {
        print('onChannelCountDown remain $remain');
      }, onUserLeaveIndication: (String userId, UserLeaveReason reason) {
        print('onUserLeaveIndication userId $userId');
        print('onUserLeaveIndication reason $reason');

        var user = UserManager.shared().removeUser(userId);
        if (user != null && user.videoView != null) {
          user.videoView = null;
          user.isReadyVideo = false;
        }

        if (user == null) {
          if (bigScreenUser.userId == userId) {
            closeBigVideo(isLeave: true);
          }
        } else {
          if (mounted) setState(() {});
        }
      }, onUserAudioStop: (String userId) {
        print('onUserAudioStop userId $userId');
        var user = UserManager.shared().findUser(userId);

        if (user == null) {
          if (bigScreenUser.userId == userId) {
            user = bigScreenUser;
          }
          return;
        }
        user.audioEnable = false;
      }, onUserAudioSubscribe: (String userId, SubscribeResult result) {
        print('onUserAudioSubscribe userId $userId');
        print('onUserAudioSubscribe result $result');
      }, onUserVideoStop: (String userId) {
        print('onUserVideoStop userId $userId');
        var user = UserManager.shared().findUser(userId);
        user.videoEnable = false;
        if (mounted) setState(() {});
      }, onUserVideoSubscribe: (String userId, SubscribeResult result) {
        print('onUserVideoSubscribe userId $userId');
        print('onUserVideoSubscribe result $result');
      }, onUserAudioMute: (String userId) {
        print('onUserVideoSubscribe userId $userId');
        var user = UserManager.shared().findUser(userId);
        user.audioMute = true;
      }, onUserAudioUnmute: (String userId) {
        print('onUserAudioUnmute userId $userId');
        var user = UserManager.shared().findUser(userId);
        user.audioMute = false;
      }, onUserScreenStart: (String userId) {
        print('onUserScreenStart userId $userId');
      }, onUserScreenStop: (String userId) {
        print('onUserScreenStop userId $userId');
      }, onUserScreenSubscribe: (String userId, SubscribeResult result) {
        print('onUserScreenSubscribe userId $userId');
        print('onUserScreenSubscribe result $result');
      }, onUserScreenMute: (String userId) {
        print('onUserScreenMute userId $userId');
      }, onUserScreenUnmute: (String userId) {
        print('onUserScreenUnmute userId $userId');
      }, onWhiteboardStart: () {
        print('onWhiteboardStart');
      }, onWhiteboardStop: () {
        print('onWhiteboardStop');
      }, onWhiteboardStartWithId: (String whiteboardId) {
        print('onWhiteboardStartWithId whiteboardId$whiteboardId');
      }, onWhiteboardStopWithId: (String whiteboardId) {
        print('onWhiteboardStartWithId whiteboardId$whiteboardId');
      }, onFirstAudioDataReceived: (String userId) {
        print('onFirstAudioDataReceived userId $userId');
      }, onFirstScreenDataReceived: (String userId) {
        print('onFirstScreenDataReceived userId $userId');
      }, onFirstScreenFrameRendered: (String userId) {
        print('onFirstScreenFrameRendered userId $userId');
      }, onChannelFailover: (FailoverState state) {
        print('onChannelFailover state $state');
      }, onAudioMixingStateChanged: (int taskId, AudioMixingState state) {
        print('onAudioMixingStateChanged taskId $taskId');
        print('onAudioMixingStateChanged state $state');
      }, onVideoSnapshotCompleted:
          (bool succeed, String userId, String fileName) {
        print('onVideoSnapshotCompleted succeed $succeed');
        print('onVideoSnapshotCompleted userId $userId');
        print('onVideoSnapshotCompleted fileName $fileName');
      }),
    );
    rtcMessageService.setEventHandler(RtcMessageServiceHandler(
        onServiceStateChanged: (MessageServiceState state) {
      print('onServiceStateChanged state $state');
      if (state == MessageServiceState.Available) {
        rtcMessageService.broadcastMessage(utf8.encode('Test'));
      }
    }, onUserMessage: (String userId, Uint8List byte) {
      print('onMessage userId: $userId');
      print('onMessage byte:' + utf8.decode(byte));
    }));
    joinChannel();
  }

  void destroyEngineKit() {
    engineKit.destroy();
    engineKit = null;
  }

  void joinChannel() async {
    var channelConfig = RtcChannelConfig(
        mode: ChannelInfo.channelMode, userName: ChannelInfo.userName);
    var result = await engineKit.joinChannel(
        ChannelInfo.token, ChannelInfo.channelId, ChannelInfo.userId,
        config: channelConfig);
    if (result != ResultCode.OK) {
      print('Join channel failed with error: ${result.toString()}');
    }
  }

  void leaveChannel() {
    engineKit.leaveChannel();
  }

  void closeBigVideo({bool isLeave = false}) async {
    isBigView = false;
    bigRemoteView = null;
    if (bigScreenUser != null) {
      if (bigScreenUser.isLocal) {
        await engineKit.stopVideo();
        await Future.delayed(Duration(milliseconds: 500));
      }
      bigScreenUser.isReadyVideo = false;
      bigScreenUser.videoView = null;

      if (!isLeave) {
        UserManager.shared().userInfos.add(bigScreenUser);
      }
      bigScreenUser = null;
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    leaveChannel();
    destroyEngineKit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 70,
              color: Colors.white,
              alignment: Alignment.center,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: UserManager.shared().userInfos.length,
                itemBuilder: (context, index) {
                  var userObj = UserManager.shared().userInfos[index];
                  return Container(
                    key: Key('${userObj.userId}'),
                    width: 100,
                    height: 60,
                    color: Colors.black,
                    margin: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        print('onTap View');
                        bigSubscribeVideo(userObj);
                      },
                      child: Container(
                        color: Colors.black,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            IgnorePointer(
                              ignoring: true,
                              child: RtcSurfaceView(
                                onViewCreated: ((viewModel) {
                                  userObj.videoView = viewModel;
                                  if (!userObj.isReadyVideo) {
                                    userObj.isReadyVideo = true;
                                    if (userObj.isLocal) {
                                      startVideo();
                                    } else {
                                      subscribeVideo(
                                          userObj.userId, userObj.videoView);
                                    }
                                  }
                                }),
                              ),
                            ),
                            Icon(
                              Icons.fullscreen,
                              color: Colors.white,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    whiteboardEngine == null
                        ? Container()
                        : WhiteboardViewController(
                            whiteboardEngine: whiteboardEngine),
                    isBigView
                        ? Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                key: Key('bigScreenView'),
                                child:
                                    RtcSurfaceView(onViewCreated: ((viewModel) {
                                  bigRemoteView = viewModel;
                                  if (bigScreenUser != null) {
                                    bigScreenUser.videoView = bigRemoteView;
                                  }
                                  bigScreenRenderStart();
                                })),
                              ),
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: MaterialButton(
                                  onPressed: closeBigVideo,
                                  color: Colors.white.withOpacity(0.3),
                                  textColor: Colors.blue,
                                  child: Icon(
                                    Icons.fullscreen_exit,
                                    size: 24,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  // shape: CircleBorder(),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Row(
                      children: [
                        Spacer(),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: MaterialButton(
                            onPressed: enableAudio,
                            color: Colors.white,
                            textColor: Colors.blue,
                            child: Icon(
                              isEnableAudio ? Icons.mic : Icons.mic_off,
                              size: 24,
                            ),
                            padding: EdgeInsets.all(8),
                            shape: CircleBorder(),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: 80,
                          height: 30,
                          child: Image.asset(
                            'assets/app_logo.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: MaterialButton(
                            onPressed: enableVideo,
                            color: Colors.white,
                            textColor: Colors.blue,
                            child: Icon(
                              isEnableVideo
                                  ? Icons.camera_alt
                                  : Icons.camera_alt_outlined,
                              size: 24,
                            ),
                            padding: EdgeInsets.all(8),
                            shape: CircleBorder(),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

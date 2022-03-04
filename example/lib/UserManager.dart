import 'UserInfo.dart';
import 'package:pano_rtc/pano_rtc.dart' hide UserInfo;

class UserManager {
  static final UserManager _singleton = UserManager._internal();

  factory UserManager() => _singleton;
  final List<UserInfo?> userInfos = <UserInfo?>[];

  UserManager._internal();

  static UserManager shared() => _singleton;

  UserInfo addUser(String userId, String userName, {bool isLocal = false}) {
    var userInfo =
        UserInfo(userId: userId, userName: userName, isLocal: isLocal);
    userInfos.add(userInfo);
    return userInfo;
  }

  UserInfo? removeUser(String userId) {
    var userInfo = findUser(userId);
    if (userInfo != null) {
      userInfos.remove(userInfo);
    }
    return userInfo;
  }

  UserInfo? findUser(String userId) {
    return userInfos.firstWhere((userInfoObj) => userInfoObj!.userId == userId,
        orElse: () => null);
  }

  UserInfo? findLocalUser() {
    return userInfos.firstWhere((userInfoObj) => userInfoObj!.isLocal == true,
        orElse: () => null);
  }

  UserInfo? findUserWithView(RtcSurfaceViewModel view) {
    return userInfos.firstWhere((userInfoObj) => userInfoObj!.videoView == view,
        orElse: () => null);
  }

  UserInfo? findWatingUser() {
    return userInfos.firstWhere(
        (userInfoObj) =>
            userInfoObj!.videoEnable && userInfoObj.videoView == null,
        orElse: () => null);
  }

  void removeAllUser() {
    userInfos.forEach((element) {
      element!.videoView = null;
    });
    userInfos.clear();
  }
}

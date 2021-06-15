# 拍乐云实时音视频 Demo 使用指导

## Getting Started

### 1. 注册拍乐云账号
进入拍乐云 [控制台](https://console.pano.video/) 页面，根据指导创建拍乐云账号。

### 2. 创建应用
登录拍乐云 [控制台](https://console.pano.video/) ，进入应用管理页面创建一个新的应用，获得 AppID。AppID 用以区分不同的实时音视频应用。

### 3. 生成临时 Token
用户在创建应用并且获取到 AppID 后，还需要 Token 才可以使用拍乐云实时音视频服务。对于 Demo 用户可在拍乐云控制台为应用 <a href="https://developer.pano.video/getting-started/firstapp/#14-%E7%94%9F%E6%88%90%E4%B8%B4%E6%97%B6token">生成临时token</a>。

### 4. 填入 AppID 和临时 Token
打开 `main.dart`。 然后将 AppID 和 Token 分别拷贝到`YOUR APP ID`和`YOUR TOKEN`。自定义`channelId`和`userId`值。

```Dart
var appId = "YOUR APP ID";
var token = "YOUR TOKEN";
var rtcServer = "api.pano.video";
var channelId = "RoomId";
var userId = 12345;
```

### 5. 运行
连接设备运行

## 开发环境要求
- iOS: 兼容 iOS 9.0 及以上版本
- Android: 最低兼容 Android 4.4（SDK API Level 19），建议使用 Android 5.0 （SDK API Level 21）及以上版本
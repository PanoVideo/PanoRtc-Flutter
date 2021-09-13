# pano_rtc

![pub package](https://img.shields.io/pub/v/pano_rtc.svg?include_prereleases)

[English](README.md)

此 Flutter 插件 是对 [Pano SDK](https://developer.pano.video/getting-started/intro/) 的包装。

Pano 提供多种实时互动能力，全方位满足业务需求。通过集成 Pano SDK，即可在自己的App里轻松实现语音通话、视频通话、互动白板、互动直播、云端录制等各种能力。

## 如何使用

为了使用此插件, 添加 `pano_rtc` 到您的 [pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages) 文件中。

## 快速开始

* 参阅 [example](example) 目录，这是一个多人高清音视频通话的示例。

## 设备权限

Pano SDK 需要 `摄像头` 和 `麦克风` 权限来开始视频通话。

### Android

打开 `AndroidManifest.xml` 文件并且添加必备的权限到此文件中.

```xml
<manifest>
    ...
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-feature android:name="android.hardware.camera" />
    <uses-feature android:name="android.hardware.camera.autofocus" />
    ...
</manifest>
```

### iOS

打开 `info.plist` 文件并且添加：

- `Privacy - Microphone Usage Description`，并且在 `Value` 列中添加描述。
- `Privacy - Camera Usage Description`, 并且在 `Value` 列中添加描述。

您的程序可以在后台运行音视频通话，前提是您开启了后台模式。在 Xcode 中选择您的 app target，点击 **Capabilities** 标签，开启 **Background Modes**，并且勾选 **Voice over IP**。

## 常见问题

### iOS 无法显示视频（Android 正常）

我们的 SDK 使用 PlatformView，您需要在 info.plist 中设置 io.flutter.embedded_views_preview 为 YES 。

## API

* [Flutter API](https://pub.dev/documentation/pano_rtc/latest/)
* [Android API](https://developer.pano.video/sdk/javasdk/)
* [iOS API](https://developer.pano.video/sdk/ocsdk/)

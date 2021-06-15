# pano_rtc

![pub package](https://img.shields.io/pub/v/pano_rtc.svg?include_prereleases)

[中文](README.zh.md)

This Flutter plugin is a wrapper for [Pano SDK](https://developer.pano.video/getting-started/intro/).

Pano provide a variety of real-time interactive capabilities to meet business needs in all aspects. By integrating the Pano SDK, you can easily implement various capabilities such as voice calls, video calls, interactive whiteboards, interactive live broadcasts, and cloud recording in your App.

## Usage

To use this plugin, add `pano_rtc` as a dependency in your [pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages) file.

## Getting Started

* See the [example](example) directory for a sample about multi-person HD audio and video calls app which using `pano_rtc`.

## Device Permission

Pano SDK requires `camera` and `microphone` permission to start video call.

### Android

Open the `AndroidManifest.xml` file and add the required device permissions to the file.

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

Open the `info.plist` and add:

- `Privacy - Microphone Usage Description`, and add a note in the Value column.
- `Privacy - Camera Usage Description`, and add a note in the Value column.

Your application can still run the voice call when it is switched to the background if the background mode is enabled. Select the app target in Xcode, click the **Capabilities** tab, enable **Background Modes**, and check **Voice over IP**.

## Error handling

### iOS video cant show (Android works fine)

Our SDK use `PlatformView`, you should set `io.flutter.embedded_views_preview` to `YES` in your *info.plist*

## API

* [Flutter API](https://pub.dev/documentation/pano_rtc/latest/)
* [Android API](https://developer.pano.video/sdk/javasdk/)
* [iOS API](https://developer.pano.video/sdk/ocsdk/)


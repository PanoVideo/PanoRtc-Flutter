import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../pano_rtc.dart';
import 'enum_converter.dart';

/// The call back on surface view created.
typedef RtcSurfaceViewCreatedCallback = void Function(
    RtcSurfaceViewModel viewModel);

/// The RtcSurfaceViewModel class.
class RtcSurfaceViewModel {
  final MethodChannel _methodChannel;

  /// @nodoc
  Future<T?> invokeMethod<T>(String method, [Map<String, dynamic>? arguments]) {
    return _methodChannel.invokeMethod(method, arguments);
  }

  /// @nodoc
  Future<ResultCode> invokeCodeMethod(String method,
      [Map<String, dynamic>? arguments]) {
    return invokeMethod(method, arguments).then((value) {
      return ResultCodeConverter.fromValue(value).e;
    });
  }

  /// @nodoc
  RtcSurfaceViewModel(this._methodChannel);
}

/// Use SurfaceView in Android.
///
/// Use [UIView](https://developer.apple.com/documentation/uikit/uiview) in iOS.
class RtcSurfaceView extends StatefulWidget {
  /// @nodoc
  final RtcSurfaceViewCreatedCallback? onViewCreated;

  /// Which gestures should be consumed by the web view.
  ///
  /// It is possible for other gesture recognizers to be competing with the web view on pointer
  /// events, e.g if the web view is inside a [ListView] the [ListView] will want to handle
  /// vertical drags. The web view will claim gestures that are recognized by any of the
  /// recognizers on this list.
  ///
  /// When this set is empty or null, the web view will only handle pointer events for gestures that
  /// were not claimed by any other gesture recognizer.
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  /// Constructs a [RtcSurfaceView]
  const RtcSurfaceView({
    Key? key,
    this.onViewCreated,
    this.gestureRecognizers,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RtcSurfaceViewState();
}

class _RtcSurfaceViewState extends State<RtcSurfaceView> {
  final Completer<RtcSurfaceViewModel> _viewModel =
      Completer<RtcSurfaceViewModel>();

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: UiKitView(
          viewType: 'PanoNativeView',
          onPlatformViewCreated: onPlatformViewCreated,
          hitTestBehavior: PlatformViewHitTestBehavior.translucent,
          creationParams: {},
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: widget.gestureRecognizers,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AndroidView(
          viewType: 'PanoNativeView',
          onPlatformViewCreated: onPlatformViewCreated,
          hitTestBehavior: PlatformViewHitTestBehavior.translucent,
          creationParams: {},
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: widget.gestureRecognizers,
        ),
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the plugin');
  }

  Future<void> onPlatformViewCreated(int id) async {
    final viewModel =
        RtcSurfaceViewModel(MethodChannel('pano_rtc/view_surface_$id'));
    _viewModel.complete(viewModel);
    if (widget.onViewCreated != null) {
      widget.onViewCreated!(viewModel);
    }
  }
}

/// The call back on whiteboard surface view created.
typedef RtcWhiteboardSurfaceViewCreatedCallback = void Function(
    RtcWhiteboardSurfaceViewModel viewModel);

/// The RtcWhiteboardSurfaceViewModel class.
class RtcWhiteboardSurfaceViewModel {
  final MethodChannel _methodChannel;

  /// @nodoc
  Future<T?> invokeMethod<T>(String method, [Map<String, dynamic>? arguments]) {
    return _methodChannel.invokeMethod(method, arguments);
  }

  /// @nodoc
  Future<ResultCode> invokeCodeMethod(String method,
      [Map<String, dynamic>? arguments]) {
    return invokeMethod(method, arguments).then((value) {
      return ResultCodeConverter.fromValue(value).e;
    });
  }

  /// @nodoc
  RtcWhiteboardSurfaceViewModel(this._methodChannel);
}

/// Use SurfaceView in Android.
///
/// Use [UIView](https://developer.apple.com/documentation/uikit/uiview) in iOS.
class RtcWhiteboardSurfaceView extends StatefulWidget {
  /// @nodoc
  final RtcWhiteboardSurfaceViewCreatedCallback? onViewCreated;

  /// Which gestures should be consumed by the web view.
  ///
  /// It is possible for other gesture recognizers to be competing with the web view on pointer
  /// events, e.g if the web view is inside a [ListView] the [ListView] will want to handle
  /// vertical drags. The web view will claim gestures that are recognized by any of the
  /// recognizers on this list.
  ///
  /// When this set is empty or null, the web view will only handle pointer events for gestures that
  /// were not claimed by any other gesture recognizer.
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  /// Constructs a [RtcWhiteboardSurfaceView]
  const RtcWhiteboardSurfaceView({
    Key? key,
    this.onViewCreated,
    this.gestureRecognizers,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RtcWhiteboardSurfaceViewState();
}

class _RtcWhiteboardSurfaceViewState extends State<RtcWhiteboardSurfaceView> {
  final Completer<RtcWhiteboardSurfaceViewModel> _viewModel =
      Completer<RtcWhiteboardSurfaceViewModel>();

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: UiKitView(
          viewType: 'PanoWhiteboardNativeView',
          onPlatformViewCreated: onPlatformViewCreated,
          hitTestBehavior: PlatformViewHitTestBehavior.translucent,
          creationParams: {},
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: widget.gestureRecognizers,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AndroidView(
          viewType: 'PanoWhiteboardNativeView',
          onPlatformViewCreated: onPlatformViewCreated,
          hitTestBehavior: PlatformViewHitTestBehavior.translucent,
          creationParams: {},
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: widget.gestureRecognizers,
        ),
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the plugin');
  }

  Future<void> onPlatformViewCreated(int id) async {
    final viewModel = RtcWhiteboardSurfaceViewModel(
        MethodChannel('pano_rtc/whiteboard_surface_view_$id'));
    _viewModel.complete(viewModel);
    if (widget.onViewCreated != null) {
      widget.onViewCreated!(viewModel);
    }
  }
}

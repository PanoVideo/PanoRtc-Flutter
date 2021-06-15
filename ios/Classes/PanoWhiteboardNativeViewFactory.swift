//
//  PanoWhiteboardNativeViewFactory.swift
//  pano_rtc
//
//  Created by mark on 2020/12/24.
//

import Flutter
import UIKit
import PanoRtc

class PanoWhiteboardNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var messenger: FlutterBinaryMessenger?
    private final weak var rtcEnginePlugin: SwiftPanoRtcPlugin?

    init(_ messenger: FlutterBinaryMessenger, _ rtcEnginePlugin: SwiftPanoRtcPlugin) {
        super.init()
        self.messenger = messenger
        self.rtcEnginePlugin = rtcEnginePlugin
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return PanoWhiteboardNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger!,
            rtcEnginePlugin: rtcEnginePlugin!)
    }
}

class PanoWhiteboardNativeView: NSObject, FlutterPlatformView {
    private final weak var rtcEnginePlugin: SwiftPanoRtcPlugin?
    private let _view: UIView
    private let channel: FlutterMethodChannel

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger,
        rtcEnginePlugin plugin: SwiftPanoRtcPlugin
    ) {
        self.rtcEnginePlugin = plugin
        self._view = UIView(frame: frame)
        self.channel = FlutterMethodChannel(name: "pano_rtc/whiteboard_surface_view_\(viewId)", binaryMessenger: messenger)
        super.init()
        channel.setMethodCallHandler { [weak self] (call, result) in
            if let `self` = self {
                if let params = call.arguments as? NSDictionary {
                    let selector = NSSelectorFromString(call.method + "::")
                    if self.responds(to: selector) {
                        self.perform(selector, with: params, with: ResultCallback(result))
                        return
                    }
                } else {
                    let selector = NSSelectorFromString(call.method + ":")
                    if self.responds(to: selector) {
                        self.perform(selector, with: ResultCallback(result))
                        return
                    }
                }
            }
            result(FlutterMethodNotImplemented)
        }
    }

    func view() -> UIView {
        return _view
    }
    
    deinit {
        channel.setMethodCallHandler(nil)
    }
    
    private var engine: RtcWhiteboard? {
        return rtcEnginePlugin?.rtcWhiteboardPlugin.manager
    }
    
    @objc func open(_ params: NSDictionary, _ callback: Callback) {
        let params = NSMutableDictionary.init(dictionary: params)
        params["view"] = view()
        engine?.open(params, callback)
    }
}

//
//  PanoNativeViewFactory.swift
//  pano_rtc
//
//  Copyright © 2020 Pano. All rights reserved.
//

import Flutter
import UIKit
import PanoRtc

class PanoNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var messenger: FlutterBinaryMessenger?
    private final weak var rtcEnginePlugin: SwiftPanoRtcPlugin?

    init(_ messenger: FlutterBinaryMessenger,  _ rtcEnginePlugin: SwiftPanoRtcPlugin) {
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
        return PanoNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger!,
            rtcEnginePlugin: rtcEnginePlugin!)
    }
}

class PanoNativeView: NSObject, FlutterPlatformView {
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
        self.channel = FlutterMethodChannel(name: "pano_rtc/view_surface_\(viewId)", binaryMessenger: messenger)
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
    
    //RtcEngine
    
    private var engine: RtcEngineManager? {
        return rtcEnginePlugin?.manager
    }
    
    @objc func startVideo(_ params: NSDictionary, _ callback: Callback) {
        let params = NSMutableDictionary.init(dictionary: params)
        params["view"] = view()
        engine?.startVideo(params, callback)
    }
    
    @objc func subscribeVideo(_ params: NSDictionary, _ callback: Callback) {
        let params = NSMutableDictionary.init(dictionary: params)
        params["view"] = view()
        engine?.subscribeVideo(params, callback)
    }
    
    @objc func subscribeScreen(_ params: NSDictionary, _ callback: Callback) {
        let params = NSMutableDictionary.init(dictionary: params)
        params["view"] = view()
        engine?.subscribeScreen(params, callback)
    }
    
    @objc func startPreview(_ params: NSDictionary, _ callback: Callback) {
        let params = NSMutableDictionary.init(dictionary: params)
        params["view"] = view()
        engine?.startPreview(params, callback)
    }
    
    //RtcVideoStreamManager
    
    private var videoStreamManager: RtcVideoStreamManager? {
        return rtcEnginePlugin?.rtcVideoStreamManagerPlugin.manager
    }
    
    @objc func startVideoWithStreamId(_ params: NSDictionary, _ callback: Callback) {
        let params = NSMutableDictionary.init(dictionary: params)
        params["view"] = view()
        videoStreamManager?.startVideoWithStreamId(params, callback)
    }
    
    @objc func subscribeVideoWithStreamId(_ params: NSDictionary, _ callback: Callback) {
        let params = NSMutableDictionary.init(dictionary: params)
        params["view"] = view()
        videoStreamManager?.subscribeVideoWithStreamId(params, callback)
    }
    
    //RtcAnnotation
    
    private var annotationCache: RtcAnnotationCache? {
        return rtcEnginePlugin?.rtcAnnotationPlugin.manager
    }
    
    @objc func startAnnotation(_ params: NSDictionary, _ callback: Callback) {
        let params = NSMutableDictionary.init(dictionary: params)
        params["view"] = view()
        annotationCache?.startAnnotation(params, callback)
    }
}

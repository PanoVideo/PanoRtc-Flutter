//
//  PanoRtcGroupPlugin.swift
//  pano_rtc
//
//  Copyright © 2022 Pano. All rights reserved.
//

import Foundation
import Flutter
import PanoRtc

class PanoRtcGroupPlugin: NSObject {
    private final weak var rtcEnginePlugin: SwiftPanoRtcPlugin?
    private var methodChannel: FlutterMethodChannel?
    private var eventChannel: FlutterEventChannel?
    private var eventSink: FlutterEventSink?
    private(set) lazy var manager: RtcGroupManager = {
        let manager = RtcGroupManager()
        manager.delegate = self
        return manager
    }()
    
    init(_ rtcEnginePlugin: SwiftPanoRtcPlugin) {
        self.rtcEnginePlugin = rtcEnginePlugin
    }
    
    func initPlugin(with registrar: FlutterPluginRegistrar) {
        methodChannel = FlutterMethodChannel(name: "pano_rtc/api_group", binaryMessenger: registrar.messenger())
        eventChannel = FlutterEventChannel(name: "pano_rtc/events_group", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(self, channel: methodChannel!)
        eventChannel?.setStreamHandler(self)
    }
}

extension PanoRtcGroupPlugin: FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        methodChannel?.setMethodCallHandler(nil)
        eventChannel?.setStreamHandler(nil)
        manager.cleanup()
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let params = call.arguments as? NSDictionary {
            let selector = NSSelectorFromString(call.method + "::")
            if manager.responds(to: selector) {
                manager.perform(selector, with: params, with: ResultCallback(result))
                return
            }
        } else {
            let selector = NSSelectorFromString(call.method + ":")
            if manager.responds(to: selector) {
                manager.perform(selector, with: ResultCallback(result))
                return
            }
        }
        result(FlutterMethodNotImplemented)
    }
}

extension PanoRtcGroupPlugin: FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}

extension PanoRtcGroupPlugin: RtcGroupManagerDelegate {
    func emit(_ methodName: String, _ data: Dictionary<String, Any?>?) {
        var event: Dictionary<String, Any?> = ["methodName": methodName]
        if let `data` = data {
            event.merge(data) { (current, _) in
                current
            }
        }
        eventSink?(event)
    }
}

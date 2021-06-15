//
//  PanoRtcWhiteboardPlugin.swift
//  pano_rtc
//
//  Created by mark on 2020/12/24.
//

import Foundation
import Flutter
import PanoRtc

class PanoRtcWhiteboardPlugin: NSObject {
    private final weak var rtcEnginePlugin: SwiftPanoRtcPlugin?
    private var methodChannel: FlutterMethodChannel?
    private var eventChannel: FlutterEventChannel?
    private var eventSink: FlutterEventSink?
    private(set) lazy var manager: RtcWhiteboard = {
        let `manager` = RtcWhiteboard()
        manager.delegate = self
        return manager
    }()
    
    init(_ rtcEnginePlugin: SwiftPanoRtcPlugin) {
        self.rtcEnginePlugin = rtcEnginePlugin
    }
    
    func initPlugin(with registrar: FlutterPluginRegistrar) {
        methodChannel = FlutterMethodChannel(name: "pano_rtc/api_whiteboard", binaryMessenger: registrar.messenger())
        eventChannel = FlutterEventChannel(name: "pano_rtc/events_whiteboard", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(self, channel: methodChannel!)
        eventChannel?.setStreamHandler(self)
    }
}

extension PanoRtcWhiteboardPlugin: FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        methodChannel?.setMethodCallHandler(nil)
        eventChannel?.setStreamHandler(nil)
        manager.cleanup()
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let params = call.arguments as? Dictionary<String, Any?> {
            let newParams = params.mapValues { value -> Any? in
                if let `value` = value as? FlutterStandardTypedData {
                    return value.data
                } else {
                    return value
                }
            }
            let selector = NSSelectorFromString(call.method + "::")
            if manager.responds(to: selector) {
                manager.perform(selector, with: newParams, with: ResultCallback(result))
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

extension PanoRtcWhiteboardPlugin: FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}

extension PanoRtcWhiteboardPlugin: RtcWhiteboardDelegate {
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

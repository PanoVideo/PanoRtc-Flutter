import Flutter
import UIKit
import PanoRtc

public class SwiftPanoRtcPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var methodChannel: FlutterMethodChannel?
    private var eventChannel: FlutterEventChannel?
    private var eventSink: FlutterEventSink? = nil
    private(set) lazy var manager: RtcEngineManager = {
        let `manager` = RtcEngineManager()
        manager.delegate = self
        return manager
    }()
    private(set) lazy var rtcVideoStreamManagerPlugin: PanoRtcVideoStreamManagerPlugin = {
        return PanoRtcVideoStreamManagerPlugin(self)
    }()
    private(set) lazy var rtcWhiteboardPlugin: PanoRtcWhiteboardPlugin = {
        return PanoRtcWhiteboardPlugin(self)
    }()
    private(set) lazy var rtcAnnotationManagerPlugin: PanoRtcAnnotationManagerPlugin = {
        return PanoRtcAnnotationManagerPlugin(self)
    }()
    private(set) lazy var rtcAnnotationPlugin: PanoRtcAnnotationPlugin = {
        return PanoRtcAnnotationPlugin(self)
    }()
    private(set) lazy var rtcMessagePlugin: PanoRtcMessagePlugin = {
        return PanoRtcMessagePlugin(self)
    }()
    private(set) lazy var rtcNetworkManagerPlugin: PanoRtcNetworkManagerPlugin = {
        return PanoRtcNetworkManagerPlugin(self)
    }()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let rtcEnginePlugin = SwiftPanoRtcPlugin()
        rtcEnginePlugin.rtcVideoStreamManagerPlugin.initPlugin(with: registrar)
        rtcEnginePlugin.rtcWhiteboardPlugin.initPlugin(with: registrar)
        rtcEnginePlugin.rtcAnnotationManagerPlugin.initPlugin(with: registrar)
        rtcEnginePlugin.rtcAnnotationPlugin.initPlugin(with: registrar)
        rtcEnginePlugin.rtcMessagePlugin.initPlugin(with: registrar)
        rtcEnginePlugin.rtcNetworkManagerPlugin.initPlugin(with: registrar)
        rtcEnginePlugin.initPlugin(registrar)
    }
    
    private func initPlugin(_ registrar: FlutterPluginRegistrar) {
        methodChannel = FlutterMethodChannel(name: "pano_rtc/api_engine", binaryMessenger: registrar.messenger())
        eventChannel = FlutterEventChannel(name: "pano_rtc/events_engine", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(self, channel: methodChannel!)
        eventChannel?.setStreamHandler(self)
        
        let viewFactory = PanoNativeViewFactory(registrar.messenger(), self)
        registrar.register(viewFactory, withId: "PanoNativeView")
        
        let whiteboardViewFactory = PanoWhiteboardNativeViewFactory(registrar.messenger(), self)
        registrar.register(whiteboardViewFactory, withId: "PanoWhiteboardNativeView")
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        rtcVideoStreamManagerPlugin.detachFromEngine(for: registrar)
        rtcWhiteboardPlugin.detachFromEngine(for: registrar)
        rtcAnnotationManagerPlugin.detachFromEngine(for: registrar)
        rtcAnnotationPlugin.detachFromEngine(for: registrar)
        rtcMessagePlugin.detachFromEngine(for: registrar)
        rtcNetworkManagerPlugin.detachFromEngine(for: registrar)
        
        methodChannel?.setMethodCallHandler(nil)
        eventChannel?.setStreamHandler(nil)
        manager.cleanup()
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
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

extension SwiftPanoRtcPlugin: RtcEngineManagerDelegate {
    internal func emit(_ methodName: String, _ data: Dictionary<String, Any?>?) {
        var event: Dictionary<String, Any?> = ["methodName": methodName]
        if let `data` = data {
            event.merge(data) { (current, _) in
                current
            }
        }
        eventSink?(event)
    }
    
    func createWhiteboardEngineIfNeeded(whiteboardId: String) {
        let whiteboardManager = rtcWhiteboardPlugin.manager
        if whiteboardManager[whiteboardId] == nil {
            whiteboardManager.create(whiteboardId, (manager.engine)!)
        }
    }
    
    func createVideoStreamManager(panoObj: PanoRtcVideoStreamManager?) -> RtcVideoStreamManager? {
        let videoStreamManager = rtcVideoStreamManagerPlugin.manager
        videoStreamManager.setup(manager: panoObj)
        return videoStreamManager
    }
    
    func createAnnotationManager(panoObj: PanoRtcAnnotationManager?) -> RtcAnnotationManager? {
        let annotationManager = rtcAnnotationManagerPlugin.manager
        annotationManager.setup(manager: panoObj)
        return annotationManager
    }
    
    func createMessageService(panoObj: PanoRtcMessage?) -> RtcMessage? {
        let messageService = rtcMessagePlugin.service
        messageService.setup(service: panoObj)
        return messageService
    }
    
    func createNetworkManager(panoObj: PanoRtcEngineKit?) -> RtcNetworkManager? {
        let networkManager = rtcNetworkManagerPlugin.manager
        networkManager.setup(engine: panoObj)
        return networkManager
    }
    
    func cleanup() {
        rtcVideoStreamManagerPlugin.manager.cleanup()
        rtcWhiteboardPlugin.manager.cleanup()
        rtcAnnotationManagerPlugin.manager.cleanup()
        rtcAnnotationPlugin.manager.cleanup()
        rtcMessagePlugin.service.cleanup()
        rtcNetworkManagerPlugin.manager.cleanup()
    }
}

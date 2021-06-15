//
//  RtcVideoStreamManager.swift
//  pano_rtc
//
//  Copyright © 2021 Pano. All rights reserved.
//

import Foundation
import PanoRtc

protocol RtcVideoStreamManagerInterface {
    func createVideoStream(_ params: NSDictionary, _ callback: Callback)
    
    func destroyVideoStream(_ params: NSDictionary, _ callback: Callback)
    
    func setCaptureDevice(_ params: NSDictionary, _ callback: Callback)
    
    func getCaptureDevice(_ params: NSDictionary, _ callback: Callback)
    
    func startVideoWithStreamId(_ params: NSDictionary, _ callback: Callback)
    
    func stopVideo(_ params: NSDictionary, _ callback: Callback)
    
    func muteVideo(_ params: NSDictionary, _ callback: Callback)
    
    func unmuteVideo(_ params: NSDictionary, _ callback: Callback)
    
    func subscribeVideoWithStreamId(_ params: NSDictionary, _ callback: Callback)
    
    func unsubscribeVideo(_ params: NSDictionary, _ callback: Callback)
    
    func snapshotVideo(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcVideoStreamManagerDelegate: AnyObject {
    func emit(_ methodName: String, _ data: Dictionary<String, Any?>?)
}

@objc
class RtcVideoStreamManager: NSObject, RtcVideoStreamManagerInterface {
    weak var delegate: RtcVideoStreamManagerDelegate?
    private var manager: PanoRtcVideoStreamManager?
    private lazy var managerDelegate: PanoRtcVideoStreamDelegateHandler = {
        PanoRtcVideoStreamDelegateHandler() { [weak self] methodName, data in
            self?.delegate?.emit(methodName, data)
        }
    }()
    
    func setup(manager: PanoRtcVideoStreamManager?) {
        self.manager = manager
        self.manager?.setDelegate(self.managerDelegate)
    }
    
    func cleanup() {
        manager?.setDelegate(nil)
        manager = nil
    }
    
    @objc func createVideoStream(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(manager) { $0.createVideoStream(params["deviceId"] as! String) }
    }
    
    @objc func destroyVideoStream(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.destroyVideoStream(params["streamId"] as! Int32))
    }
    
    @objc func setCaptureDevice(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            manager?.setCaptureDevice(params["deviceId"] as! String,
                                      stream: params["streamId"] as! Int32))
    }
    
    @objc func getCaptureDevice(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(manager) { $0.getCaptureDevice(params["streamId"] as! Int32) }
    }
    
    @objc func startVideoWithStreamId(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            manager?.startVideo(params["streamId"] as! Int32,
                                view: params["view"] as! UIView,
                                config: PanoRtcRenderConfig(map: params["config"] as! Dictionary)))
    }
    
    @objc func stopVideo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.stopVideo(params["streamId"] as! Int32))
    }
    
    @objc func muteVideo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.muteVideo(params["streamId"] as! Int32))
    }
    
    @objc func unmuteVideo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.unmuteVideo(params["streamId"] as! Int32))
    }
    
    @objc func subscribeVideoWithStreamId(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            manager?.subscribeVideo(UInt64(params["userId"] as! String) ?? 0,
                                    stream: params["streamId"] as! Int32,
                                    view: params["view"] as! UIView,
                                    config: PanoRtcRenderConfig(map: params["config"] as! Dictionary)))
    }
    
    @objc func unsubscribeVideo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            manager?.unsubscribeVideo(UInt64(params["userId"] as! String) ?? 0,
                                      stream: params["streamId"] as! Int32))
    }
    
    @objc func snapshotVideo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            manager?.snapshotVideo(UInt64(params["userId"] as! String) ?? 0,
                                   stream: params["streamId"] as! Int32,
                                   outputDir: params["outputDir"] as! String,
                                   option: PanoRtcSnapshotVideoOption(map: params["option"] as! Dictionary)))
    }
}

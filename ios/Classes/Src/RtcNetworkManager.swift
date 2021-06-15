//
//  RtcNetworkManager.swift
//  pano_rtc
//
//  Copyright © 2021 Pano. All rights reserved.
//

import Foundation
import PanoRtc

protocol RtcNetworkManagerInterface {
    func startNetworkTest(_ params: NSDictionary, _ callback: Callback)
    
    func stopNetworkTest(_ callback: Callback)
}

protocol RtcNetworkManagerDelegate: AnyObject {
    func emit(_ methodName: String, _ data: Dictionary<String, Any?>?)
}

@objc
class RtcNetworkManager: NSObject, RtcNetworkManagerInterface {
    weak var delegate: RtcNetworkManagerDelegate?
    private var engine: PanoRtcEngineKit?
    private lazy var networkDelegate: PanoRtcNetworkTestDelegateHandler = {
        PanoRtcNetworkTestDelegateHandler() { [weak self] methodName, data in
            self?.delegate?.emit(methodName, data)
        }
    }()
    
    func setup(engine: PanoRtcEngineKit?) {
        self.engine = engine
    }
    
    func cleanup() {
        engine = nil;
    }
    
    @objc func startNetworkTest(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.startNetworkTest(withToken: params["token"] as! String,
                                     delegate: networkDelegate))
    }
    
    @objc func stopNetworkTest(_ callback: Callback) {
        callback.code(engine?.stopNetworkTest())
    }
}

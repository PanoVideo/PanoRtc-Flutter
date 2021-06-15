//
//  RtcMessage.swift
//  pano_rtc
//
//  Created by mark on 2021/4/6.
//

import Foundation
import PanoRtc

protocol RtcMessageInterface {
    func sendMessage(_ params: NSDictionary, _ callback: Callback)
    
    func broadcastMessage(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcMessageDelegate: AnyObject {
    func emit(_ methodName: String, _ data: Dictionary<String, Any?>?)
}

@objc
class RtcMessage: NSObject, RtcMessageInterface {
    weak var delegate: RtcMessageDelegate?
    private var service: PanoRtcMessage?
    private lazy var serviceDelegate: PanoRtcMessageDelegateHandler = {
        PanoRtcMessageDelegateHandler() { [weak self] methodName, data in
            self?.delegate?.emit(methodName, data)
        }
    }()
    
    func setup(service: PanoRtcMessage?) {
        self.service = service
        self.service?.delegate = self.serviceDelegate
    }
    
    func cleanup() {
        service?.delegate = nil
        service = nil
    }
    
    @objc func sendMessage(_ params: NSDictionary, _ callback: Callback) {
        guard let data = params["message"] as? Data else {
            callback.code(PanoResult.invalidArgs)
            return
        }
        
        callback.code(service?.send(toUser: UInt64(params["userId"] as! String) ?? 0, data: data))
    }
    
    @objc func broadcastMessage(_ params: NSDictionary, _ callback: Callback) {
        guard let data = params["message"] as? Data else {
            callback.code(PanoResult.invalidArgs)
            return
        }
        
        callback.code(service?.broadcast(data, sendBack: params["sendBack"] as! Bool))
    }
}

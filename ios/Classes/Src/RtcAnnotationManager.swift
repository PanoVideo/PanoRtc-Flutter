//
//  RtcAnnotationManager.swift
//  pano_rtc
//
//  Copyright © 2021 Pano. All rights reserved.
//

import Foundation
import PanoRtc

protocol RtcAnnotationManagerInterface {
    func getVideoAnnotation(_ params: NSDictionary, _ callback: Callback)
    
    func getShareAnnotation(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcAnnotationManagerDelegate: AnyObject {
    func emit(_ methodName: String, _ data: Dictionary<String, Any?>?)
    
    func createAnnotationIfNeeded(_ annotationId: String, _ annotation: PanoRtcAnnotation)
}

@objc
class RtcAnnotationManager: NSObject, RtcAnnotationManagerInterface {
    weak var delegate: RtcAnnotationManagerDelegate?
    private var manager: PanoRtcAnnotationManager?
    private lazy var managerDelegate: PanoRtcAnnotationManagerDelegateHandler = {
        PanoRtcAnnotationManagerDelegateHandler() { [weak self] methodName, data in
            self?.delegate?.emit(methodName, data)
        }
    }()
    
    func setup(manager: PanoRtcAnnotationManager?) {
        self.manager = manager
        self.manager?.setDelegate(self.managerDelegate)
    }
    
    func cleanup() {
        manager?.setDelegate(nil)
        manager = nil
    }
    
    @objc func getVideoAnnotation(_ params: NSDictionary, _ callback: Callback) {
        let userId = UInt64(params["userId"] as! String) ?? 0
        let streamId = params["streamId"] as! Int32
        if let annotation = manager?.videoAnnotation(userId, stream: streamId) {
            let annotationId = "\(userId)-\(streamId)"
            delegate?.createAnnotationIfNeeded(annotationId, annotation)
            callback.resolve(manager) { _ in
                annotationId
            }
        } else {
            callback.success(nil)
        }
    }
    
    @objc func getShareAnnotation(_ params: NSDictionary, _ callback: Callback) {
        let userId = UInt64(params["userId"] as! String) ?? 0
        if let annotation = manager?.shareAnnotation(userId) {
            let annotationId = "\(userId)"
            delegate?.createAnnotationIfNeeded(annotationId, annotation)
            callback.resolve(manager) { _ in
                annotationId
            }
        } else {
            callback.success(nil)
        }
    }
}

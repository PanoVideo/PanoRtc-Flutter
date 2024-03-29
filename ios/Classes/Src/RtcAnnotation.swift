//
//  RtcAnnotation.swift
//  pano_rtc
//
//  Copyright © 2022 Pano. All rights reserved.
//

import Foundation
import PanoRtc

protocol RtcAnnotationInterface {
    func setRoleType(_ params: NSDictionary, _ callback: Callback)
    
    func startAnnotation(_ params: NSDictionary, _ callback: Callback)
    
    func stopAnnotation(_ params: NSDictionary, _ callback: Callback)
    
    func setVisible(_ params: NSDictionary, _ callback: Callback)
    
    func setToolType(_ params: NSDictionary, _ callback: Callback)
    
    func setLineWidth(_ params: NSDictionary, _ callback: Callback)
    
    func setColor(_ params: NSDictionary, _ callback: Callback)
    
    func setFillType(_ params: NSDictionary, _ callback: Callback)
    
    func setFillColor(_ params: NSDictionary, _ callback: Callback)
    
    func setFontStyle(_ params: NSDictionary, _ callback: Callback)
    
    func setFontSize(_ params: NSDictionary, _ callback: Callback)
    
    func undo(_ params: NSDictionary, _ callback: Callback)
    
    func redo(_ params: NSDictionary, _ callback: Callback)
    
    func clearUserContents(_ params: NSDictionary, _ callback: Callback)
    
    func clearContents(_ params: NSDictionary, _ callback: Callback)
    
    func snapshot(_ params: NSDictionary, _ callback: Callback)
    
    func getToolType(_ params: NSDictionary, _ callback: Callback)
    
    func setAspectSize(_ params: NSDictionary, _ callback: Callback)
    
    func setScalingMode(_ params: NSDictionary, _ callback: Callback)
    
    func setOption(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcAnnotationDelegate: AnyObject {
    func emit(_ methodName: String, _ data: Dictionary<String, Any?>?)
}

@objc
class RtcAnnotationCache: NSObject, RtcAnnotationInterface {
    weak var delegate: RtcAnnotationDelegate?
    private var annotationMap = [String: PanoRtcAnnotation]()
    private var annotationDelegateMap = [String: PanoRtcAnnotationDelegateHandler]()
    
    func cleanup() {
        annotationMap.removeAll()
        annotationDelegateMap.removeAll()
    }
    
    subscript(annotationId: String) -> PanoRtcAnnotation? {
        get {
            return annotationMap[annotationId]
        }
    }
    
    func create(_ annotationId: String, _ annotation: PanoRtcAnnotation) {
        let annotationDelegate = PanoRtcAnnotationDelegateHandler() { [weak self] methodName, data in
            var newData: [String: Any?] = ["annotationId": annotationId]
            newData.merge(data ?? [:]) { $1 }
            self?.delegate?.emit(methodName, newData)
        }
        annotation.setDelegate(annotationDelegate)
        annotationMap[annotationId] = annotation
        annotationDelegateMap[annotationId] = annotationDelegate
    }
    
    @objc func setRoleType(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.setRoleType(PanoWBRoleType(rawValue: params["type"] as! Int)!))
    }
    
    @objc func startAnnotation(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.start(params["view"] as? UIView))
    }
    
    @objc func stopAnnotation(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.stop())
    }
    
    @objc func setVisible(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.setVisible(params["visible"] as! Bool))
    }
    
    @objc func setToolType(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.setToolType(PanoWBToolType(rawValue: params["type"] as! Int)!))
    }
    
    @objc func setLineWidth(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.setLineWidth(params["size"] as! UInt32))
    }
    
    @objc func setColor(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.setColor(PanoWBColor(map: params["color"] as! Dictionary)))
    }
    
    @objc func setFillType(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.setFillType(PanoWBFillType(rawValue: params["type"] as! Int)!))
    }
    
    @objc func setFillColor(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.setFill(PanoWBColor(map: params["color"] as! Dictionary)))
    }
    
    @objc func setFontStyle(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.setFontStyle(PanoWBFontStyle(rawValue: params["style"] as! Int)!))
    }
    
    @objc func setFontSize(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.setFontSize(params["size"] as! UInt32))
    }
    
    @objc func undo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.undo())
    }
    
    @objc func redo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.redo())
    }
    
    @objc func clearUserContents(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.clearUserContents(UInt64(params["userId"] as! String) ?? 0))
    }
    
    @objc func clearContents(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.clearContents())
    }
    
    @objc func snapshot(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.snapshot(params["outputDir"] as! String))
    }
    
    @objc func getToolType(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["annotationId"] as! String]) { $0.getToolType() }
    }
    
    @objc func setAspectSize(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.setAspectWidth(params["w"] as! UInt32, height: params["h"] as! UInt32))
    }
    
    @objc func setScalingMode(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["annotationId"] as! String]?.setScalingMode(PanoVideoScalingMode(rawValue: params["mode"] as! Int)!))
    }
    
    @objc func setOption(_ params: NSDictionary, _ callback: Callback) {
        var option: NSObject? = nil
        let type = PanoAnnoOptionType(rawValue: params["type"] as! Int)
        var isValid = true
        switch type {
        case .enableLocalRender:
            option = NSNumber(value: params["option"] as! Bool)
        case .showDraws:
            option = NSNumber(value: params["option"] as! Bool)
        case .enableUIResponse:
            option = NSNumber(value: params["option"] as! Bool)
        case .cursorPosSync:
            option = NSNumber(value: params["option"] as! Bool)
        case .showRemoteCursor:
            option = NSNumber(value: params["option"] as! Bool)
        default:
            isValid = false
        }
        if isValid {
            callback.code(self[params["annotationId"] as! String]?.setOption(option, for: type!))
        } else {
            callback.code(PanoResult.invalidArgs)
        }
    }
}

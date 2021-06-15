//
//  RtcWhiteboard.swift
//  pano_rtc
//
//  Copyright © 2021 Pano. All rights reserved.
//

import Foundation
import PanoRtc

protocol RtcWhiteboardInterfce {
    func open(_ params: NSDictionary, _ callback: Callback)
    
    func close(_ params: NSDictionary, _ callback: Callback)
    
    func leave(_ params: NSDictionary, _ callback: Callback)
    
    func stop(_ params: NSDictionary, _ callback: Callback)
    
    func getCurrentWhiteboardId(_ params: NSDictionary, _ callback: Callback)
    
    func setRoleType(_ params: NSDictionary, _ callback: Callback)
    
    func setToolType(_ params: NSDictionary, _ callback: Callback)
    
    func getToolType(_ params: NSDictionary, _ callback: Callback)
    
    func setLineWidth(_ params: NSDictionary, _ callback: Callback)
    
    func setFillType(_ params: NSDictionary, _ callback: Callback)
    
    func setFillColor(_ params: NSDictionary, _ callback: Callback)
    
    func setForegroundColor(_ params: NSDictionary, _ callback: Callback)
    
    func setBackgroundColor(_ params: NSDictionary, _ callback: Callback)
    
    func setFontStyle(_ params: NSDictionary, _ callback: Callback)
    
    func setFontSize(_ params: NSDictionary, _ callback: Callback)
    
    func addStamp(_ params: NSDictionary, _ callback: Callback)
    
    func setStamp(_ params: NSDictionary, _ callback: Callback)
    
    func setBackgroundImageScalingMode(_ params: NSDictionary, _ callback: Callback)
    
    func setBackgroundImage(_ params: NSDictionary, _ callback: Callback)
    
    func setBackgroundImageWithPage(_ params: NSDictionary, _ callback: Callback)

    func getCurrentPageNumber(_ params: NSDictionary, _ callback: Callback)
    
    func getTotalNumberOfPages(_ params: NSDictionary, _ callback: Callback)
    
    func addPage(_ params: NSDictionary, _ callback: Callback)
    
    func insertPage(_ params: NSDictionary, _ callback: Callback)
    
    func removePage(_ params: NSDictionary, _ callback: Callback)
    
    func gotoPage(_ params: NSDictionary, _ callback: Callback)
    
    func nextPage(_ params: NSDictionary, _ callback: Callback)
    
    func prevPage(_ params: NSDictionary, _ callback: Callback)
    
    func nextStep(_ params: NSDictionary, _ callback: Callback)
    
    func prevStep(_ params: NSDictionary, _ callback: Callback)
    
    func addImageFile(_ params: NSDictionary, _ callback: Callback)
    
    func addAudioFile(_ params: NSDictionary, _ callback: Callback)
    
    func addVideoFile(_ params: NSDictionary, _ callback: Callback)
    
    func addBackgroundImages(_ params: NSDictionary, _ callback: Callback)
    
    func addH5File(_ params: NSDictionary, _ callback: Callback)
    
    func addDoc(_ params: NSDictionary, _ callback: Callback)
    
    func createDocWithImages(_ params: NSDictionary, _ callback: Callback)
    
    func createDocWithFilePath(_ params: NSDictionary, _ callback: Callback)
    
    func deleteDoc(_ params: NSDictionary, _ callback: Callback)
    
    func switchDoc(_ params: NSDictionary, _ callback: Callback)
    
    func saveDocToImages(_ params: NSDictionary, _ callback: Callback)

    func enumerateFiles(_ params: NSDictionary, _ callback: Callback)
    
    func getCurrentFileId(_ params: NSDictionary, _ callback: Callback)
    
    func getFileInfo(_ params: NSDictionary, _ callback: Callback)
    
    func clearContents(_ params: NSDictionary, _ callback: Callback)
    
    func clearUserContents(_ params: NSDictionary, _ callback: Callback)
    
    func undo(_ params: NSDictionary, _ callback: Callback)
    
    func redo(_ params: NSDictionary, _ callback: Callback)
    
    func getCurrentScaleFactor(_ params: NSDictionary, _ callback: Callback)
    
    func setCurrentScaleFactor(_ params: NSDictionary, _ callback: Callback)
    
    func snapshot(_ params: NSDictionary, _ callback: Callback)
    
    func startFollowVision(_ params: NSDictionary, _ callback: Callback)
    
    func startShareVision(_ params: NSDictionary, _ callback: Callback)
    
    func stopFollowVision(_ params: NSDictionary, _ callback: Callback)
    
    func stopShareVision(_ params: NSDictionary, _ callback: Callback)
    
    func syncVision(_ params: NSDictionary, _ callback: Callback)
    
    func sendMessage(_ params: NSDictionary, _ callback: Callback)
    
    func broadcastMessage(_ params: NSDictionary, _ callback: Callback)
    
    func setOption(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcWhiteboardDelegate: AnyObject {
    func emit(_ methodName: String, _ data: Dictionary<String, Any?>?)
}

@objc
class RtcWhiteboard: NSObject, RtcWhiteboardInterfce {
    weak var delegate: RtcWhiteboardDelegate?
    private var whiteboardEngineMap = [String: PanoRtcWhiteboard]()
    private var whiteboardEngineDelegateMap = [String: PanoRtcWhiteboardDelegateHandler]()
    
    func cleanup() {
        whiteboardEngineMap.removeAll()
        whiteboardEngineDelegateMap.removeAll()
    }
    
    subscript(whiteboardId: String) -> PanoRtcWhiteboard? {
        get {
            return whiteboardEngineMap[whiteboardId]
        }
    }
    
    func create(_ whiteboardId: String, _ engine: PanoRtcEngineKit) {
        let engineDelegate = PanoRtcWhiteboardDelegateHandler() { [weak self] methodName, data in
            var newData: [String: Any?] = ["whiteboardId": whiteboardId]
            newData.merge(data ?? [:]) { $1 }
            self?.delegate?.emit(methodName, newData)
        }
        let whiteboardEngine = engine.whiteboardEngine()
        whiteboardEngine.setDelegate(engineDelegate)
        whiteboardEngineMap[whiteboardId] = whiteboardEngine
        whiteboardEngineDelegateMap[whiteboardId] = engineDelegate
    }
    
    @objc func open(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.open(params["view"] as! UIView))
    }
    
    @objc func close(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.close())
    }
    
    @objc func leave(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.leave())
    }
    
    @objc func stop(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.stop())
    }
    
    @objc func getCurrentWhiteboardId(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) { $0.getCurrentWhiteboardId() }
    }
    
    @objc func setRoleType(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            self[params["whiteboardId"] as! String]?.setRoleType(PanoWBRoleType(rawValue: params["type"] as! Int)!))
    }
    
    @objc func setToolType(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            self[params["whiteboardId"] as! String]?.setToolType(PanoWBToolType(rawValue: params["type"] as! Int)!))
    }
    
    @objc func getToolType(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) { $0.getToolType() }
    }
    
    @objc func setLineWidth(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.setLineWidth(params["width"] as! UInt32))
    }
    
    @objc func setFillType(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            self[params["whiteboardId"] as! String]?.setFillType(PanoWBFillType(rawValue: params["type"] as! Int)!))
    }
    
    @objc func setFillColor(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.setFill(PanoWBColor(map: params["color"] as! [String: Any])))
    }
    
    @objc func setForegroundColor(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.setForegroundColor(PanoWBColor(map: params["color"] as! [String: Any])))
    }
    
    @objc func setBackgroundColor(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.setBackgroundColor(PanoWBColor(map: params["color"] as! [String: Any])))
    }
    
    @objc func setFontStyle(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.setFontStyle(PanoWBFontStyle(rawValue: params["style"] as! Int)!))
    }
    
    @objc func setFontSize(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.setFontSize(params["size"] as! UInt32))
    }
    
    @objc func addStamp(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.add(PanoWBStamp(map: params["stamp"] as! [String: Any])))
    }
    
    @objc func setStamp(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.setStamp(params["stampId"] as! String))
    }
    
    @objc func setBackgroundImageScalingMode(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            self[params["whiteboardId"] as! String]?.setBackgroundImageScalingMode(
                PanoWBImageScalingMode(rawValue: params["mode"] as! Int)!))
    }
    
    @objc func setBackgroundImage(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.setBackgroundImage(params["imageUrl"] as! String))
    }
    
    @objc func setBackgroundImageWithPage(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            self[params["whiteboardId"] as! String]?.setBackgroundImage(params["imageUrl"] as! String,
                                       withPageNumber: params["pageNo"] as! PanoWBPageNumber))
    }
    
    @objc func getCurrentPageNumber(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) { $0.getCurrentPageNumber() }
    }
    
    @objc func getTotalNumberOfPages(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) { $0.getTotalNumberOfPages() }
    }
    
    @objc func addPage(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.addPage(params["autoSwitch"] as! Bool))
    }
    
    @objc func insertPage(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            self[params["whiteboardId"] as! String]?.insertPage(params["pageNo"] as! PanoWBPageNumber,
                               autoSwitch: params["autoSwitch"] as! Bool))
    }
    
    @objc func removePage(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            self[params["whiteboardId"] as! String]?.removePage(params["pageNo"] as! PanoWBPageNumber,
                               switchNext: params["switchNext"] as! Bool))
    }
    
    @objc func gotoPage(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.gotoPage(params["pageNo"] as! PanoWBPageNumber))
    }
    
    @objc func nextPage(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.nextPage())
    }
    
    @objc func prevPage(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.prevPage())
    }
    
    @objc func nextStep(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.nextStep())
    }
    
    @objc func prevStep(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.prevStep())
    }
    
    @objc func addImageFile(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.addImageFile(params["imageUrl"] as! String))
    }
    
    @objc func addAudioFile(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.addAudioFile(params["mediaUrl"] as! String))
    }
    
    @objc func addVideoFile(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.addVideoFile(params["mediaUrl"] as! String))
    }
    
    @objc func addBackgroundImages(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) { $0.addBackgroundImages(params["urls"] as! [String]) }
    }
    
    @objc func addH5File(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) {
            $0.addH5File(params["url"] as! String, download: params["downloadUrl"] as? String)
        }
    }
    
    @objc func addDoc(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) { $0.addDoc(PanoWBDocContents(map: params["contents"] as! [String: Any])) }
    }
    
    @objc func createDocWithImages(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) { $0.createDoc(withImages: params["urls"] as! [String]) }
    }
    
    @objc func createDocWithFilePath(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) { whiteboard in
            if let config = params["config"] as? [String: Any] {
                return whiteboard.createDoc(withFilePath: params["filePath"] as! String, convertParam: PanoWBConvertConfig(map: config))
            } else {
                return whiteboard.createDoc(withFilePath: params["filePath"] as! String)
            }
        }
    }
    
    @objc func deleteDoc(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.deleteDoc(params["fileId"] as! String))
    }
    
    @objc func switchDoc(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.switchDoc(params["fileId"] as! String))
    }
    
    @objc func saveDocToImages(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            self[params["whiteboardId"] as! String]?.saveDoc(toImages: params["fileId"] as! String,
                            path: params["outputDir"] as! String))
    }
    
    @objc func enumerateFiles(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) { $0.enumerateFiles() }
    }
    
    @objc func getCurrentFileId(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) { $0.getCurrentFileId() }
    }
    
    @objc func getFileInfo(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) {
            $0.getFileInfo(params["fileId"] as! String)?.toMap()
        }
    }
    
    @objc func clearContents(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            self[params["whiteboardId"] as! String]?.clearContents(params["curPage"] as! Bool,
                                  with: PanoWbClearType(rawValue: params["type"] as! Int)!))
    }
    
    @objc func clearUserContents(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            self[params["whiteboardId"] as! String]?.clearUserContents(UInt64(params["userId"] as! String) ?? 0,
                                      currentPage: params["curPage"] as! Bool,
                                      with: PanoWbClearType(rawValue: params["type"] as! Int)!))
    }
    
    @objc func undo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.undo())
    }
    
    @objc func redo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.redo())
    }
    
    @objc func getCurrentScaleFactor(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["whiteboardId"] as! String]) { $0.getCurrentScaleFactor() }
    }
    
    @objc func setCurrentScaleFactor(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.setCurrentScaleFactor(Float32(params["scale"] as! Double)))
    }
    
    @objc func snapshot(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            self[params["whiteboardId"] as! String]?.snapshot(PanoWBSnapshotMode(rawValue: params["mode"] as! Int)!,
                             path: params["outputDir"] as! String))
    }
    
    @objc func startFollowVision(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.startFollowVision())
    }
    
    @objc func startShareVision(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.startShareVision())
    }
    
    @objc func stopFollowVision(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.stopFollowVision())
    }
    
    @objc func stopShareVision(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.stopShareVision())
    }
    
    @objc func syncVision(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["whiteboardId"] as! String]?.syncVision())
    }
    
    @objc func sendMessage(_ params: NSDictionary, _ callback: Callback) {
        guard let data = params["message"] as? Data else {
            callback.code(PanoResult.invalidArgs)
            return
        }
        
        callback.code(self[params["whiteboardId"] as! String]?.sendMessage(data, toUser: UInt64(params["userId"] as! String) ?? 0))
    }
    
    @objc func broadcastMessage(_ params: NSDictionary, _ callback: Callback) {
        guard let data = params["message"] as? Data else {
            callback.code(PanoResult.invalidArgs)
            return
        }
        
        callback.code(self[params["whiteboardId"] as! String]?.broadcastMessage(data))
    }
    
    @objc func setOption(_ params: NSDictionary, _ callback: Callback) {
        var option: NSObject? = nil
        let type = PanoWBOptionType(rawValue: params["type"] as! Int)
        var isValid = true
        switch type {
        case .fileCachePath:
            option = params["option"] as! NSString
        case .enableUIResponse:
            option = NSNumber(value: params["option"] as! Bool)
        case .showDraws:
            option = NSNumber(value: params["option"] as! Bool)
        case .scaleMove:
            option = NSNumber(value: params["option"] as! Bool)
        case .autoSelected:
            option = NSNumber(value: params["option"] as! Bool)
        default:
            isValid = false
        }
        if isValid {
            callback.code(self[params["whiteboardId"] as! String]?.setOption(option, for: type!))
        } else {
            callback.code(PanoResult.invalidArgs)
        }
    }
}

//
//  RtcEngine.swift
//  pano_rtc
//
//  Copyright © 2021 Pano. All rights reserved.
//

import Foundation
import PanoRtc

protocol RtcEngineManagerInterface:
    RtcDeviceManagerInterface,
    RtcAudioMixingManagerInterface,
    RtcSnapshotInterface,
    RtcWhiteboardManagerInterface,
    RtcTroubleshootInterface,
    RtcOptionInterface,
    RtcCustomizedInterface,
    RtcManagersInterface {
    func create(_ params: NSDictionary, _ callback: Callback)
    
    func destroy(_ callback: Callback)
    
    func setLogLevel(_ params: NSDictionary, _ callback: Callback)
    
    func getSdkVersion(_ callback: Callback)
    
    func updateConfig(_ params: NSDictionary, _ callback: Callback)
    
    func joinChannel(_ params: NSDictionary, _ callback: Callback)
    
    func leaveChannel(_ callback: Callback)
    
    func startAudio(_ callback: Callback)
    
    func stopAudio(_ callback: Callback)
    
    func startVideo(_ params: NSDictionary, _ callback: Callback)
    
    func stopVideo(_ callback: Callback)
    
    func startScreen(_ params: NSDictionary, _ callback: Callback)
    
    func stopScreen(_ callback: Callback)
    
    func subscribeAudio(_ params: NSDictionary, _ callback: Callback)
    
    func unsubscribeAudio(_ params: NSDictionary, _ callback: Callback)
    
    func subscribeVideo(_ params: NSDictionary, _ callback: Callback)
    
    func unsubscribeVideo(_ params: NSDictionary, _ callback: Callback)
    
    func subscribeScreen(_ params: NSDictionary, _ callback: Callback)
    
    func unsubscribeScreen(_ params: NSDictionary, _ callback: Callback)
    
    func updateScreenScaling(_ params: NSDictionary, _ callback: Callback)
    
    func updateScreenScalingWithFocus(_ params: NSDictionary, _ callback: Callback)
    
    func updateScreenMoving(_ params: NSDictionary, _ callback: Callback)
    
    func muteAudio(_ callback: Callback)
    
    func unmuteAudio(_ callback: Callback)
    
    func muteVideo(_ callback: Callback)
    
    func unmuteVideo(_ callback: Callback)
    
    func muteScreen(_ callback: Callback)
    
    func unmuteScreen(_ callback: Callback)
}

protocol RtcDeviceManagerInterface {
    func setMicrophoneMuteStatus(_ params: NSDictionary, _ callback: Callback)
    
    func setAudioDeviceVolume(_ params: NSDictionary, _ callback: Callback)
    
    func getAudioDeviceVolume(_ params: NSDictionary, _ callback: Callback)
    
    func getRecordingLevel(_ callback: Callback)
    
    func getPlayoutLevel(_ callback: Callback)
    
    func setLoudspeakerStatus(_ params: NSDictionary, _ callback: Callback)
    
    func isEnabledLoudspeaker(_ callback: Callback)
    
    func switchCamera(_ callback: Callback)
    
    func isFrontCamera(_ callback: Callback)
    
    func getCameraDeviceId(_ params: NSDictionary, _ callback: Callback)
    
    func startPreview(_ params: NSDictionary, _ callback: Callback)
    
    func stopPreview(_ callback: Callback)
}

protocol RtcAudioMixingManagerInterface {
    func createAudioMixingTask(_ params: NSDictionary, _ callback: Callback)
    
    func destroyAudioMixingTask(_ params: NSDictionary, _ callback: Callback)
    
    func startAudioMixingTask(_ params: NSDictionary, _ callback: Callback)
    
    func updateAudioMixingTask(_ params: NSDictionary, _ callback: Callback)
    
    func stopAudioMixingTask(_ params: NSDictionary, _ callback: Callback)
    
    func resumeAudioMixing(_ params: NSDictionary, _ callback: Callback)
    
    func pauseAudioMixing(_ params: NSDictionary, _ callback: Callback)
    
    func getAudioMixingDuration(_ params: NSDictionary, _ callback: Callback)
    
    func getAudioMixingCurrentTimestamp(_ params: NSDictionary, _ callback: Callback)
    
    func seekAudioMixing(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcSnapshotInterface {
    func snapshotVideo(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcWhiteboardManagerInterface {
    func whiteboardEngine(_ callback: Callback)
    
    func switchWhiteboardEngine(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcTroubleshootInterface {
    func startAudioDumpWithFilePath(_ params: NSDictionary, _ callback: Callback)
    
    func stopAudioDump(_ callback: Callback)
    
    func sendFeedback(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcOptionInterface {
    func setOption(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcCustomizedInterface {
    func setParameters(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcManagersInterface {
    func videoStreamManager(_ callback: Callback)
    
    func annotationManager(_ callback: Callback)
    
    func messageService(_ callback: Callback)
    
    func networkManager(_ callback: Callback)
}


protocol RtcEngineManagerDelegate: AnyObject {
    func emit(_ methodName: String, _ data: Dictionary<String, Any?>?)
    
    func createWhiteboardEngineIfNeeded(whiteboardId: String)
    
    func createVideoStreamManager(panoObj: PanoRtcVideoStreamManager?) -> RtcVideoStreamManager?
    
    func createAnnotationManager(panoObj: PanoRtcAnnotationManager?) -> RtcAnnotationManager?
    
    func createMessageService(panoObj: PanoRtcMessage?) -> RtcMessage?
    
    func createNetworkManager(panoObj: PanoRtcEngineKit?) -> RtcNetworkManager?
    
    func cleanup()
}

@objc
class RtcEngineManager: NSObject, RtcEngineManagerInterface {
    weak var delegate: RtcEngineManagerDelegate?
    private(set) var engine: PanoRtcEngineKit?
    private var engineDelegate: RtcEngineDelegateHandler?
    private var currentWhiteboardId: String?
    private(set) var videoStreamManager: RtcVideoStreamManager?
    private(set) var anntationManager: RtcAnnotationManager?
    private(set) var messageService: RtcMessage?
    private var networkManager: RtcNetworkManager?
    
    func cleanup() {
        engine?.destroy()
        engine = nil
        engineDelegate = nil
        delegate?.cleanup()
        currentWhiteboardId = nil
        videoStreamManager = nil
        anntationManager = nil
        messageService = nil
        networkManager = nil
    }
    
    @objc func create(_ params: NSDictionary, _ callback: Callback) {
        engineDelegate = RtcEngineDelegateHandler() { [weak self] methodName, data in
            self?.delegate?.emit(methodName, data)
        }
        engine = PanoRtcEngineKit.engine(with: PanoRtcEngineConfig(map: params["config"] as! Dictionary), delegate: engineDelegate!)
        callback.code((engine != nil) ? PanoResult.OK : PanoResult.notInitialized)
    }
    
    @objc func destroy(_ callback: Callback) {
        callback.resolve(engine) { [weak self] it in
            self?.cleanup()
        }
    }
    
    @objc func setLogLevel(_ params: NSDictionary, _ callback: Callback) {
        let level = PanoLogLevel(rawValue: params["level"] as! Int)
        PanoRtcEngineKit.setLogLevel(level!)
        callback.success(nil)
    }
    
    @objc func getSdkVersion(_ callback: Callback) {
        let version = PanoRtcEngineKit.getSdkVersion()
        callback.success(version)
    }
    
    @objc func updateConfig(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.update(PanoRtcEngineConfig(map: params["config"] as! Dictionary)))
    }
    
    @objc func joinChannel(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.joinChannel(withToken: params["token"] as! String,
                                channelId: params["channelId"] as! String,
                                userId: UInt64(params["userId"] as! String) ?? 0,
                                config: PanoRtcChannelConfig(map: params["config"] as! Dictionary)))
    }
    
    @objc func leaveChannel(_ callback: Callback) {
        callback.resolve(engine) { it in
            it.leaveChannel()
        }
    }
    
    @objc func startAudio(_ callback: Callback) {
        callback.code(engine?.startAudio())
    }
    
    @objc func stopAudio(_ callback: Callback) {
        callback.code(engine?.stopAudio())
    }
    
    @objc func startVideo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.startVideo(with: params["view"] as! UIView,
                               config: PanoRtcRenderConfig(map: params["config"] as! Dictionary)))
    }
    
    @objc func stopVideo(_ callback: Callback) {
        callback.code(engine?.stopVideo())
    }
    
    @objc func startScreen(_ params: NSDictionary, _ callback: Callback) {
        if #available(iOS 11.0, *) {
            callback.code(engine?.startScreen(withAppGroupId: params["appGroupId"] as! String))
        } else {
            callback.code(.notSupported)
        }
    }
    
    @objc func stopScreen(_ callback: Callback) {
        callback.code(engine?.stopScreen())
    }
    
    @objc func subscribeAudio(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.subscribeAudio(UInt64(params["userId"] as! String) ?? 0));
    }
    
    @objc func unsubscribeAudio(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.unsubscribeAudio(UInt64(params["userId"] as! String) ?? 0));
    }
    
    @objc func subscribeVideo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.subscribeVideo(UInt64(params["userId"] as! String) ?? 0,
                                   with: params["view"] as! UIView,
                                   config: PanoRtcRenderConfig(map: params["config"] as! Dictionary)))
    }
    
    @objc func unsubscribeVideo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.unsubscribeVideo(UInt64(params["userId"] as! String) ?? 0));
    }
    
    @objc func subscribeScreen(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.subscribeScreen(UInt64(params["userId"] as! String) ?? 0,
                                    with: params["view"] as! UIView))
    }
    
    @objc func unsubscribeScreen(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.unsubscribeScreen(UInt64(params["userId"] as! String) ?? 0));
    }
    
    @objc func updateScreenScaling(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.updateScreenScaling(UInt64(params["userId"] as! String) ?? 0,
                                        with: PanoScreenScalingRatio(rawValue: params["ratio"] as! Int)!))
    }
    
    @objc func updateScreenScalingWithFocus(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.updateScreenScaling(UInt64(params["userId"] as! String) ?? 0,
                                        withRatio: params["ratio"] as! CGFloat,
                                        focus: CGPoint(map: params["focus"] as! Dictionary)))
    }
    
    @objc func updateScreenMoving(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.updateScreenMoving(UInt64(params["userId"] as! String) ?? 0,
                                       withDistance: CGPoint(map: params["distance"] as! Dictionary)))
    }
    
    @objc func muteAudio(_ callback: Callback) {
        callback.code(engine?.muteAudio())
    }
    
    @objc func unmuteAudio(_ callback: Callback) {
        callback.code(engine?.unmuteAudio())
    }
    
    @objc func muteVideo(_ callback: Callback) {
        callback.code(engine?.muteVideo())
    }
    
    @objc func unmuteVideo(_ callback: Callback) {
        callback.code(engine?.unmuteVideo())
    }
    
    @objc func muteScreen(_ callback: Callback) {
        callback.code(engine?.muteScreen())
    }
    
    @objc func unmuteScreen(_ callback: Callback) {
        callback.code(engine?.unmuteScreen())
    }
    
    @objc func setMicrophoneMuteStatus(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setMicrophoneMuteStatus(params["enable"] as! Bool))
    }
    
    @objc func setAudioDeviceVolume(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.setAudioDeviceVolume(params["volume"] as! UInt32,
                                         with: PanoDeviceType(rawValue: params["type"] as! Int)!))
    }
    
    @objc func getAudioDeviceVolume(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) {
            $0.getAudioDeviceVolume(PanoDeviceType(rawValue: params["type"] as! Int)!)
        }
    }
    
    @objc func getRecordingLevel(_ callback: Callback) {
        callback.resolve(engine) { it in
            it.getRecordingLevel()
        }
    }
    
    @objc func getPlayoutLevel(_ callback: Callback) {
        callback.resolve(engine) { it in
            it.getPlayoutLevel()
        }
    }
    
    @objc func setLoudspeakerStatus(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setLoudspeakerStatus(params["enable"] as! Bool))
    }
    
    @objc func isEnabledLoudspeaker(_ callback: Callback) {
        callback.resolve(engine) { it in
            it.isEnabledLoudspeaker()
        }
    }
    
    @objc func switchCamera(_ callback: Callback) {
        callback.code(engine?.switchCamera())
    }
    
    @objc func isFrontCamera(_ callback: Callback) {
        callback.resolve(engine) { it in
            it.isFrontCamera()
        }
    }
    
    @objc func getCameraDeviceId(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) { it in
            it.getCameraDeviceId(params["frontCamera"] as! Bool)
        }
    }
    
    @objc func startPreview(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.startPreview(with: params["view"] as! UIView,
                                 config: PanoRtcRenderConfig(map: params["config"] as! Dictionary)))
    }
    
    @objc func stopPreview(_ callback: Callback) {
        callback.code(engine?.stopPreview())
    }
    
    @objc func createAudioMixingTask(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.createAudioMixingTask(params["taskId"] as! Int64,
                                          filename: params["filename"] as! String))
    }
    
    @objc func destroyAudioMixingTask(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.destroyAudioMixingTask(params["taskId"] as! Int64))
    }
    
    @objc func startAudioMixingTask(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.startAudioMixingTask(params["taskId"] as! Int64,
                                         with: PanoRtcAudioMixingConfig(map: params["config"] as! Dictionary)))
    }
    
    @objc func updateAudioMixingTask(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.updateAudioMixingTask(params["taskId"] as! Int64,
                                          with: PanoRtcAudioMixingConfig(map: params["config"] as! Dictionary)))
    }
    
    @objc func stopAudioMixingTask(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.stopAudioMixingTask(params["taskId"] as! Int64))
    }
    
    @objc func resumeAudioMixing(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.resumeAudioMixing(params["taskId"] as! Int64))
    }
    
    @objc func pauseAudioMixing(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.pauseAudioMixing(params["taskId"] as! Int64))
    }
    
    @objc func getAudioMixingDuration(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) { it in
            it.getAudioMixingDuration(params["taskId"] as! Int64)
        }
    }
    
    @objc func getAudioMixingCurrentTimestamp(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) { it in
            it.getAudioMixingCurrentTimestamp(params["taskId"] as! Int64)
        }
    }
    
    @objc func seekAudioMixing(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.seekAudioMixing(params["taskId"] as! Int64,
                                    timestamp: params["timestampMs"] as! Int64))
    }
    
    @objc func snapshotVideo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.snapshotVideo(params["outputDir"] as! String,
                                  userId: UInt64(params["userId"] as! String) ?? 0,
                                  option: PanoRtcSnapshotVideoOption(map: params["option"] as! Dictionary)))
    }
    
    @objc func whiteboardEngine(_ callback: Callback) {
        let whiteboardId = currentWhiteboardId ?? "default"
        callback.resolve(engine) { it in
            delegate?.createWhiteboardEngineIfNeeded(whiteboardId: whiteboardId)
            return whiteboardId
        }
    }
    
    @objc func switchWhiteboardEngine(_ params: NSDictionary, _ callback: Callback) {
        let whiteboardId = params["whiteboardId"] as! String
        let ret = engine?.switchWhiteboardEngine(whiteboardId)
        guard PanoResult.OK == ret else {
            callback.code(ret)
            return
        }
        currentWhiteboardId = whiteboardId
        callback.code(PanoResult.OK)
    }
    
    @objc func startAudioDumpWithFilePath(_ params: NSDictionary, _ callback: Callback) {
        callback.code(
            engine?.startAudioDump(withFilePath: params["filePath"] as! String,
                                   maxFileSize: params["maxFileSize"] as! Int64))
    }
    
    @objc func stopAudioDump(_ callback: Callback) {
        callback.code(engine?.stopAudioDump())
    }
    
    @objc func sendFeedback(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.sendFeedback(PanoFeedbackInfo(map: params["option"] as! Dictionary)))
    }
    
    @objc func setOption(_ params: NSDictionary, _ callback: Callback) {
        var option: NSObject? = nil
        let type = PanoOptionType(rawValue: params["type"] as! Int)
        var isValid = true
        switch type {
        case .optionFaceBeautify:
            option = PanoFaceBeautifyOption(map: params["option"] as! Dictionary)
        case .optionUploadLogs:
            option = NSNumber(value: params["option"] as! Bool)
        case .optionUploadAudioDump:
            option = NSNumber(value: params["option"] as! Bool)
        case .optionAudioEqualizationMode:
            option = NSNumber(value: params["option"] as! Int)
        case .optionAudioReverbMode:
            option = NSNumber(value: params["option"] as! Int)
        case .optionVideoFrameRate:
            option = NSNumber(value: params["option"] as! Int)
        case .optionAudioEarMonitoring:
            option = NSNumber(value: params["option"] as! Bool)
        case .optionBuiltinTransform:
            isValid = false
        case .optionUploadLogsAtFailure:
            option = NSNumber(value: params["option"] as! Bool)
        case .optionCpuAdaption:
            option = NSNumber(value: params["option"] as! Bool)
        case .optionAudioProfile:
            option = PanoRtcAudioProfile(map: params["option"] as! Dictionary)
        case .optionQuadTransform:
            option = PanoQuadTransformOption(map: params["option"] as! Dictionary)
        default:
            isValid = false
        }
        if isValid {
            callback.code(engine?.setOption(option, for: type!))
        } else {
            callback.code(PanoResult.invalidArgs)
        }
    }
    
    @objc func setParameters(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setParameters(params["param"] as! String))
    }
    
    @objc func videoStreamManager(_ callback: Callback) {
        if videoStreamManager == nil {
            let manager = delegate?.createVideoStreamManager(panoObj: engine?.videoStreamManager)
            if manager == nil {
                callback.code(PanoResult.invalidState)
                return
            }
            videoStreamManager = manager
        }
        callback.code(PanoResult.OK)
    }
    
    @objc func annotationManager(_ callback: Callback) {
        if anntationManager == nil {
            let manager = delegate?.createAnnotationManager(panoObj: engine?.annotationManager)
            if manager == nil {
                callback.code(PanoResult.invalidState)
                return
            }
            anntationManager = manager
        }
        callback.code(PanoResult.OK)
    }
    
    @objc func messageService(_ callback: Callback) {
        if messageService == nil {
            let service = delegate?.createMessageService(panoObj: engine?.messageService)
            if service == nil {
                callback.code(PanoResult.invalidState)
                return
            }
            messageService = service
        }
        callback.code(PanoResult.OK)
    }
    
    @objc func networkManager(_ callback: Callback) {
        if networkManager == nil {
            let manager = delegate?.createNetworkManager(panoObj: engine)
            if manager == nil {
                callback.code(PanoResult.invalidState)
                return
            }
            networkManager = manager
        }
        callback.code(PanoResult.OK)
    }
}

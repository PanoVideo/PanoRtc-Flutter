//
//  ObjectConverter.swift
//  pano_rtc
//
//  Copyright © 2021 Pano. All rights reserved.
//

import Foundation
import PanoRtc

extension CGPoint {
    init(map: Dictionary<String, Any>) {
        self.init()
        if let x = map["x"] as? Int {
            self.x = CGFloat(x)
        }
        if let y = map["y"] as? Int {
            self.y = CGFloat(y)
        }
    }
}

extension CGSize {
    init(map: Dictionary<String, Any>) {
        self.init()
        if let width = map["width"] as? Int {
            self.width = CGFloat(width)
        }
        if let height = map["height"] as? Int {
            self.height = CGFloat(height)
        }
    }
}

extension CGRect {
    init(map: Dictionary<String, Any>) {
        self.init()
        if let origin = map["origin"] as? Dictionary<String, Any> {
            self.origin = CGPoint(map: origin)
        }
        if let size = map["size"] as? Dictionary<String, Any> {
            self.size = CGSize(map: size)
        }
    }
}

extension PanoRtcEngineConfig {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let appId = map["appId"] as? String {
            self.appId = appId
        }
        if let rtcServer = map["rtcServer"] as? String {
            self.rtcServer = rtcServer
        }
        if let videoCodecHwAcceleration = map["videoCodecHwAcceleration"] as? Bool {
            self.videoCodecHwAcceleration = videoCodecHwAcceleration
        }
        if let audioScenario = map["audioScenario"] as? UInt32 {
            self.audioScenario = audioScenario
        }
    }
}

extension PanoRtcChannelConfig {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let mode = map["mode"] as? Int {
            if let mode = PanoChannelMode(rawValue: mode) {
                self.mode = mode
            }
        }
        if let serviceFlags = map["serviceFlags"] as? Array<Int> {
            var flagSet = PanoChannelService()
            for flag in serviceFlags {
                if flag == PanoChannelService.media.rawValue {
                    flagSet = flagSet.union(.media)
                } else if flag == PanoChannelService.whiteboard.rawValue {
                    flagSet = flagSet.union(.whiteboard)
                } else if flag == PanoChannelService.message.rawValue {
                    flagSet = flagSet.union(.message)
                }
            }
            self.serviceFlags = flagSet
        }
        if let subscribeAudioAll = map["subscribeAudioAll"] as? Bool {
            self.subscribeAudioAll = subscribeAudioAll
        }
        if let userName = map["userName"] as? String {
            self.userName = userName
        }
    }
}

extension PanoRtcRenderConfig {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let profileType = map["profileType"] as? Int {
            if let profileType = PanoVideoProfileType(rawValue: profileType) {
                self.profileType = profileType
            }
        }
        if let sourceMirror = map["sourceMirror"] as? Bool {
            self.sourceMirror = sourceMirror
        }
        if let scalingMode = map["scalingMode"] as? Int {
            if let scalingMode = PanoVideoScalingMode(rawValue: scalingMode) {
                self.scalingMode = scalingMode
            }
        }
        if let mirror = map["mirror"] as? Bool {
            self.mirror = mirror
        }
    }
}

extension PanoRtcAudioMixingConfig {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let enablePublish = map["enablePublish"] as? Bool {
            self.enablePublish = enablePublish
        }
        if let publishVolume = map["publishVolume"] as? Int32 {
            self.publishVolume = publishVolume
        }
        if let enableLoopback = map["enableLoopback"] as? Bool {
            self.enableLoopback = enableLoopback
        }
        if let loopbackVolume = map["loopbackVolume"] as? Int32 {
            self.loopbackVolume = loopbackVolume
        }
        if let cycle = map["cycle"] as? Int32 {
            self.cycle = cycle
        }
        if let replaceMicrophone = map["replaceMicrophone"] as? Bool {
            self.replaceMicrophone = replaceMicrophone
        }
    }
}

extension PanoRtcSnapshotVideoOption {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let format = map["format"] as? Int {
            if let format = PanoImageFileFormat(rawValue: format) {
                self.format = format
            }
        }
        if let mirror = map["mirror"] as? Bool {
            self.mirror = mirror
        }
    }
}

extension PanoFeedbackInfo {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let type = map["type"] as? Int {
            if let type = PanoFeedbackType(rawValue: type) {
                self.type = type
            }
        }
        if let productName = map["productName"] as? String {
            self.productName = productName
        }
        if let detailDescription = map["detailDescription"] as? String {
            self.detailDescription = detailDescription
        }
        if let contact = map["contact"] as? String {
            self.contact = contact
        }
        if let extraInfo = map["extraInfo"] as? String {
            self.extraInfo = extraInfo
        }
        if let uploadLogs = map["uploadLogs"] as? Bool {
            self.uploadLogs = uploadLogs
        }
    }
}

extension PanoFaceBeautifyOption {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let enable = map["enable"] as? Bool {
            self.enable = enable
        }
        if let intensity = map["intensity"] as? Double {
            self.intensity = Float32(intensity)
        }
    }
}

extension PanoRtcAudioProfile {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let sampleRate = map["sampleRate"] as? Int {
            if let sampleRate = PanoAudioSampleRate(rawValue: sampleRate) {
                self.sampleRate = sampleRate
            }
        }
        if let channel = map["channel"] as? Int {
            if let channel = PanoAudioChannel(rawValue: channel) {
                self.channel = channel
            }
        }
        if let profileQuality = map["profileQuality"] as? Int {
            if let profileQuality = PanoAudioProfileQuality(rawValue: profileQuality) {
                self.profileQuality = profileQuality
            }
        }
    }
}

extension PanoQuadTransformOption {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let enable = map["enable"] as? Bool {
            self.enable = enable
        }
        if let bReset = map["bReset"] as? Bool {
            self.bReset = bReset
        }
        if let index = map["index"] as? Int {
            if let index = PanoQuadIndex(rawValue: index) {
                self.index = index
            }
        }
        if let xDeltaAxis = map["xDeltaAxis"] as? Double {
            self.xDeltaAxis = Float32(xDeltaAxis)
        }
        if let yDeltaAxis = map["yDeltaAxis"] as? Double {
            self.yDeltaAxis = Float32(yDeltaAxis)
        }
        if let bMirror = map["bMirror"] as? Bool {
            self.bMirror = bMirror
        }
    }
}

extension PanoWBColor {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let red = map["red"] as? Double {
            self.red = Float32(red)
        }
        if let green = map["green"] as? Double {
            self.green = Float32(green)
        }
        if let blue = map["blue"] as? Double {
            self.blue = Float32(blue)
        }
        if let alpha = map["alpha"] as? Double {
            self.alpha = Float32(alpha)
        }
    }
}

extension PanoWBStamp {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let stampId = map["stampId"] as? String {
            self.stampId = stampId
        }
        if let path = map["path"] as? String {
            self.path = path
        }
        if let resizable = map["resizable"] as? Bool {
            self.resizable = resizable
        }
    }
}

extension PanoWBDocContents {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let name = map["name"] as? String {
            self.name = name
        }
        if let urls = map["urls"] as? [String] {
            self.urls = urls
        }
        if let thumbUrls = map["thumbUrls"] as? [String] {
            self.thumbUrls = thumbUrls
        }
        if let docId = map["docId"] as? String {
            self.docId = docId
        }
    }
}

extension PanoWBConvertConfig {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let type = map["type"] as? Int {
            if let type = PanoWBConvertType(rawValue: type) {
                self.type = type
            }
        }
        if let needThumb = map["needThumb"] as? Bool {
            self.needThumb = needThumb
        }
    }
}

extension PanoWBVisionConfig {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let width = map["width"] as? UInt32 {
            self.width = width
        }
        if let height = map["height"] as? UInt32 {
            self.height = height
        }
        if let limited = map["limited"] as? Bool {
            self.limited = limited
        }
    }
}

extension PanoWBDocExtHtml {
    convenience init(map: Dictionary<String, Any>) {
        self.init()
        if let name = map["name"] as? String {
            self.name = name
        }
        if let url = map["url"] as? String {
            self.url = url
        }
        if let thumbUrls = map["thumbUrls"] as? [String] {
            self.thumbUrls = thumbUrls
        }
    }
}

extension PanoWBDocInfo {
    func toMap() -> Dictionary<String, Any?> {
        return [
            "fileId": fileId,
            "name": name,
            "creator": String(creator),
            "type": type.rawValue
        ]
    }
}

extension PanoRtcNetworkQuality {
    func toMap() -> Dictionary<String, Any?> {
        return [
            "rating": rating.rawValue,
            "txLoss": txLoss,
            "rxLoss": rxLoss,
            "rtt": rtt
        ]
    }
}

extension PanoRtcAudioLevel {
    func toMap() -> Dictionary<String, Any?> {
        return [
            "userId": String(userId),
            "level": level,
            "active": active
        ]
    }
}

extension PanoRtcAudioSendStats {
    func toMap() -> Dictionary<String, Any?> {
        return [
            "bytesSent": bytesSent,
            "sendBitrate": sendBitrate,
            "packetsLost": packetsLost,
            "lossRatio": lossRatio,
            "rtt": rtt,
            "inputLevel": inputLevel,
            "inputActiveFlag": inputActiveFlag,
            "codecType": codecType.rawValue
        ]
    }
}

extension PanoRtcAudioRecvStats {
    func toMap() -> Dictionary<String, Any?> {
        return [
            "userId": String(userId),
            "bytesRecv": bytesRecv,
            "recvBitrate": recvBitrate,
            "packetsLost": packetsLost,
            "lossRatio": lossRatio,
            "outputLevel": outputLevel,
            "codecType": codecType.rawValue
        ]
    }
}

extension PanoRtcVideoSendStats {
    func toMap() -> Dictionary<String, Any?> {
        return [
            "streamId": streamId,
            "bytesSent": bytesSent,
            "sendBitrate": sendBitrate,
            "packetsLost": packetsLost,
            "lossRatio": lossRatio,
            "width": width,
            "height": height,
            "framerate": framerate,
            "plisReceived": plisReceived,
            "rtt": rtt,
            "codecType": codecType.rawValue
        ]
    }
}

extension PanoRtcVideoRecvStats {
    func toMap() -> Dictionary<String, Any?> {
        return [
            "userId": String(userId),
            "streamId": streamId,
            "bytesRecv": bytesRecv,
            "recvBitrate": recvBitrate,
            "packetsLost": packetsLost,
            "lossRatio": lossRatio,
            "width": width,
            "height": height,
            "framerate": framerate,
            "plisSent": plisSent,
            "codecType": codecType.rawValue
        ]
    }
}

extension PanoRtcVideoSendBweStats {
    func toMap() -> Dictionary<String, Any?> {
        return [
            "bandwidth": bandwidth,
            "encodeBitrate": encodeBitrate,
            "transmitBitrate": transmitBitrate,
            "retransmitBitrate": retransmitBitrate
        ]
    }
}

extension PanoRtcVideoRecvBweStats {
    func toMap() -> Dictionary<String, Any?> {
        return [
            "userId": String(userId),
            "bandwidth": bandwidth
        ]
    }
}

extension PanoRtcSystemStats {
    func toMap() -> Dictionary<String, Any?> {
        return [
            "totalCpuUsage": totalCpuUsage,
            "totalPhysMemory": totalPhysMemory,
            "workingSetSize": workingSetSize,
            "memoryUsage": memoryUsage
        ]
    }
}

extension PanoPropertyAction {
    func toMap() -> Dictionary<String, Any?> {
        return [
            "type": type.rawValue,
            "propName": propName,
            "propValue": propValue
        ]
    }
}

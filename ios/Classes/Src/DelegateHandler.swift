//
//  DelegateHandler.swift
//  pano_rtc
//
//  Copyright © 2021 Pano. All rights reserved.
//

import Foundation
import PanoRtc

class DelegateHandler<T: RawRepresentable>: NSObject where T.RawValue == String {
    
    var emitter: (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void

    init(emitter: @escaping (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void) {
        self.emitter = emitter
    }

    fileprivate func callback(_ method: T, _ data: Any?...) {
        emitter(method.rawValue, ["data": data])
    }
}

//MARK: - RtcEngineDelegateHandler

enum RtcEngineDelegateType: String, CaseIterable {
    case onChannelJoinConfirm
    case onChannelLeaveIndication
    case onChannelCountDown
    case onUserJoinIndication
    case onUserLeaveIndication
    case onUserAudioStart
    case onUserAudioStop
    case onUserAudioSubscribe
    case onUserVideoStart
    case onUserVideoStop
    case onUserVideoSubscribe
    case onUserAudioMute
    case onUserAudioUnmute
    case onUserVideoMute
    case onUserVideoUnmute
    case onUserScreenStart
    case onUserScreenStop
    case onUserScreenSubscribe
    case onUserScreenMute
    case onUserScreenUnmute
    case onWhiteboardAvailable
    case onWhiteboardUnavailable
    case onWhiteboardStart
    case onWhiteboardStop
    case onWhiteboardStartWithId
    case onWhiteboardStopWithId
    case onFirstAudioDataReceived
    case onFirstVideoDataReceived
    case onFirstScreenDataReceived
    case onFirstVideoFrameRendered
    case onFirstScreenFrameRendered
    case onAudioDeviceStateChanged
    case onAudioDefaultDeviceChanged
    case onVideoDeviceStateChanged
    case onVideoCaptureStateChanged
    case onChannelFailover
    case onActiveSpeakerListUpdated
    case onAudioMixingStateChanged
    case onVideoSnapshotCompleted
    case onNetworkQuality
    case onAudioStartResult
    case onVideoStartResult
    case onScreenStartResult
    case onScreenCaptureStateChanged
    case onUserAudioLevel
    case onVideoSendStats
    case onVideoRecvStats
    case onAudioSendStats
    case onAudioRecvStats
    case onScreenSendStats
    case onScreenRecvStats
    case onVideoSendBweStats
    case onVideoRecvBweStats
    case onSystemStats
}

class RtcEngineDelegateHandler: DelegateHandler<RtcEngineDelegateType> {}

extension RtcEngineDelegateHandler {
    static let PREFIX = "video.pano.rtc."
}

extension RtcEngineDelegateHandler: PanoRtcEngineDelegate {
    func onChannelJoinConfirm(_ result: PanoResult) {
        callback(.onChannelJoinConfirm, result.rawValue)
    }
    
    func onChannelLeaveIndication(_ result: PanoResult) {
        callback(.onChannelLeaveIndication, result.rawValue)
    }
    
    func onChannelFailover(_ state: PanoFailoverState) {
        callback(.onChannelFailover, state.rawValue)
    }
    
    func onChannelCountDown(_ remain: UInt32) {
        callback(.onChannelCountDown, remain)
    }
    
    func onUserJoinIndication(_ userId: UInt64, withName userName: String?) {
        callback(.onUserJoinIndication, String(userId), userName)
    }
    
    func onUserLeaveIndication(_ userId: UInt64, with reason: PanoUserLeaveReason) {
        callback(.onUserLeaveIndication, String(userId), reason.rawValue)
    }
    
    func onUserAudioStart(_ userId: UInt64) {
        callback(.onUserAudioStart, String(userId))
    }
    
    func onUserAudioStop(_ userId: UInt64) {
        callback(.onUserAudioStop, String(userId))
    }
    
    func onUserVideoStart(_ userId: UInt64, withMaxProfile maxProfile: PanoVideoProfileType) {
        callback(.onUserVideoStart, String(userId), maxProfile.rawValue)
    }
    
    func onUserVideoStop(_ userId: UInt64) {
        callback(.onUserVideoStop, String(userId))
    }
    
    func onUserScreenStart(_ userId: UInt64) {
        callback(.onUserScreenStart, String(userId))
    }
    
    func onUserScreenStop(_ userId: UInt64) {
        callback(.onUserScreenStop, String(userId))
    }
    
    func onUserAudioSubscribe(_ userId: UInt64, with result: PanoSubscribeResult) {
        callback(.onUserAudioSubscribe, String(userId), result.rawValue)
    }

    func onUserVideoSubscribe(_ userId: UInt64, with result: PanoSubscribeResult) {
        callback(.onUserVideoSubscribe, String(userId), result.rawValue)
    }
    
    func onUserScreenSubscribe(_ userId: UInt64, with result: PanoSubscribeResult) {
        callback(.onUserScreenSubscribe, String(userId), result.rawValue)
    }

    func onUserAudioMute(_ userId: UInt64) {
        callback(.onUserAudioMute, String(userId))
    }
    
    func onUserAudioUnmute(_ userId: UInt64) {
        callback(.onUserAudioUnmute, String(userId))
    }

    func onUserVideoMute(_ userId: UInt64) {
        callback(.onUserVideoMute, String(userId))
    }
    
    func onUserVideoUnmute(_ userId: UInt64) {
        callback(.onUserVideoUnmute, String(userId))
    }

    func onUserScreenMute(_ userId: UInt64) {
        callback(.onUserScreenMute, String(userId))
    }
    
    func onUserScreenUnmute(_ userId: UInt64) {
        callback(.onUserScreenUnmute, String(userId))
    }

    func onActiveSpeakerListUpdated(_ userIds: [NSNumber]?) {
        callback(.onActiveSpeakerListUpdated, userIds?.map { String($0.uint64Value) })
    }

    func onFirstAudioDataReceived(_ userId: UInt64) {
        callback(.onFirstAudioDataReceived, String(userId))
    }
    
    func onFirstVideoDataReceived(_ userId: UInt64) {
        callback(.onFirstVideoDataReceived, String(userId))
    }

    func onFirstScreenDataReceived(_ userId: UInt64) {
        callback(.onFirstScreenDataReceived, String(userId))
    }

    func onFirstVideoFrameRendered(_ userId: UInt64) {
        callback(.onFirstVideoFrameRendered, String(userId))
    }
    
    func onFirstScreenFrameRendered(_ userId: UInt64) {
        callback(.onFirstScreenFrameRendered, String(userId))
    }

    func onAudioSendStats(_ stats: PanoRtcAudioSendStats) {
        callback(.onAudioSendStats, stats.toMap())
    }
    
    func onAudioRecvStats(_ stats: PanoRtcAudioRecvStats) {
        callback(.onAudioRecvStats, stats.toMap())
    }
    
    func onVideoSendStats(_ stats: PanoRtcVideoSendStats) {
        callback(.onVideoSendStats, stats.toMap())
    }
    
    func onVideoRecvStats(_ stats: PanoRtcVideoRecvStats) {
        callback(.onVideoRecvStats, stats.toMap())
    }

    func onScreenSendStats(_ stats: PanoRtcVideoSendStats) {
        callback(.onScreenSendStats, stats.toMap())
    }
    
    func onScreenRecvStats(_ stats: PanoRtcVideoRecvStats) {
        callback(.onScreenRecvStats, stats.toMap())
    }

    func onVideoSendBweStats(_ stats: PanoRtcVideoSendBweStats) {
        callback(.onVideoSendBweStats, stats.toMap())
    }
    
    func onVideoRecvBweStats(_ stats: PanoRtcVideoRecvBweStats) {
        callback(.onVideoRecvBweStats, stats.toMap())
    }
    
    func onSystemStats(_ stats: PanoRtcSystemStats) {
        callback(.onSystemStats, stats.toMap())
    }

    func onNetworkQuality(_ quality: PanoQualityRating, withUser userId: UInt64) {
        callback(.onNetworkQuality, String(userId), quality.rawValue)
    }
    
    func onUserAudioLevel(_ level: PanoRtcAudioLevel) {
        callback(.onUserAudioLevel, level.toMap())
    }

    func onVideoCaptureStateChange(_ state: PanoVideoCaptureState, withDevice deviceId: String) {
        callback(.onVideoCaptureStateChanged, deviceId, state.rawValue)
    }
    
    func onWhiteboardAvailable() {
        callback(.onWhiteboardAvailable)
    }
    
    func onWhiteboardUnavailable() {
        callback(.onWhiteboardUnavailable)
    }
    
    func onWhiteboardStart() {
        callback(.onWhiteboardStart)
    }
    
    func onWhiteboardStop() {
        callback(.onWhiteboardStop)
    }
    
    func onWhiteboardStart(_ whiteboardId: String) {
        callback(.onWhiteboardStartWithId, whiteboardId)
    }
    
    func onWhiteboardStop(_ whiteboardId: String) {
        callback(.onWhiteboardStopWithId, whiteboardId)
    }

    func onAudioMixingStateChanged(_ taskId: Int64, with state: PanoAudioMixingState) {
        callback(.onAudioMixingStateChanged, taskId, state.rawValue)
    }
    
    func onVideoSnapshotCompleted(_ succeed: Bool, userId: UInt64, filename: String) {
        callback(.onVideoSnapshotCompleted, succeed, String(userId), filename)
    }
    
    func onAudioStart(_ result: PanoResult) {
        callback(.onAudioStartResult, result.rawValue)
    }
    
    func onVideoStart(_ result: PanoResult) {
        callback(.onVideoStartResult, result.rawValue)
    }
    
    func onScreenStart(_ result: PanoResult) {
        callback(.onScreenStartResult, result.rawValue)
    }
    
    func onScreenCaptureStateChanged(_ state: PanoScreenCaptureState, reason: PanoResult) {
        callback(.onScreenCaptureStateChanged, state.rawValue, reason.rawValue)
    }
}

//MARK: - PanoRtcWhiteboardDelegateHandler

enum PanoRtcWhiteboardDelegateType: String, CaseIterable {
    case onStatusSynced
    case onPageNumberChanged
    case onImageStateChanged
    case onViewScaleChanged
    case onRoleTypeChanged
    case onContentUpdated
    case onSnapshotComplete
    case onMessage
    case onAddBackgroundImages
    case onAddH5File
    case onDocTranscodeStatus
    case onCreateDoc
    case onDeleteDoc
    case onSwitchDoc
    case onSaveDoc
    case onDocThumbnailReady
    case onVisionShareStarted
    case onVisionShareStopped
    case onUserJoined
    case onUserLeft
}

class PanoRtcWhiteboardDelegateHandler: DelegateHandler<PanoRtcWhiteboardDelegateType> {}

extension PanoRtcWhiteboardDelegateHandler {
    static let PREFIX = "video.pano.rtc."
}

extension PanoRtcWhiteboardDelegateHandler: PanoRtcWhiteboardDelegate {
    func onStatusSynced() {
        callback(.onStatusSynced)
    }
    
    func onPageNumberChanged(_ curPage: PanoWBPageNumber, withTotalPages totalPages: UInt32) {
        callback(.onPageNumberChanged, curPage, totalPages)
    }
    
    func onImageStateChanged(_ state: PanoWBImageState, withUrl url: String) {
        callback(.onImageStateChanged, url, state.rawValue)
    }
    
    func onViewScaleChanged(_ scale: Float32) {
        callback(.onViewScaleChanged, scale)
    }
    
    func onRoleTypeChanged(_ newRole: PanoWBRoleType) {
        callback(.onRoleTypeChanged, newRole.rawValue)
    }
    
    func onContentUpdated() {
        callback(.onContentUpdated)
    }
    
    func onSnapshotComplete(_ result: PanoResult, name filename: String) {
        callback(.onSnapshotComplete, result.rawValue, filename)
    }
    
    func onMessageReceived(_ message: Data, fromUser userId: UInt64) {
        callback(.onMessage, String(userId), message)
    }
    
    func onAddBackgroundImages(_ result: PanoResult, file fileId: String) {
        callback(.onAddBackgroundImages, result.rawValue, fileId)
    }
    
    func onAddH5File(_ result: PanoResult, file fileId: String) {
        callback(.onAddH5File, result.rawValue, fileId)
    }
    
    func onDocTranscodeStatus(_ result: PanoResult, file fileId: String, progress: UInt32, pageCount count: UInt32) {
        callback(.onDocTranscodeStatus, result.rawValue, fileId, progress, count)
    }
    
    func onDocCreate(_ result: PanoResult, file fileId: String) {
        callback(.onCreateDoc, result.rawValue, fileId)
    }

    func onDocDelete(_ result: PanoResult, file fileId: String) {
        callback(.onDeleteDoc, result.rawValue, fileId)
    }
    
    func onDocSwitch(_ result: PanoResult, file fileId: String) {
        callback(.onSwitchDoc, result.rawValue, fileId)
    }
    
    func onDocSave(_ result: PanoResult, file fileId: String, path outputDir: String) {
        callback(.onSaveDoc, result.rawValue, fileId, outputDir)
    }
    
    func onDocThumbnailReady(_ fileId: String, thumbs urls: [String]) {
        callback(.onDocThumbnailReady, fileId, urls)
    }
    
    func onVisionShareStarted(_ userId: UInt64) {
        callback(.onVisionShareStarted, String(userId))
    }
    
    func onVisionShareStopped(_ userId: UInt64) {
        callback(.onVisionShareStopped, String(userId))
    }

    func onUserJoined(_ userId: UInt64, withName userName: String?) {
        callback(.onUserJoined, String(userId), userName)
    }
    
    func onUserLeft(_ userId: UInt64) {
        callback(.onUserLeft, String(userId))
    }
}

//MARK: - PanoRtcVideoStreamDelegateHandler

enum PanoRtcVideoStreamDelegateType: String, CaseIterable {
    case onUserVideoStreamStart
    case onUserVideoStreamStop
    case onUserVideoStreamSubscribe
    case onUserVideoMute
    case onUserVideoUnmute
    case onFirstVideoDataReceived
    case onFirstVideoFrameRendered
    case onVideoStreamSnapshotCompleted
    case onVideoCaptureStateChanged
    case onVideoStartResult
}

class PanoRtcVideoStreamDelegateHandler: DelegateHandler<PanoRtcVideoStreamDelegateType> {}

extension PanoRtcVideoStreamDelegateHandler {
    static let PREFIX = "video.pano.rtc."
}

extension PanoRtcVideoStreamDelegateHandler: PanoRtcVideoStreamDelegate {
    func onUserVideoStart(_ userId: UInt64, stream streamId: Int32, maxProfile: PanoVideoProfileType) {
        callback(.onUserVideoStreamStart, String(userId), streamId, maxProfile.rawValue)
    }
    
    func onUserVideoStop(_ userId: UInt64, stream streamId: Int32) {
        callback(.onUserVideoStreamStop, String(userId), streamId)
    }
    
    func onUserVideoSubscribe(_ userId: UInt64, stream streamId: Int32, result: PanoSubscribeResult) {
        callback(.onUserVideoStreamSubscribe, String(userId), streamId, result.rawValue)
    }
    
    func onUserVideoMute(_ userId: UInt64, stream streamId: Int32) {
        callback(.onUserVideoMute, String(userId), streamId)
    }
    
    func onUserVideoUnmute(_ userId: UInt64, stream streamId: Int32) {
        callback(.onUserVideoUnmute, String(userId), streamId)
    }

    func onFirstVideoDataReceived(_ userId: UInt64, stream streamId: Int32) {
        callback(.onFirstVideoDataReceived, String(userId), streamId)
    }
    
    func onFirstVideoFrameRendered(_ userId: UInt64, stream streamId: Int32) {
        callback(.onFirstVideoFrameRendered, String(userId), streamId)
    }
    
    func onVideoSnapshotCompleted(_ userId: UInt64, stream streamId: Int32, succeed: Bool, filename: String) {
        callback(.onVideoStreamSnapshotCompleted, String(userId), streamId, succeed, filename)
    }
    
    func onVideoCaptureStateChange(_ state: PanoVideoCaptureState, stream streamId: Int32, device deviceId: String) {
        callback(.onVideoCaptureStateChanged, streamId, deviceId, state.rawValue)
    }
}

//MARK: - PanoRtcAnnotationManagerDelegateHandler

enum PanoRtcAnnotationManagerDelegateType: String, CaseIterable {
    case onVideoAnnotationStart
    case onVideoAnnotationStop
    case onShareAnnotationStart
    case onShareAnnotationStop
}

class PanoRtcAnnotationManagerDelegateHandler: DelegateHandler<PanoRtcAnnotationManagerDelegateType> {}

extension PanoRtcAnnotationManagerDelegateHandler {
    static let PREFIX = "video.pano.rtc."
}

extension PanoRtcAnnotationManagerDelegateHandler: PanoRtcAnnotationManagerDelegate {
    func onVideoAnnotationStart(_ userId: UInt64, stream streamId: Int32) {
        callback(.onVideoAnnotationStart, String(userId), streamId)
    }
    
    func onVideoAnnotationStop(_ userId: UInt64, stream streamId: Int32) {
        callback(.onVideoAnnotationStop, String(userId), streamId)
    }
    
    func onShareAnnotationStart(_ userId: UInt64) {
        callback(.onShareAnnotationStart, String(userId))
    }
    
    func onShareAnnotationStop(_ userId: UInt64) {
        callback(.onShareAnnotationStop, String(userId))
    }
}

//MARK: - PanoRtcAnnotationDelegateHandler

enum PanoRtcAnnotationDelegateType: String, CaseIterable {
    case onAnnoRoleChanged
    case onSnapshotComplete
}

class PanoRtcAnnotationDelegateHandler: DelegateHandler<PanoRtcAnnotationDelegateType> {}

extension PanoRtcAnnotationDelegateHandler {
    static let PREFIX = "video.pano.rtc."
}

extension PanoRtcAnnotationDelegateHandler: PanoRtcAnnotationDelegate {
    func onAnnoRoleChanged(_ newRole: PanoWBRoleType) {
        callback(.onAnnoRoleChanged, newRole.rawValue)
    }
    
    func onSnapshotComplete(_ result: PanoResult, name filename: String) {
        callback(.onSnapshotComplete, result.rawValue, filename)
    }
}

//MARK: - PanoRtcNetworkTestDelegateHandler

enum PanoRtcNetworkTestDelegateType: String, CaseIterable {
    case onNetworkTestComplete
}

class PanoRtcNetworkTestDelegateHandler: DelegateHandler<PanoRtcNetworkTestDelegateType> {}

extension PanoRtcNetworkTestDelegateHandler {
    static let PREFIX = "video.pano.rtc."
}

extension PanoRtcNetworkTestDelegateHandler: PanoRtcNetworkTestDelegate {
    func onNetworkTestComplete(_ quality: PanoRtcNetworkQuality) {
        callback(.onNetworkTestComplete, quality.toMap())
    }
}

//MARK： - PanoRtcMessageDelegate

enum PanoRtcMessageDelegateType: String, CaseIterable {
    case onServiceStateChanged
    case onUserMessage
}

class PanoRtcMessageDelegateHandler: DelegateHandler<PanoRtcMessageDelegateType> {}

extension PanoRtcMessageDelegateHandler {
    static let PREFIX = "video.pano.rtc."
}

extension PanoRtcMessageDelegateHandler: PanoRtcMessageDelegate {
    func onServiceStateChanged(_ state: PanoMessageServiceState, reason: PanoResult) {
        callback(.onServiceStateChanged, state.rawValue, reason.rawValue)
    }
    
    func onUserMessage(_ userId: UInt64, data: Data) {
        callback(.onUserMessage, String(userId), data)
    }
}

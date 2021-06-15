package video.pano.rtc.native.events

import com.pano.rtc.api.*
import com.pano.rtc.api.Constants.QResult
import com.pano.rtc.api.model.RtcAudioLevel
import com.pano.rtc.api.model.stats.*
import kotlin.collections.ArrayList

class RtcEngineEvent(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : RtcEngineCallback, RtcAudioIndication, RtcAudioMixingMgr.Callback, RtcMediaStatsObserver {

    companion object {
        const val PREFIX = "video.pano.rtc."
    }

    private fun callback(methodName: String, vararg data: Any?) {
        emit(methodName, hashMapOf("data" to data.toList()))
    }

    override fun onVideoDeviceStateChanged(deviceId: String?, deviceType: Constants.VideoDeviceType?,
                                           deviceState: Constants.VideoDeviceState?) {
        callback("onVideoDeviceStateChanged", deviceId, deviceType?.value, deviceState?.value)
    }

    override fun onWhiteboardStart() {
        callback("onWhiteboardStart")
    }

    override fun onUserVideoStop(userId: Long) {
        callback("onUserVideoStop", userId.toString())
    }

    override fun onUserAudioStop(userId: Long) {
        callback("onUserAudioStop", userId.toString())
    }

    override fun onUserScreenStop(userId: Long) {
        callback("onUserScreenStop", userId.toString())
    }

    override fun onUserLeaveIndication(userId: Long, reason: Constants.UserLeaveReason?) {
        callback("onUserLeaveIndication", userId.toString(), reason?.value)
    }

    override fun onWhiteboardStop() {
        callback("onWhiteboardStop")
    }

    override fun onChannelLeaveIndication(result: QResult?) {
        callback("onChannelLeaveIndication", result?.value)
    }

    override fun onUserVideoSubscribe(userId: Long, result: Constants.MediaSubscribeResult?) {
        callback("onUserVideoSubscribe", userId.toString(), result?.value)
    }

    override fun onFirstVideoDataReceived(userId: Long) {
        callback("onFirstVideoDataReceived", userId.toString())
    }

    override fun onChannelFailover(state: Constants.FailoverState?) {
        callback("onChannelFailover", state?.value)
    }

    override fun onUserAudioSubscribe(userId: Long, result: Constants.MediaSubscribeResult?) {
        callback("onUserAudioSubscribe", userId.toString(), result?.value)
    }

    override fun onUserScreenStart(userId: Long) {
        callback("onUserScreenStart", userId.toString())
    }

    override fun onUserAudioMute(userId: Long) {
        callback("onUserAudioMute", userId.toString())
    }

    override fun onWhiteboardAvailable() {
        callback("onWhiteboardAvailable")
    }

    override fun onFirstScreenDataReceived(userId: Long) {
        callback("onFirstScreenDataReceived", userId.toString())
    }

    override fun onFirstAudioDataReceived(userId: Long) {
        callback("onFirstAudioDataReceived", userId.toString())
    }

    override fun onChannelCountDown(remain: Long) {
        callback("onChannelCountDown", remain)
    }

    override fun onUserVideoStart(userId: Long, maxProfile: Constants.VideoProfileType?) {
        callback("onUserVideoStart", userId.toString(), maxProfile?.value)
    }

    override fun onUserScreenMute(userId: Long) {
        callback("onUserScreenMute", userId.toString())
    }

    override fun onUserJoinIndication(userId: Long, userName: String?) {
        callback("onUserJoinIndication", userId.toString(), userName)
    }

    override fun onChannelJoinConfirm(result: QResult?) {
        callback("onChannelJoinConfirm", result?.value)
    }

    override fun onUserVideoMute(userId: Long) {
        callback("onUserVideoMute", userId.toString())
    }

    override fun onUserScreenSubscribe(userId: Long, result: Constants.MediaSubscribeResult?) {
        callback("onUserScreenSubscribe", userId.toString(), result?.value)
    }

    override fun onWhiteboardUnavailable() {
        callback("onWhiteboardUnavailable")
    }

    override fun onAudioDeviceStateChanged(deviceId: String?, deviceType: Constants.AudioDeviceType?,
                                           deviceState: Constants.AudioDeviceState?) {
        callback("onAudioDeviceStateChanged", deviceId, deviceType?.value, deviceState?.value)
    }

    override fun onUserAudioStart(userId: Long) {
        callback("onUserAudioStart", userId.toString())
    }

    override fun onUserScreenUnmute(userId: Long) {
        callback("onUserScreenUnmute", userId.toString())
    }

    override fun onUserAudioUnmute(userId: Long) {
        callback("onUserAudioUnmute", userId.toString())
    }

    override fun onUserVideoUnmute(userId: Long) {
        callback("onUserVideoUnmute", userId.toString())
    }

    override fun onVideoStartResult(result: QResult?) {
        callback("onVideoStartResult", result?.value)
    }

    override fun onWhiteboardStart(whiteboardId: String?) {
        callback("onWhiteboardStartWithId", whiteboardId)
    }

    override fun onWhiteboardStop(whiteboardId: String?) {
        callback("onWhiteboardStopWithId", whiteboardId)
    }

    override fun onVideoCaptureStateChanged(deviceId: String?, state: Constants.VideoCaptureState?) {
        callback("onVideoCaptureStateChanged", deviceId, state?.value)
    }

    override fun onActiveSpeakerListUpdated(userIds: LongArray?) {
        val userIdList = ArrayList<String>()
        userIds?.forEach {
            userIdList.add(it.toString())
        }
        callback("onActiveSpeakerListUpdated", userIdList)
    }

    override fun onVideoSnapshotCompleted(succeed: Boolean, userId: Long, filename: String?) {
        callback("onVideoSnapshotCompleted", succeed, userId.toString(), filename)
    }

    override fun onAudioStartResult(result: QResult?) {
        callback("onAudioStartResult", result?.value)
    }

    override fun onScreenStartResult(result: QResult?) {
        callback("onScreenStartResult", result?.value)
    }

    override fun onNetworkQuality(userId: Long, quality: Constants.QualityRating?) {
        callback("onNetworkQuality", userId.toString(), quality?.value)
    }

    override fun onFirstVideoFrameRendered(userId: Long) {
        callback("onFirstVideoFrameRendered", userId.toString())
    }

    override fun onFirstScreenFrameRendered(userId: Long) {
        callback("onFirstScreenFrameRendered", userId.toString())
    }

    override fun onUserAudioLevel(level: RtcAudioLevel?) {
        val map = mapOf(
                "userId" to level?.userId.toString(),
                "level" to level?.level,
                "active" to level?.active
        )
        callback("onUserAudioLevel", map)
    }

    override fun onAudioMixingStateChanged(taskId: Long, state: Constants.AudioMixingState?) {
        callback("onAudioMixingStateChanged", taskId, state?.value)
    }

    override fun onScreenSendStats(stats: RtcVideoSendStats?) {
        stats?.let {
            val map = mapOf(
                    "streamId" to stats.streamId,
                    "bytesSent" to stats.bytesSent,
                    "packetsLost" to stats.packetsLost,
                    "lossRatio" to stats.lossRatio,
                    "rtt" to stats.rtt,
                    "width" to stats.width,
                    "height" to stats.height,
                    "framerate" to stats.framerate,
                    "plisReceived" to stats.plisReceived,
                    "codecType" to stats.codecType.value
            )
            callback("onScreenSendStats", map)
        }
    }

    override fun onScreenRecvStats(stats: RtcVideoRecvStats?) {
        stats?.let {
            val map = mapOf(
                    "userId" to stats.userId.toString(),
                    "streamId" to stats.streamId,
                    "bytesReceived" to stats.bytesReceived,
                    "bitrate" to stats.bitrate,
                    "packetsLost" to stats.packetsLost,
                    "lossRatio" to stats.lossRatio,
                    "width" to stats.width,
                    "height" to stats.height,
                    "framerate" to stats.framerate,
                    "plisSent" to stats.plisSent,
                    "codecType" to stats.codecType.value
            )
            callback("onScreenRecvStats", map)
        }
    }

    override fun onVideoBweStats(stats: RtcVideoBweStats?) {
        stats?.let {
            val map = mapOf(
                    "bandwidth" to stats.bandwidth,
                    "encodeBitrate" to stats.encodeBitrate,
                    "transmitBitrate" to stats.transmitBitrate,
                    "retransmitBitrate" to stats.retransmitBitrate
            )
            callback("onVideoSendBweStats", map)
        }
    }

    override fun onSystemStats(stats: RtcSystemStats?) {
        stats?.let {
            val map = mapOf(
                    "totalCpuUsage" to stats.totalCpuUsage,
                    "memoryUsage" to stats.memoryUsage,
                    "totalPhysMemory" to stats.totalPhysMemory,
                    "workingSetSize" to stats.workingSetSize
            )
            callback("onSystemStats", map)
        }
    }

    override fun onVideoSendStats(stats: RtcVideoSendStats?) {
        stats?.let {
            val map = mapOf(
                    "streamId" to stats.streamId,
                    "bytesSent" to stats.bytesSent,
                    "packetsLost" to stats.packetsLost,
                    "lossRatio" to stats.lossRatio,
                    "rtt" to stats.rtt,
                    "width" to stats.width,
                    "height" to stats.height,
                    "framerate" to stats.framerate,
                    "plisReceived" to stats.plisReceived,
                    "codecType" to stats.codecType.value
            )
            callback("onVideoSendStats", map)
        }
    }

    override fun onAudioRecvStats(stats: RtcAudioRecvStats?) {
        stats?.let {
            val map = mapOf(
                    "userId" to stats.userId.toString(),
                    "bytesReceived" to stats.bytesReceived,
                    "bitrate" to stats.bitrate,
                    "packetsLost" to stats.packetsLost,
                    "lossRatio" to stats.lossRatio,
                    "outputLevel" to stats.outputLevel,
                    "codecType" to stats.codecType.value
            )
            callback("onAudioRecvStats", map)
        }
    }

    override fun onVideoRecvStats(stats: RtcVideoRecvStats?) {
        stats?.let {
            val map = mapOf(
                    "userId" to stats.userId.toString(),
                    "streamId" to stats.streamId,
                    "bytesReceived" to stats.bytesReceived,
                    "bitrate" to stats.bitrate,
                    "packetsLost" to stats.packetsLost,
                    "lossRatio" to stats.lossRatio,
                    "width" to stats.width,
                    "height" to stats.height,
                    "framerate" to stats.framerate,
                    "plisSent" to stats.plisSent,
                    "codecType" to stats.codecType.value
            )
            callback("onVideoRecvStats", map)
        }
    }
    
    override fun onAudioSendStats(stats: RtcAudioSendStats?) {
        stats?.let {
            val map = mapOf(
                    "bytesSent" to stats.bytesSent,
                    "bitrate" to stats.bitrate,
                    "packetsLost" to stats.packetsLost,
                    "lossRatio" to stats.lossRatio,
                    "rtt" to stats.rtt,
                    "inputLevel" to stats.inputLevel,
                    "inputActiveFlag" to stats.inputActiveFlag,
                    "codecType" to stats.codecType.value
            )
            callback("onAudioRecvStats", map)
        }
    }
}
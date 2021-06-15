package video.pano.rtc.native.events

import com.pano.rtc.api.Constants
import com.pano.rtc.api.RtcVideoStreamManager

class RtcVideoStreamEvent(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : RtcVideoStreamManager.Callback {

    companion object {
        const val PREFIX = "video.pano.rtc."
    }

    private fun callback(methodName: String, vararg data: Any?) {
        emit(methodName, hashMapOf("data" to data.toList()))
    }

    override fun onUserVideoStop(userId: Long, streamId: Int) {
        callback("onUserVideoStreamStop", userId.toString(), streamId)
    }

    override fun onUserVideoStart(userId: Long, streamId: Int, maxProfile: Constants.VideoProfileType?) {
        callback("onUserVideoStreamStart", userId.toString(), streamId, maxProfile?.value)
    }

    override fun onVideoCaptureStateChanged(streamId: Int, deviceId: String?, state: Constants.VideoCaptureState?) {
        callback("onVideoCaptureStateChanged", streamId, deviceId, state?.value)
    }

    override fun onUserVideoMute(userId: Long, streamId: Int) {
        callback("onUserVideoMute", userId.toString(), streamId)
    }

    override fun onUserVideoSubscribe(userId: Long, streamId: Int, result: Constants.MediaSubscribeResult?) {
        callback("onUserVideoStreamSubscribe", userId.toString(), streamId, result?.value)
    }

    override fun onFirstVideoDataReceived(userId: Long, streamId: Int) {
        callback("onFirstVideoDataReceived", userId.toString(), streamId)
    }

    override fun onVideoSnapshotCompleted(userId: Long, streamId: Int, succeed: Boolean, filename: String?) {
        callback("onVideoStreamSnapshotCompleted", userId.toString(), streamId, succeed, filename)
    }

    override fun onVideoStartResult(streamId: Int, result: Constants.QResult?) {
        callback("onVideoStartResult", streamId, result?.value)
    }

    override fun onFirstVideoFrameRendered(userId: Long, streamId: Int) {
        callback("onFirstVideoFrameRendered", userId.toString(), streamId)
    }

    override fun onUserVideoUnmute(userId: Long, streamId: Int) {
        callback("onUserVideoUnmute", userId.toString(), streamId)
    }
}
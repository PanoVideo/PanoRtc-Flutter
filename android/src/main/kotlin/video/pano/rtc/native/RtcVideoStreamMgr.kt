package video.pano.rtc.native

import com.pano.rtc.api.RtcSnapshotVideoOption
import com.pano.rtc.api.RtcVideoStreamManager
import com.pano.rtc.api.RtcView
import video.pano.rtc.native.api.IRtcVideoStreamManager
import video.pano.rtc.native.events.RtcVideoStreamEvent
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getImageFileFormat
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getVideoProfileType

class RtcVideoStreamMgr(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : IRtcVideoStreamManager {

    private var manager: RtcVideoStreamManager? = null

    fun setInnerMgr(manager: RtcVideoStreamManager?) {
        this.manager = manager
        this.manager?.setCallback(RtcVideoStreamEvent { methodName, data ->
            emit(methodName, data)
        })
    }

    override fun createVideoStream(params: Map<String, *>, callback: Callback) {
        val deviceId = params["deviceId"] as String
        callback.success(manager?.createVideoStream(deviceId))
    }

    override fun destroyVideoStream(params: Map<String, *>, callback: Callback) {
        val streamId = (params["streamId"] as Number).toInt()
        callback.success(manager?.destroyVideoStream(streamId))
    }

    override fun setCaptureDevice(params: Map<String, *>, callback: Callback) {
        val streamId = (params["streamId"] as Number).toInt()
        val deviceId = params["deviceId"] as String
        callback.success(manager?.setCaptureDevice(streamId, deviceId))
    }

    override fun getCaptureDevice(params: Map<String, *>, callback: Callback) {
        val streamId = (params["streamId"] as Number).toInt()
        callback.success(manager?.getCaptureDevice(streamId))
    }

    override fun startVideo(params: Map<String, *>, callback: Callback) {
        val view = params["view"] as RtcView
        val streamId = (params["streamId"] as Number).toInt()
        val configMap = params["config"] as Map<*, *>
        val profileType = (configMap["profileType"] as Number).toInt()
        view.mirror = configMap["mirror"] as Boolean
        manager?.setLocalVideoRender(streamId, view)
        callback.success(manager?.startVideo(streamId, getVideoProfileType(profileType)))
    }

    override fun stopVideo(params: Map<String, *>, callback: Callback) {
        val streamId = (params["streamId"] as Number).toInt()
        callback.success(manager?.stopVideo(streamId))
    }

    override fun muteVideo(params: Map<String, *>, callback: Callback) {
        val streamId = (params["streamId"] as Number).toInt()
        callback.success(manager?.muteVideo(streamId))
    }

    override fun unmuteVideo(params: Map<String, *>, callback: Callback) {
        val streamId = (params["streamId"] as Number).toInt()
        callback.success(manager?.unmuteVideo(streamId))
    }

    override fun subscribeVideo(params: Map<String, *>, callback: Callback) {
        val view = params["view"] as RtcView
        val userId = (params["userId"] as String).toLong()
        val streamId = (params["streamId"] as Number).toInt()
        val configMap = params["config"] as Map<*, *>
        val profileType = (configMap["profileType"] as Number).toInt()
        view.mirror = configMap["mirror"] as Boolean
        manager?.setRemoteVideoRender(userId, streamId, view)
        callback.success(manager?.subscribeVideo(userId, streamId, getVideoProfileType(profileType)))
    }

    override fun unsubscribeVideo(params: Map<String, *>, callback: Callback) {
        val userId = (params["userId"] as String).toLong()
        val streamId = (params["streamId"] as Number).toInt()
        callback.success(manager?.unsubscribeVideo(userId, streamId))
    }

    override fun snapshotVideo(params: Map<String, *>, callback: Callback) {
        val userId = (params["userId"] as String).toLong()
        val streamId = (params["streamId"] as Number).toInt()
        val outputDir = params["outputDir"] as String
        val optionMap = params["option"] as Map<*, *>
        val option = RtcSnapshotVideoOption().apply {
            this.mirror = optionMap["mirror"] as Boolean
            this.format = getImageFileFormat((optionMap["format"] as Number).toInt())
        }
        callback.success(manager?.snapshotVideo(userId, streamId, outputDir, option))
    }
}
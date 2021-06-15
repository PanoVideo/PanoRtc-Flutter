package video.pano.rtc.native.events

import com.pano.rtc.api.PanoAnnotationManager

class RtcAnnotationManagerEvent(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : PanoAnnotationManager.Callback {

    companion object {
        const val PREFIX = "video.pano.rtc."
    }

    private fun callback(methodName: String, vararg data: Any?) {
        emit(methodName, hashMapOf("data" to data.toList()))
    }

    override fun onShareAnnotationStart(userId: Long) {
        callback("onShareAnnotationStart", userId.toString())
    }

    override fun onVideoAnnotationStart(userId: Long, streamId: Int) {
        callback("onVideoAnnotationStart", userId.toString(), streamId)
    }

    override fun onShareAnnotationStop(userId: Long) {
        callback("onShareAnnotationStop", userId.toString())
    }

    override fun onVideoAnnotationStop(userId: Long, streamId: Int) {
        callback("onVideoAnnotationStop", userId.toString(), streamId)
    }
}
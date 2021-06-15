package video.pano.rtc.native.events

import com.pano.rtc.api.Constants
import com.pano.rtc.api.PanoAnnotation

class RtcAnnotationEvent (
        private val annotationId: String,
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : PanoAnnotation.Callback {

    companion object {
        const val PREFIX = "video.pano.rtc."
    }

    private fun callback(methodName: String, vararg data: Any?) {
        emit(methodName, hashMapOf("annotationId" to annotationId, "data" to data.toList()))
    }

    override fun onSnapshotComplete(result: Constants.QResult?, filename: String?) {
        callback("onSnapshotComplete", result?.value, filename)
    }

    override fun onAnnoRoleChanged(newRole: Constants.WBRoleType?) {
        callback("onAnnoRoleChanged", newRole?.value)
    }
}
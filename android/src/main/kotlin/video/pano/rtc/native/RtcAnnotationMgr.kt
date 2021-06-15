package video.pano.rtc.native

import com.pano.rtc.api.PanoAnnotationManager
import video.pano.rtc.native.api.IRtcAnnotationCreator
import video.pano.rtc.native.api.IRtcAnnotationManager
import video.pano.rtc.native.events.RtcAnnotationManagerEvent

class RtcAnnotationMgr(
        private val annotationCreator: IRtcAnnotationCreator?,
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : IRtcAnnotationManager {
    private var manager: PanoAnnotationManager? = null
    private val annoMap = HashMap<String, RtcAnnotation?>()

    fun setInnerMgr(manager: PanoAnnotationManager?) {
        this.manager = manager
        this.manager?.setCallback(RtcAnnotationManagerEvent { methodName, data ->
            emit(methodName, data)
        })
    }

    fun destroy() {
        annoMap.clear()
    }

    override fun getVideoAnnotation(params: Map<String, *>, callback: Callback) {
        val userId = (params["userId"] as String).toLong()
        val streamId = (params["streamId"] as Number).toInt()
        val annotationId = "$userId-$streamId"
        var annotation = annoMap[annotationId]
        if (annotation == null) {
            annotation = annotationCreator?.createAnnotation(annotationId, manager?.getVideoAnnotation(userId, streamId))
            annoMap[annotationId] = annotation
        }
        callback.success(annotationId)
    }

    override fun getShareAnnotation(params: Map<String, *>, callback: Callback) {
        val userId = (params["userId"] as String).toLong()
        val annotationId = userId.toString()
        var annotation = annoMap[annotationId]
        if (annotation == null) {
            annotation = annotationCreator?.createAnnotation(annotationId, manager?.getShareAnnotation(userId))
            annoMap[annotationId] = annotation
        }
        callback.success(annotationId)
    }

    fun getAnnotationById(annotationId: String): RtcAnnotation? {
        return annoMap[annotationId]
    }
}
package video.pano.rtc.native

import com.pano.rtc.api.PanoAnnotation
import com.pano.rtc.api.RtcWbView
import video.pano.rtc.native.api.IRtcAnnotation
import video.pano.rtc.native.events.RtcAnnotationEvent
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getWBFontStyle
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getWBRoleType
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getWBToolType

class RtcAnnotation(
        private val emit: (methodName: String, data: Map<String, Any?>?) -> Unit
) : IRtcAnnotation {

    private var annotation: PanoAnnotation? = null

    fun setInnerAnnotation(annotationId: String, annotation: PanoAnnotation?) {
        this.annotation = annotation
        annotation?.setCallback(RtcAnnotationEvent(annotationId) { methodName, data ->
            emit(methodName, data)
        })
    }

    override fun startAnnotation(params: Map<String, *>, callback: Callback) {
        val view = params["view"] as RtcWbView
        callback.success(annotation?.startAnnotation(view))
    }

    override fun stopAnnotation(callback: Callback) {
        callback.success(annotation?.stopAnnotation())
    }

    override fun setVisible(params: Map<String, *>, callback: Callback) {
        val visible = params["visible"] as Boolean
        callback.success(annotation?.setVisible(visible))
    }

    override fun setRoleType(params: Map<String, *>, callback: Callback) {
        val type = (params["type"] as Number).toInt()
        callback.success(annotation?.setRoleType(getWBRoleType(type)))
    }

    override fun setToolType(params: Map<String, *>, callback: Callback) {
        val type = (params["type"] as Number).toInt()
        callback.success(annotation?.setToolType(getWBToolType(type)))
    }

    override fun setLineWidth(params: Map<String, *>, callback: Callback) {
        val size = (params["size"] as Number).toInt()
        callback.success(annotation?.setLineWidth(size))
    }

    override fun setColor(params: Map<String, *>, callback: Callback) {
        val colorMap = params["color"] as Map<*, *>
        val red = (colorMap["red"] as Number).toFloat()
        val green = (colorMap["green"] as Number).toFloat()
        val blue = (colorMap["blue"] as Number).toFloat()
        val alpha = (colorMap["alpha"] as Number).toFloat()
        callback.success(annotation?.setColor(red, green, blue, alpha))
    }

    override fun setFontStyle(params: Map<String, *>, callback: Callback) {
        val style = (params["style"] as Number).toInt()
        callback.success(annotation?.setFontStyle(getWBFontStyle(style)))
    }

    override fun clearContents(params: Map<String, *>, callback: Callback) {
        callback.success(annotation?.clearContents())
    }

    override fun clearUserContents(params: Map<String, *>, callback: Callback) {
        val userId = (params["userId"] as String).toLong()
        callback.success(annotation?.clearUserContents(userId))
    }

    override fun undo(callback: Callback) {
        callback.success(annotation?.undo())
    }

    override fun redo(callback: Callback) {
        callback.success(annotation?.redo())
    }

    override fun snapshot(params: Map<String, *>, callback: Callback) {
        val outputDir = params["outputDir"] as String
        callback.success(annotation?.snapshot(outputDir))
    }
}
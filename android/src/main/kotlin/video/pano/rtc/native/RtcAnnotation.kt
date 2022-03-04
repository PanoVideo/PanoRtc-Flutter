package video.pano.rtc.native

import com.pano.rtc.api.PanoAnnotation
import com.pano.rtc.api.RtcWbView
import video.pano.rtc.native.api.IRtcAnnotation
import video.pano.rtc.native.events.RtcAnnotationEvent
import video.pano.rtc.native.utils.EnumValueConvert
import video.pano.rtc.native.utils.EnumValueConvert.StaticParams.getAnnoScalingMode
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

    override fun setFillType(params: Map<String, *>, callback: Callback) {
        val type = (params["type"] as Number).toInt()
        callback.success(annotation?.setFillType(EnumValueConvert.getWBFillType(type)))
    }

    override fun setFillColor(params: Map<String, *>, callback: Callback) {
        val colorMap = params["color"] as Map<*, *>
        val red = (colorMap["red"] as Number).toFloat()
        val green = (colorMap["green"] as Number).toFloat()
        val blue = (colorMap["blue"] as Number).toFloat()
        val alpha = (colorMap["alpha"] as Number).toFloat()
        val color = (alpha * 255.0f + 0.5f).toInt() shl 24 or
                ((red * 255.0f + 0.5f).toInt() shl 16) or
                ((green * 255.0f + 0.5f).toInt() shl 8) or
                (blue * 255.0f + 0.5f).toInt()
        callback.success(annotation?.setFillColor(color))
    }

    override fun setFontStyle(params: Map<String, *>, callback: Callback) {
        val style = (params["style"] as Number).toInt()
        callback.success(annotation?.setFontStyle(getWBFontStyle(style)))
    }

    override fun setFontSize(params: Map<String, *>, callback: Callback) {
        val size = (params["size"] as Number).toInt()
        callback.success(annotation?.setFontSize(size))
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

    override fun getToolType(callback: Callback) {
        callback.success(annotation?.toolType?.value)
    }

    override fun setAspectSize(params: Map<String, *>, callback: Callback) {
        val width = (params["width"] as Number).toInt()
        val height = (params["height"] as Number).toInt()
        callback.success(annotation?.setAspectSize(width, height))
    }

    override fun setScalingMode(params: Map<String, *>, callback: Callback) {
        val mode = (params["mode"] as Number).toInt()
        callback.success(annotation?.setScalingMode(getAnnoScalingMode(mode)))
    }

    override fun setOption(params: Map<String, *>, callback: Callback) {
        when ((params["type"] as Number).toInt()) {
            1 -> { //EnableLocalRender
                val option = params["option"] as Boolean
                callback.success(annotation?.enableLocalRender(option))
            }
            2 -> { //EnableShowDraws
                val option = params["option"] as Boolean
                callback.success(annotation?.enableShowDraws(option))
            }
            3 -> { //EnableUIResponse
                val option = params["option"] as Boolean
                callback.success(annotation?.enableUIResponse(option))
            }
            4 -> { //EnableCursorposSync
                val option = params["option"] as Boolean
                callback.success(annotation?.enableCursorPosSync(option))
            }
            5 -> { //EnableShowRemoteCursor
                val option = params["option"] as Boolean
                callback.success(annotation?.enableShowRemoteCursor(option))
            }
        }
    }
}
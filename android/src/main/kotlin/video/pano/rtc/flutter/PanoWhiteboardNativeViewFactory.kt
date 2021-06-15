package video.pano.rtc.flutter

import android.content.Context
import android.view.View
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import video.pano.rtc.PanoRtcPlugin
import video.pano.rtc.native.Callback
import video.pano.rtc.native.RtcWhiteboardView
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

class PanoWhiteboardNativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return when {
            PanoRtcPlugin.activity != null -> {
                PanoWhiteboardNativeView(PanoRtcPlugin.activity!!, viewId)
            }
            else -> {
                PanoWhiteboardNativeView(context, viewId)
            }
        }
    }
}

class PanoWhiteboardNativeView(context: Context, viewId: Int) : PlatformView,
        MethodChannel.MethodCallHandler {
    private val view = RtcWhiteboardView(context)
    private val methodChannel = PanoRtcPlugin
            .createMethodChannel("pano_rtc/whiteboard_surface_view_$viewId")

    init {
        methodChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        this::class.declaredMemberFunctions.find { it.name == call.method }?.let { function ->
            function.javaMethod?.let { method ->
                try {
                    val parameters = mutableListOf<Any?>()
                    call.arguments<Map<*, *>>()?.toMutableMap()?.let {
                        parameters.add(it)
                    }
                    method.invoke(this, *parameters.toTypedArray(), ResultCallback(result))
                    return@onMethodCall
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
        result.notImplemented()
    }

    override fun getView(): View {
        return view
    }

    override fun dispose() {
        methodChannel.setMethodCallHandler(null)
    }

    fun open(params: Map<String, *>, callback: Callback) {
        val whiteboardId = params["whiteboardId"] as String
        val whiteboardEngine = PanoRtcPlugin.engineManager().getRtcWhiteboardEngine(whiteboardId)
        view.open(whiteboardEngine, mapOf("view" to view.attachRtcWbView), callback)
    }

    fun startAnnotation(params: Map<String, *>, callback: Callback) {
        val channelId = params["channelId"] as String
        val annotation = PanoRtcPlugin.engineManager().annotationMgr?.getAnnotationById(channelId)
        view.startAnnotation(annotation, mapOf("view" to view.attachRtcWbView), callback)
    }

}
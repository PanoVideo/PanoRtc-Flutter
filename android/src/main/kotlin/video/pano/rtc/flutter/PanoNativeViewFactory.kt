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
import video.pano.rtc.native.RtcSurfaceView
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

class PanoNativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return PanoNativeView(context, viewId)
    }
}

class PanoNativeView(context: Context, viewId: Int) : PlatformView, MethodChannel.MethodCallHandler {
    private val view = RtcSurfaceView(context)
    private var methodChannel: MethodChannel = PanoRtcPlugin
            .createMethodChannel("pano_rtc/view_surface_$viewId")

    init {
        methodChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        this::class.declaredMemberFunctions.find { it.name == call.method }?.let { function ->
            function.javaMethod?.let { method ->
                try {
                    val parameters = mutableListOf<Any?>()
                    call.arguments<Map<*, *>>()?.toMutableMap()?.let {
                        it["view"] = view.getChildAt(0)
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

    fun startVideo(params: Map<String, *>, callback: Callback) {
        view.startVideo(PanoRtcPlugin.engineManager(), params, callback)
    }

    fun subscribeVideo(params: Map<String, *>, callback: Callback) {
        view.subscribeVideo(PanoRtcPlugin.engineManager(), params, callback)
    }

    fun startPreview(params: Map<String, *>, callback: Callback) {
        view.startPreview(PanoRtcPlugin.engineManager(), params, callback)
    }

    fun subscribeScreen(params: Map<String, *>, callback: Callback) {
        view.subscribeScreen(PanoRtcPlugin.engineManager(), params, callback)
    }

    fun startVideoWithStreamId(params: Map<String, *>, callback: Callback) {
        view.startVideoWithStreamId(PanoRtcPlugin.engineManager().videoStreamMgr, params, callback)
    }

    fun subscribeVideoWithStreamId(params: Map<String, *>, callback: Callback) {
        view.subscribeVideoWithStreamId(PanoRtcPlugin.engineManager().videoStreamMgr, params, callback)
    }
}
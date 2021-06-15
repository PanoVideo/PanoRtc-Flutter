package video.pano.rtc.flutter

import com.pano.rtc.api.PanoAnnotation
import com.pano.rtc.api.PanoAnnotationManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import video.pano.rtc.PanoRtcPlugin
import video.pano.rtc.native.RtcAnnotation
import video.pano.rtc.native.RtcAnnotationMgr
import video.pano.rtc.native.api.IRtcAnnotationCreator
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

class RtcAnnotationMgrWrapper(panoAnnotationManager: PanoAnnotationManager?) : FlutterWrapper(), IRtcAnnotationCreator {

    val manager = RtcAnnotationMgr(this, this@RtcAnnotationMgrWrapper::emit)
    private val rtcAnnotationWrapper = RtcAnnotationWrapper()

    init {
        manager.setInnerMgr(panoAnnotationManager)
        methodChannel = PanoRtcPlugin.createMethodChannel("pano_rtc/api_annotationMgr")
        eventChannel = PanoRtcPlugin.createEventChannel("pano_rtc/events_annotationMgr")
        methodChannel.setMethodCallHandler(this)
        eventChannel?.setStreamHandler(this)
    }

    override fun onDetachedFromEngine() {
        super.onDetachedFromEngine()
        rtcAnnotationWrapper.onDetachedFromEngine()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        manager::class.declaredMemberFunctions.find { it.name == call.method }?.let { function ->
            function.javaMethod?.let { method ->
                try {
                    val parameters = mutableListOf<Any?>()
                    call.arguments<Map<*, *>>()?.toMutableMap()?.let {
                        parameters.add(it)
                    }
                    method.invoke(manager, *parameters.toTypedArray(), ResultCallback(result))
                    return@onMethodCall
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
        result.notImplemented()
    }

    override fun createAnnotation(annotationId: String, panoAnnotation: PanoAnnotation?): RtcAnnotation? {
        return rtcAnnotationWrapper.createAnnotation(annotationId, panoAnnotation)
    }
}
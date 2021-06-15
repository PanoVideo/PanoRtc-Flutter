package video.pano.rtc.flutter

import com.pano.rtc.api.PanoAnnotation
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import video.pano.rtc.PanoRtcPlugin
import video.pano.rtc.native.RtcAnnotation
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

class RtcAnnotationWrapper : FlutterWrapper() {

    init {
        methodChannel = PanoRtcPlugin.createMethodChannel("pano_rtc/api_annotation")
        eventChannel = PanoRtcPlugin.createEventChannel("pano_rtc/events_annotation")
        methodChannel.setMethodCallHandler(this)
        eventChannel?.setStreamHandler(this)
    }

    fun createAnnotation(annotationId: String, panoAnnotation: PanoAnnotation?): RtcAnnotation {
        val annotation = RtcAnnotation(this@RtcAnnotationWrapper::emit)
        annotation.setInnerAnnotation(annotationId, panoAnnotation)
        return annotation
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val argumentsMap = call.arguments<MutableMap<*, *>>()
        val annotationId = argumentsMap["annotationId"] as String
        val annotation = PanoRtcPlugin.engineManager().annotationMgr?.getAnnotationById(annotationId)
        argumentsMap.remove("annotationId")
        annotation?.let {
            annotation::class.declaredMemberFunctions.find { it.name == call.method }?.let { function ->
                function.javaMethod?.let { method ->
                    try {
                        val parameters = mutableListOf<Any?>()
                        if (argumentsMap.isNotEmpty()) {
                            parameters.add(argumentsMap)
                        }
                        method.invoke(annotation, *parameters.toTypedArray(), ResultCallback(result))
                        return@onMethodCall
                    } catch (e: Exception) {
                        e.printStackTrace()
                    }
                }
            }
        }
        result.notImplemented()
    }
}
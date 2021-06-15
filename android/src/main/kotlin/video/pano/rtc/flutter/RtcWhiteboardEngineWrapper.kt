package video.pano.rtc.flutter

import com.pano.rtc.api.RtcWhiteboard
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import video.pano.rtc.PanoRtcPlugin
import video.pano.rtc.native.RtcWhiteboardEngine
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

class RtcWhiteboardEngineWrapper : FlutterWrapper() {

    init {
        methodChannel = PanoRtcPlugin.createMethodChannel("pano_rtc/api_whiteboard")
        eventChannel = PanoRtcPlugin.createEventChannel("pano_rtc/events_whiteboard")
        methodChannel.setMethodCallHandler(this)
        eventChannel?.setStreamHandler(this)
    }

    fun createWhiteboardEngine(whiteboardId: String, whiteboard: RtcWhiteboard?): RtcWhiteboardEngine {
        val whiteboardEngine = RtcWhiteboardEngine(this@RtcWhiteboardEngineWrapper::emit)
        whiteboardEngine.setInnerWhiteboard(whiteboardId, whiteboard)
        return whiteboardEngine
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val argumentsMap = call.arguments<MutableMap<*, *>>()
        val whiteboardId = argumentsMap["whiteboardId"] as String
        val whiteboard = PanoRtcPlugin.engineManager().getRtcWhiteboardEngine(whiteboardId)
        argumentsMap.remove("whiteboardId")
        whiteboard?.let {
            whiteboard::class.declaredMemberFunctions.find { it.name == call.method }?.let { function ->
                function.javaMethod?.let { method ->
                    try {
                        val parameters = mutableListOf<Any?>()
                        if (argumentsMap.isNotEmpty()) {
                            parameters.add(argumentsMap)
                        }
                        method.invoke(whiteboard, *parameters.toTypedArray(), ResultCallback(result))
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
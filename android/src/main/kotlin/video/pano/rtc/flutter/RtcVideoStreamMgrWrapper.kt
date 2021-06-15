package video.pano.rtc.flutter

import com.pano.rtc.api.RtcVideoStreamManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import video.pano.rtc.PanoRtcPlugin
import video.pano.rtc.native.RtcVideoStreamMgr
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

class RtcVideoStreamMgrWrapper(rtcVideoStreamManager: RtcVideoStreamManager?): FlutterWrapper() {

    val manager = RtcVideoStreamMgr(this@RtcVideoStreamMgrWrapper::emit)

    init {
        manager.setInnerMgr(rtcVideoStreamManager)
        methodChannel = PanoRtcPlugin.createMethodChannel("pano_rtc/api_video_streamMgr")
        eventChannel = PanoRtcPlugin.createEventChannel("pano_rtc/events_video_streamMgr")
        methodChannel.setMethodCallHandler(this)
        eventChannel?.setStreamHandler(this)
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
}
package video.pano.rtc.flutter

import com.pano.rtc.api.RtcMessageService
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import video.pano.rtc.PanoRtcPlugin
import video.pano.rtc.native.RtcMessageSrv
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

class RtcMessageSrvWrapper(rtcMessageService: RtcMessageService?): FlutterWrapper() {

    val server = RtcMessageSrv(this@RtcMessageSrvWrapper::emit)

    init {
        server.setInnerMgr(rtcMessageService)
        methodChannel = PanoRtcPlugin.createMethodChannel("pano_rtc/api_rtm")
        eventChannel = PanoRtcPlugin.createEventChannel("pano_rtc/events_rtm")
        methodChannel.setMethodCallHandler(this)
        eventChannel?.setStreamHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        server::class.declaredMemberFunctions.find { it.name == call.method }?.let { function ->
            function.javaMethod?.let { method ->
                try {
                    val parameters = mutableListOf<Any?>()
                    call.arguments<Map<*, *>>()?.toMutableMap()?.let {
                        parameters.add(it)
                    }
                    method.invoke(server, *parameters.toTypedArray(), ResultCallback(result))
                    return@onMethodCall
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
        result.notImplemented()
    }

}
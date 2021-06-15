package video.pano.rtc.flutter

import com.pano.rtc.api.RtcNetworkManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import video.pano.rtc.PanoRtcPlugin
import video.pano.rtc.native.RtcNetworkMgr
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

class RtcNetworkMgrWrapper(rtcNetworkManager: RtcNetworkManager?) : FlutterWrapper() {

    val manager = RtcNetworkMgr(this@RtcNetworkMgrWrapper::emit)

    init {
        manager.setInnerMgr(rtcNetworkManager)
        methodChannel = PanoRtcPlugin.createMethodChannel("pano_rtc/api_networkMgr")
        eventChannel = PanoRtcPlugin.createEventChannel("pano_rtc/events_networkMgr")
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
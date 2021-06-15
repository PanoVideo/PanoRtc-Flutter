package video.pano.rtc.flutter

import com.pano.rtc.api.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import video.pano.rtc.PanoRtcPlugin
import video.pano.rtc.native.*
import video.pano.rtc.native.api.IRtcManagerCreator
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

class RtcEngineManagerWrapper : FlutterWrapper(), IRtcManagerCreator {

    val manager = RtcEngineManager(this, this@RtcEngineManagerWrapper::emit)
    private val rtcWhiteboardEngineWrapper = RtcWhiteboardEngineWrapper()
    private var rtcAnnotationMgrWrapper: RtcAnnotationMgrWrapper? = null
    private var rtcNetworkMgrWrapper: RtcNetworkMgrWrapper? = null
    private var rtcVideoStreamMgrWrapper: RtcVideoStreamMgrWrapper? = null
    private var rtcMessageServiceWrapper: RtcMessageSrvWrapper? = null

    init {
        methodChannel = PanoRtcPlugin.createMethodChannel("pano_rtc/api_engine")
        eventChannel = PanoRtcPlugin.createEventChannel("pano_rtc/events_engine")
        methodChannel.setMethodCallHandler(this)
        eventChannel?.setStreamHandler(this)
    }

    override fun onDetachedFromEngine() {
        super.onDetachedFromEngine()

        rtcWhiteboardEngineWrapper.onDetachedFromEngine()
        rtcAnnotationMgrWrapper?.onDetachedFromEngine()
        rtcNetworkMgrWrapper?.onDetachedFromEngine()
        rtcVideoStreamMgrWrapper?.onDetachedFromEngine()
        rtcMessageServiceWrapper?.onDetachedFromEngine()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        manager::class.declaredMemberFunctions.find { it.name == call.method }?.let { function ->
            function.javaMethod?.let { method ->
                try {
                    val parameters = mutableListOf<Any?>()
                    call.arguments<Map<*, *>>()?.toMutableMap()?.let {
                        if (call.method == "create") {
                            it["context"] = PanoRtcPlugin.appContext
                        }
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

    override fun createWhiteboardEngine(whiteboardId: String, whiteboard: RtcWhiteboard?): RtcWhiteboardEngine? {
        return rtcWhiteboardEngineWrapper.createWhiteboardEngine(whiteboardId, whiteboard)
    }

    override fun createAnnotationMgr(manager: PanoAnnotationManager?): RtcAnnotationMgr? {
        rtcAnnotationMgrWrapper = RtcAnnotationMgrWrapper(manager)
        return rtcAnnotationMgrWrapper?.manager
    }

    override fun createNetworkMgr(manager: RtcNetworkManager?): RtcNetworkMgr? {
        rtcNetworkMgrWrapper = RtcNetworkMgrWrapper(manager)
        return rtcNetworkMgrWrapper?.manager
    }

    override fun createVideoStreamMgr(manager: RtcVideoStreamManager?): RtcVideoStreamMgr? {
        rtcVideoStreamMgrWrapper = RtcVideoStreamMgrWrapper(manager)
        return rtcVideoStreamMgrWrapper?.manager
    }

    override fun createRtcMessageSrv(service: RtcMessageService?): RtcMessageSrv? {
        rtcMessageServiceWrapper = RtcMessageSrvWrapper(service)
        return rtcMessageServiceWrapper?.server
    }
}
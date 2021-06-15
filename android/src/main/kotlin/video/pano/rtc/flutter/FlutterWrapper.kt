package video.pano.rtc.flutter

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

abstract class FlutterWrapper : MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    protected lateinit var methodChannel: MethodChannel
    protected var eventChannel: EventChannel? = null
    private var eventSink: EventChannel.EventSink? = null
    private val handler = Handler(Looper.getMainLooper())

    protected fun emit(methodName: String, data: Map<String, Any?>?) {
        val event: MutableMap<String, Any?> = mutableMapOf("methodName" to methodName)
        data?.let { event.putAll(it) }

        handler.post{
            eventSink?.success(event)
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    open fun onDetachedFromEngine() {
        methodChannel.setMethodCallHandler(null)
        eventChannel?.setStreamHandler(null)
    }
}
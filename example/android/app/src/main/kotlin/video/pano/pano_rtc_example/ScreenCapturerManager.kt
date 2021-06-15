package video.pano.pano_rtc_example

import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ScreenCapturerManager(messenger: BinaryMessenger, private val context : Context) :
        MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    private var methodChannel = MethodChannel(messenger, "screen_capturer")
    private val screenCaptureService = Intent(context, ScreenCaptureService::class.java)

    init {
        methodChannel.setMethodCallHandler(this)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "start_service") {
            context.startForegroundService(screenCaptureService)
        } else if (call.method == "stop_service") {
            context.stopService(screenCaptureService)
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    }

    override fun onCancel(arguments: Any?) {
    }

    open fun onDetachedFromEngine() {
        methodChannel.setMethodCallHandler(null)
    }
}
package video.pano.rtc

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import video.pano.rtc.native.RtcEngineManager
import video.pano.rtc.flutter.PanoNativeViewFactory
import video.pano.rtc.flutter.PanoWhiteboardNativeViewFactory
import video.pano.rtc.flutter.RtcEngineManagerWrapper

class PanoRtcPlugin : FlutterPlugin, ActivityAware {

    companion object {
        lateinit var binding: FlutterPlugin.FlutterPluginBinding
        lateinit var engineManagerWrapper: RtcEngineManagerWrapper
        lateinit var appContext: Context
        var activity: Activity? = null

        fun engineManager(): RtcEngineManager {
            return engineManagerWrapper.manager
        }

        fun createMethodChannel(name: String): MethodChannel {
            return MethodChannel(binding.binaryMessenger, name)
        }

        fun createEventChannel(name: String): EventChannel {
            return EventChannel(binding.binaryMessenger, name)
        }
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        binding = flutterPluginBinding
        appContext = flutterPluginBinding.applicationContext
        flutterPluginBinding.platformViewRegistry.registerViewFactory("PanoNativeView",
                PanoNativeViewFactory())
        flutterPluginBinding.platformViewRegistry.registerViewFactory("PanoWhiteboardNativeView",
                PanoWhiteboardNativeViewFactory())
        engineManagerWrapper = RtcEngineManagerWrapper()
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        engineManagerWrapper.onDetachedFromEngine()
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }
}



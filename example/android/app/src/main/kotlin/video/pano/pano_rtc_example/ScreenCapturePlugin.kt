package video.pano.pano_rtc_example

import io.flutter.embedding.engine.plugins.FlutterPlugin

class ScreenCapturePlugin: FlutterPlugin {

    lateinit var screenCapturerManager: ScreenCapturerManager

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        screenCapturerManager = ScreenCapturerManager(binding.binaryMessenger, binding.applicationContext)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        screenCapturerManager.onDetachedFromEngine()
    }
}
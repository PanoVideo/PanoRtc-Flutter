package video.pano.rtc.native

import android.content.Context
import android.widget.FrameLayout
import com.pano.rtc.api.RtcView
import video.pano.RendererCommon.RendererEvents

class RtcSurfaceView(context: Context) : FrameLayout(context) {

    private var rtcView : RtcView = RtcView(context)

    init {
        rtcView.init(object : RendererEvents {
            override fun onFirstFrameRendered() {}
            override fun onFrameResolutionChanged(i: Int, i1: Int, i2: Int) {}
        })
        addView(rtcView)
    }

    fun startVideo(engine: RtcEngineManager?, params: Map<String, *>, callback: Callback) {
        engine?.startVideo(params, callback)
    }

    fun subscribeVideo(engine: RtcEngineManager?, params: Map<String, *>, callback: Callback) {
        engine?.subscribeVideo(params, callback)
    }

    fun startPreview(engine: RtcEngineManager?, params: Map<String, *>, callback: Callback) {
        engine?.startPreview(params, callback)
    }

    fun subscribeScreen(engine: RtcEngineManager?, params: Map<String, *>, callback: Callback) {
        engine?.subscribeScreen(params, callback)
    }

    fun startVideoWithStreamId(engine: RtcVideoStreamMgr?, params: Map<String, *>, callback: Callback) {
        engine?.startVideo(params, callback)
    }

    fun subscribeVideoWithStreamId(engine: RtcVideoStreamMgr?, params: Map<String, *>, callback: Callback) {
        engine?.subscribeVideo(params, callback)
    }
}